//
//  WMSettingVC.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/29.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMSettingVC.h"

// Key for titles
NSString *const kCellUserInfo = @"kCellUserInfo";
NSString *const kCellStepTarget = @"kCellStepTarget";
NSString *const kCellSleep = @"kCellSleep";
NSString *const kCellAntiLost = @"kCellAntiLost";
NSString *const kCellHelp = @"kCellHelp";
NSString *const kCellBinding = @"kCellBinding";

// Id for segues
NSString * const kSetToUserInfo = @"idSetToUserInfo";

@interface WMSettingVC () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView; // Ble table view
@property (strong, nonatomic) NSDictionary *titles; // Cell titles

@end

@implementation WMSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // 配置数据与基础视图
    [self configureViews];
}

#pragma mark - Table View 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    // User info
                    [self performSegueWithIdentifier:kSetToUserInfo sender:self];
                    
                    break;
                }
                case 1: {
                    // Binding device
                    
                    break;
                }
            }
            break;
        }
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    // Step target
                    
                    break;
                }
                case 1: {
                    // Sleep
                    
                    break;
                }
            }
            break;
        }
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    // Help
                    
                    break;
                }
            }
            break;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int cellCount = 0;
    
    switch (section) {
        case 0: {
            cellCount = 2;
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

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 30.f;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *header = [[UIView alloc] init];
//    header.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    return header;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdFromIndexPath:indexPath]];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[self cellIdFromIndexPath:indexPath]];
    }
    
    // 给 Cell 的 subview 赋值
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    // User info cell
                    cell.textLabel.text = [_titles valueForKey:kCellUserInfo];
                    break;
                }
                case 1: {
                    // Binding device cell
                    cell.textLabel.text = [_titles valueForKey:kCellBinding];
                    cell.detailTextLabel.text = NSLocalizedString(@"noBinding", @"");
                    break;
                }
            }
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
        case 0: {
            switch (indexPath.row) {
                case 1: {
                    actualCell = 2;
                    break;
                }
            }
            break;
        }
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
    _titles = @{kCellUserInfo : NSLocalizedString(@"cellUserInfo", @""), kCellStepTarget : NSLocalizedString(@"cellStepTarget", @""), kCellSleep : NSLocalizedString(@"cellSleep", @""), kCellAntiLost : NSLocalizedString(@"cellAntiLost", @""), kCellHelp : NSLocalizedString(@"cellHelp", @""), kCellBinding : NSLocalizedString(@"cellBindingDevice", @"")};
    
    // 配置蓝牙表格
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.tableFooterView = [[UIView alloc] init];
}

@end
