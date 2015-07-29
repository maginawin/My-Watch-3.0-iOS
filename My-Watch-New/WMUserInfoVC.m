//
//  WMUserInfoVC.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/29.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMUserInfoVC.h"

// Cell id
NSString * const kUserInfoCell0 = @"idUserInfoCell1"; // 步幅, 身高, 体重, 年龄
NSString * const kUserInfoCell1 = @"idUserInfoCell2"; // 性别

@interface WMUserInfoVC () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView; // 设置表格

@end

@implementation WMUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
    
    // 模拟键盘弹出时视图上升
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _mTableView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0);
    });
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger actual = 0;
    
    switch (section) {
        case 0: {
            // 步幅
            actual = 1;
            break;
        }
        case 1: {
            // 身高, 体重
            actual = 2;
            break;
        }
        case 2: {
            // 年龄, 性别
            actual = 2;
            break;
        }
    }
    
    return actual;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *idCell = kUserInfoCell0;
    
    switch (indexPath.section) {
        case 2: {
            switch (indexPath.row) {
                case 1: {
                    // Gender
                    idCell = kUserInfoCell1;
                    break;
                }
            }
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idCell];
    }
    
    switch (indexPath.section) {
        case 0: {
            // Stride
            
            break;
        }
        case 1: {
            switch (indexPath.section) {
                case 0: {
                    // Height
                    
                    break;
                }
                case 1: {
                    // Weight
                    
                    break;
                }
            }
            break;
        }
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    // Age
                    
                    break;
                }
                case 1: {
                    // Gender
                    
                    break;
                }
            }
        }
    }
    
    return cell;
}

#pragma mark - Configure

- (void)configureViews {
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.tableFooterView = [[UIView alloc] init];
}

- (void)configureNofication {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 可以不添加键盘监听, 在 Age Editing 时升高 TableView 就可以
    
    // 添加键盘打开与关闭的监听, 解决 4S 下年龄输入被挡的尴尬
}

@end
