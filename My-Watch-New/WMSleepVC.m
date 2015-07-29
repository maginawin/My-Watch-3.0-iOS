//
//  WMSleepVC.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/14.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMSleepVC.h"
#import "WMSleepDataBar.h"

const CGFloat kLineWidth = 8.f;

@interface WMSleepVC ()

@property (weak, nonatomic) IBOutlet UIView *sleepDataView;
@property (strong, nonatomic) NSMutableArray *bars;

@end

@implementation WMSleepVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureSleepDataView];
    
    NSMutableArray *currents = [NSMutableArray array];
    for (int i = 0; i < 25; i++) {
        int current = arc4random() % 11;
        float currentF = current / 10.f;
        NSNumber *currentNum = [NSNumber numberWithFloat:currentF];
        [currents addObject:currentNum];
    }
    
    [self updateBarsCurrents:currents];
}

/**
 * @brief 更新 Sleep Data View Bars Current
 * @param currents : 从昨天 20:00 ~ 今天 24:00 每个小时, 共计 25 个小时的 Sleep Quality (NSNumber *)Current (NSArray *)currents
 */
- (void)updateBarsCurrents:(NSArray *)currents {
    if (currents.count == 25) {
        for (int i = 0; i < 25; i++) {
            CGFloat current = [currents[i] floatValue];
            
            WMSleepDataBar *bar = _bars[i];
            if (bar) {
                [bar updateCurrent:current];
            }
        }
    }
}

- (void)configureSleepDataView {
    CGFloat width = CGRectGetWidth(_sleepDataView.bounds);
    CGFloat height = CGRectGetHeight(_sleepDataView.bounds);
    
    // 添加 Labels
    CGFloat everyLabelWidth = width / 7.f;
    for (int i = 0; i < 7; i++) {
        CGRect labelRect = CGRectMake(everyLabelWidth * i, height - 21.f, everyLabelWidth, 21.f);
        UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:11.f];
        label.textAlignment = NSTextAlignmentCenter;
        int hour = ((i + 5) % 6) * 4;
        NSString *hourStr = [NSString stringWithFormat:@"%d:00", hour];
        label.text = hourStr;
        label.alpha = 0.8f;
        [_sleepDataView addSubview:label];
    }
    
    // 添加一个 Best 标签
    UILabel *bestLabel = [[UILabel alloc] initWithFrame:CGRectMake(4.f, 0, 44.f, 21.f)];
    bestLabel.text = NSLocalizedString(@"best", @"Best");
    bestLabel.textAlignment = NSTextAlignmentLeft;
    bestLabel.textColor = [UIColor whiteColor];
    bestLabel.font = [UIFont italicSystemFontOfSize:11.f];
    bestLabel.alpha = 0.8f;
    [_sleepDataView addSubview:bestLabel];
    
    // 添加线
    CALayer *bottomLineLayer = [CALayer layer];
    bottomLineLayer.frame = CGRectMake(0, height - 21, width, 1.0f);
    bottomLineLayer.backgroundColor = [UIColor whiteColor].CGColor;
    bottomLineLayer.opacity = 0.8f;
    [_sleepDataView.layer addSublayer:bottomLineLayer];
    
    CGFloat lineHeightInterval = (height - 21.f) / 5.f;
    for (int i = 0; i < 5; i++) {
        CGRect lineRect = CGRectMake(0, i * lineHeightInterval, width, 0.5f);
        CALayer *normalLine = [CALayer layer];
        normalLine.backgroundColor = [UIColor whiteColor].CGColor;
        normalLine.frame = lineRect;
        normalLine.opacity = 0.1f;
        [_sleepDataView.layer addSublayer:normalLine];
    }
    
    // 添加 Bars (25 条)
    _bars = [NSMutableArray array];
    CGFloat everyBarWidth = everyLabelWidth / 4.f;
    for (int i = 0; i < 25; i++) {
        WMSleepDataBar *bar = [WMSleepDataBar layer];
        bar.frame = CGRectMake(((2 + i) * everyBarWidth) - (kLineWidth / 2.f), 0, kLineWidth, height - 21.f);
        bar.opacity = 0.85f;
        
        [bar configurePathWithColors:@[(id)[UIColor whiteColor].CGColor, (id)[UIColor colorWithRed:192.f/255.f green:76.f/255.f blue:145.f/255.f alpha:1.f].CGColor]];
        [_sleepDataView.layer addSublayer:bar];
        
        [_bars addObject:bar];
    }
}

@end
