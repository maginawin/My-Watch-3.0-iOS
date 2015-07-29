//
//  WMMoreVC.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/14.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMMoreVC.h"

@interface WMMoreVC ()

@end

@implementation WMMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
    vc.hidesBottomBarWhenPushed = YES;
}

@end
