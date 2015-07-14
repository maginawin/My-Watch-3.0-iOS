//
//  WMBaseTBC.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/14.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMBaseTBC.h"

@interface WMBaseTBC ()

@end

@implementation WMBaseTBC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.selectedImageTintColor = [UIColor whiteColor];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"transparence"];

    NSArray* selectedImageNames = @[@"tab_pedo_selected", @"tab_sleep_selected", @"tab_hr_selected", @"tab_more_selected"];
    NSArray* imageNames = @[@"tab_pedo_normal", @"tab_sleep_normal", @"tab_hr_normal", @"tab_more_normal"];
    
    NSArray* items = self.tabBar.items;
    
    if (items.count != 4) {
        return;
    }
    
    for (int i = 0; i < items.count; i++) {
        UITabBarItem* item = items[i];
        // 设置选中图片
        item.selectedImage = [[UIImage imageNamed:selectedImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 设置默认图片
        item.image = [[UIImage imageNamed:imageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 设置默认字颜色
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.2f]} forState:UIControlStateNormal];
        // 设置选中字颜色
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    }
}

@end
