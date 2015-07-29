//
//  WMSleepDataBar.h
//  MyWatchF
//
//  Created by maginawin on 15/7/13.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface WMSleepDataBar : CAGradientLayer

- (void)configurePathWithColors:(NSArray *)colors;

- (void)updateCurrent:(CGFloat)current;

@end
