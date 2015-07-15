//
//  WMPedoVC.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/14.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMPedoVC.h"

@interface WMPedoVC ()

@property (weak, nonatomic) IBOutlet UIImageView *pedoProgressView;
@property (strong, nonatomic) CAShapeLayer *pedoProgressMaskLayer;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation WMPedoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configurePedoProgressView];
    [self configureBottomView];
    
    [self updatePedoProgressCurrent:0.7f];
}

- (void)updatePedoProgressCurrent:(CGFloat)current {
    if (current < 0) {
        current = 0;
    } else if (current > 1.f) {
        current = 1.f;
    }
    
    _pedoProgressMaskLayer.strokeEnd = current;
}

- (void)configurePedoProgressView {
    if (!_pedoProgressMaskLayer) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path addArcWithCenter:_pedoProgressView.center radius:CGRectGetWidth(_pedoProgressView.bounds) / 2.f startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
        
        _pedoProgressMaskLayer = [CAShapeLayer layer];
        _pedoProgressMaskLayer.path = path.CGPath;
    }
    
    _pedoProgressMaskLayer.lineWidth = 20.f;
    _pedoProgressMaskLayer.strokeColor = [UIColor whiteColor].CGColor;
    _pedoProgressMaskLayer.fillColor = [UIColor clearColor].CGColor;
    _pedoProgressMaskLayer.strokeStart = 0.f;
    _pedoProgressMaskLayer.strokeEnd = 0.f;
    
    _pedoProgressView.layer.mask = _pedoProgressMaskLayer;
}

- (void)configureBottomView {
    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    [linePath moveToPoint:CGPointMake(0, 96.f)];
    [linePath addLineToPoint:CGPointMake(220.f, 96.f)];
    [linePath moveToPoint:CGPointMake(106.f, 8.f)];
    [linePath addLineToPoint:CGPointMake(106.f, 184.f)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = linePath.CGPath;
    lineLayer.lineWidth = .5f;
    lineLayer.strokeColor = [UIColor whiteColor].CGColor;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.opacity = .2f;
    
    [_bottomView.layer addSublayer:lineLayer];
}

@end
