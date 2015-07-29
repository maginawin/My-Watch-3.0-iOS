//
//  WMSettingVC.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/29.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMSettingVC.h"

@interface WMSettingVC () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) NSArray *cellTitles;
@property (strong, nonatomic) NSDictionary *titles;

@end

@implementation WMSettingVC

// Key for titles
NSString *kCellUserInfo = @"kCellUserInfo";
NSString *kCellStepTarget = @"kCellStepTarget";
NSString *kCellSleep = @"kCellSleep";
NSString *kCellAntiLost = @"kCellAntiLost";
NSString *kCellHelp = @"kCellHelp";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureViews];
}

#pragma mark - Table View 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int cellCount = 0;
    
    switch (section) {
        case 0: {
            cellCount = 1;
            break;
        }
        case 1: {
            cellCount = 3;
            break;
        }
        case 2: {
            cellCount = 1;
            break;
        }
    }
    
    return cellCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 21.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdFromIndexPath:indexPath]];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[self cellIdFromIndexPath:indexPath]];
    }
    
    // 给 Cell 的 subview 赋值
    switch (indexPath.section) {
        case 0: {
            // User info cell
            cell.textLabel.text = [_titles valueForKey:kCellUserInfo];
            break;
        }
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    // Step taget cell
                    cell.textLabel.text = [_titles valueForKey:kCellStepTarget];
                    break;
                }
                case 1: {
                    // Sleep cell
                    cell.textLabel.text = [_titles valueForKey:kCellSleep];
                    break;
                }
                case 2: {
                    // Anti lost cell
                    UILabel *aLabel = (UILabel *)[cell viewWithTag:31];
                    aLabel.text = [_titles valueForKey:kCellAntiLost];
                    break;
                }
            }
            break;
        }
        case 2: {
            // Help cell
            cell.textLabel.text = [_titles valueForKey:kCellHelp];
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

// 根据传入的 indexPath 返回 Cell ID
- (NSString *)cellIdFromIndexPath:(NSIndexPath *)indexPath {
    int actualCell = 0;
    
    switch (indexPath.section) {
        case 1: {
            switch (indexPath.row) {
                case 0:
                    actualCell = 1;
                    break;
                case 1: {
                    actualCell = 2;
                    break;
                }
                case 2: {
                    actualCell = 3;
                    break;
                }
            }
            break;
        }
        case 2: {
            actualCell = 4;
            break;
        }
    }
    
    return [NSString stringWithFormat:@"idCell%d", actualCell];
}


#pragma mark - Configure

- (void)configureViews {
    // 配置基础数据
    _cellTitles = @[NSLocalizedString(@"cellUserInfo", @""), NSLocalizedString(@"cellStepTarget", @""), NSLocalizedString(@"cellSleep", @""), NSLocalizedString(@"cellAntiLost", @""), NSLocalizedString(@"cellHelp", @"")];
    
    _titles = @{kCellUserInfo : NSLocalizedString(@"cellUserInfo", @""), kCellStepTarget : NSLocalizedString(@"cellStepTarget", @""), kCellSleep : NSLocalizedString(@"cellSleep", @""), kCellAntiLost : NSLocalizedString(@"cellAntiLost", @""), kCellHelp : NSLocalizedString(@"cellHelp", @"")};
    
    // 配置蓝牙表格
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.tableFooterView = [[UIView alloc] init];
}

@end
