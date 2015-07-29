//
//  WMSleepDataBar.m
//  MyWatchF
//
//  Created by maginawin on 15/7/13.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import "WMSleepDataBar.h"

@interface WMSleepDataBar()

@property (strong, nonatomic) CAShapeLayer *maskLayer;

@end

@implementation WMSleepDataBar

- (void)configurePathWithColors:(NSArray *)colors {
    self.colors = colors;
    self.startPoint = CGPointMake(0.5f, 1.f);
    self.endPoint = CGPointMake(0.5f, 0.f);
    
    UIBezierPath *aPath = [[UIBezierPath alloc] init];
    [aPath moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds))];
    [aPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) / 2.f, 0.f)];
    
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.path = aPath.CGPath;
    _maskLayer.lineWidth = CGRectGetWidth(self.bounds);
    _maskLayer.strokeColor = [UIColor whiteColor].CGColor;
    _maskLayer.strokeStart = 0.f;
    _maskLayer.strokeEnd = 0.f;
    
    self.mask = _maskLayer;
}

- (void)updateCurrent:(CGFloat)current {
    if (current < 0.f) {
        current = 0.f;
    } else if (current > 1.f) {
        current = 1.f;
    }
    
    _maskLayer.strokeEnd = current;
}

@end
