//
//  WMBaseNC.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/14.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMBaseNC.h"

@interface WMBaseNC ()

@end

@implementation WMBaseNC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationBar setTranslucent:YES];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"transparence"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}

@end
