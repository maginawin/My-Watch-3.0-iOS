//
//  WMUserInfoVC.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/29.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMUserInfoVC.h"
#import "UIColor+Category.h"
#import "WMUserDataObject.h"

// Cell id
NSString * const kUserInfoCell0 = @"idUserInfoCell1"; // 步幅, 身高, 体重, 年龄
NSString * const kUserInfoCell1 = @"idUserInfoCell2"; // 性别

@interface WMUserInfoVC () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView; // 设置表格
@property (strong, nonatomic) UITextField *strideLabel;
@property (strong, nonatomic) UILabel *strideItemLabel;
@property (strong, nonatomic) UITextField *heightLabel;
@property (strong, nonatomic) UILabel *heightItemLabel;
@property (strong, nonatomic) UITextField *weightLabel;
@property (strong, nonatomic) UILabel *weightItemLabel;
@property (strong, nonatomic) UITextField *ageLabel;
@property (strong, nonatomic) UILabel *ageItemLabel;
@property (strong, nonatomic) UIButton *genderBtn1; // Male btn
@property (strong, nonatomic) UIButton *genderBtn2; // Female btn
@property (strong, nonatomic) UIButton *systemBtn1; // Metric btn
@property (strong, nonatomic) UIButton *systemBtn2; // British btn

@end

@implementation WMUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (IBAction)saveClick:(id)sender {
    // 关闭键盘
    [self.view endEditing:YES];
    
    // 把表格降下来
    _mTableView.contentInset = UIEdgeInsetsZero;
    
    // 存储数据
    [WMUserDataObject setStride:_strideLabel.text.intValue];
    [WMUserDataObject setHeight:_heightLabel.text.intValue];
    [WMUserDataObject setWeight:_weightLabel.text.intValue];
    [WMUserDataObject setAge:_ageLabel.text.intValue];
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
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
        case 3: {
            // 公英制
            actual = 1;
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
            break;
        }
        case 3: {
            // Metric and british system
            idCell = kUserInfoCell1;
            break;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idCell];
    }
    
    switch (indexPath.section) {
        case 0: {
            // Stride
            UILabel *textLabel = (UILabel *)[cell viewWithTag:11];
            textLabel.text = NSLocalizedString(@"stride", @"");
            // 步幅值
            _strideLabel = (UITextField *)[cell viewWithTag:12];
            _strideLabel.text = [NSString stringWithFormat:@"%d", [WMUserDataObject stride]];
            [_strideLabel addTarget:self action:@selector(controlEventEditingDidBegin1:) forControlEvents:UIControlEventEditingDidBegin];
            [_strideLabel addTarget:self action:@selector(controlEventEditingChanged1:) forControlEvents:UIControlEventEditingChanged];
            [_strideLabel addTarget:self action:@selector(controlEventEditingDidEndStride:) forControlEvents:UIControlEventEditingDidEnd];
            [_strideLabel addTarget:self action:@selector(controlEventEditingDidEndStride:) forControlEvents:UIControlEventEditingDidEndOnExit];
            // 单位
            _strideItemLabel = (UILabel *)[cell viewWithTag:13];
            _strideItemLabel.text = [WMUserDataObject strideUnit];
            break;
        }
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    // Height
                    UILabel *textLabel = (UILabel *)[cell viewWithTag:11];
                    textLabel.text = NSLocalizedString(@"height", @"");
                    _heightLabel = (UITextField *)[cell viewWithTag:12];
                    _heightLabel.text = [NSString stringWithFormat:@"%d", [WMUserDataObject height]];
                    [_heightLabel addTarget:self action:@selector(controlEventEditingDidBegin1:) forControlEvents:UIControlEventEditingDidBegin];
                    [_heightLabel addTarget:self action:@selector(controlEventEditingChanged1:) forControlEvents:UIControlEventEditingChanged];
                    [_heightLabel addTarget:self action:@selector(controlEventEditingDidEndHeight:) forControlEvents:UIControlEventEditingDidEnd];
                    [_heightLabel addTarget:self action:@selector(controlEventEditingDidEndHeight:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    _heightItemLabel = (UILabel *)[cell viewWithTag:13];
                    _heightItemLabel.text = [WMUserDataObject strideUnit];
                    break;
                }
                case 1: {
                    // Weight
                    UILabel *textLabel = (UILabel *)[cell viewWithTag:11];
                    textLabel.text = NSLocalizedString(@"weight", @"");
                    _weightLabel = (UITextField *)[cell viewWithTag:12];
                    _weightLabel.text = [NSString stringWithFormat:@"%d", [WMUserDataObject weight]];
                    [_weightLabel addTarget:self action:@selector(controlEventEditingDidBegin2:) forControlEvents:UIControlEventEditingDidBegin];
                    [_weightLabel addTarget:self action:@selector(controlEventEditingChanged1:) forControlEvents:UIControlEventEditingChanged];
                    [_weightLabel addTarget:self action:@selector(controlEventEditingDidEndWeight:) forControlEvents:UIControlEventEditingDidEnd];
                    [_weightLabel addTarget:self action:@selector(controlEventEditingDidEndWeight:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    _weightItemLabel = (UILabel *)[cell viewWithTag:13];
                    _weightItemLabel.text = [WMUserDataObject weightUnit];
                    break;
                }
            }
            break;
        }
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    // Age
                    UILabel *textLabel = (UILabel *)[cell viewWithTag:11];
                    textLabel.text = NSLocalizedString(@"age", @"");
                    _ageLabel = (UITextField *)[cell viewWithTag:12];
                    _ageLabel.text = [NSString stringWithFormat:@"%d", [WMUserDataObject age]];
                    [_ageLabel addTarget:self action:@selector(controlEventEditingDidBegin2:) forControlEvents:UIControlEventEditingDidBegin];
                    [_ageLabel addTarget:self action:@selector(controlEventEditingChanged1:) forControlEvents:UIControlEventEditingChanged
                     ];
                    [_ageLabel addTarget:self action:@selector(controlEventEditingDidEndAge:) forControlEvents:UIControlEventEditingDidEnd];
                    [_ageLabel addTarget:self action:@selector(controlEventEditingDidEndAge:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    _ageItemLabel = (UILabel *)[cell viewWithTag:13];
                    _ageItemLabel.text = NSLocalizedString(@"years", @"years");
                    break;
                }
                case 1: {
                    // Gender
                    UILabel *textLabel = (UILabel *)[cell viewWithTag:21];
                    textLabel.text = NSLocalizedString(@"gender", @"");
                    UILabel *maleLabel = (UILabel *)[cell viewWithTag:24];
                    maleLabel.text = NSLocalizedString(@"male", @"");
                    UILabel *femaleLabel = (UILabel *)[cell viewWithTag:25];
                    femaleLabel.text = NSLocalizedString(@"female", @"");
                    _genderBtn1 = (UIButton *)[cell viewWithTag:22];
                    [self selected:![WMUserDataObject gender] button:_genderBtn1];
                    [_genderBtn1 addTarget:self action:@selector(btn1ControlEventTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
                    _genderBtn2 = (UIButton *)[cell viewWithTag:23];
                    [self selected:[WMUserDataObject gender] button:_genderBtn2];
                    [_genderBtn2 addTarget:self action:@selector(btn2ControlEventTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                }
            }
            break;
        }
        case 3: {
            // Metric and british system
            UILabel *textLabel = (UILabel *)[cell viewWithTag:21];
            textLabel.text = NSLocalizedString(@"system", @"");
            UILabel *system1 = (UILabel *)[cell viewWithTag:24];
            system1.text = NSLocalizedString(@"metric", @"");
            UILabel *system2 = (UILabel *)[cell viewWithTag:25];
            system2.text = NSLocalizedString(@"british", @"");
            _systemBtn1 = (UIButton *)[cell viewWithTag:22];
            [self selected:![WMUserDataObject metricBritishSystem] button:_systemBtn1];
            [_systemBtn1 addTarget:self action:@selector(sys1ControlEventTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            _systemBtn2 = (UIButton *)[cell viewWithTag:23];
            [self selected:[WMUserDataObject metricBritishSystem] button:_systemBtn2];
            [_systemBtn2 addTarget:self action:@selector(sys2ControlEventTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
    }
    
    return cell;
}

#pragma mark - Selector

// 编辑开始, 收回 TableView 的上升
- (void)controlEventEditingDidBegin1:(UITextField *)sender {
    _mTableView.contentInset = UIEdgeInsetsZero;
}

// 编辑年龄, 若是 4S 屏则上升 TableView 100
- (void)controlEventEditingDidBegin2:(UITextField *)sender {
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    if (height == 480) {
        _mTableView.contentInset = UIEdgeInsetsMake(-150, 0, 0, 0);
        //        _mTableView.contentOffset = CGPointMake(0, 100);
    } else {
        _mTableView.contentInset = UIEdgeInsetsMake(-80, 0, 0, 0);
    }
}

// Stride, Height, Weight, Age editing changed
- (void)controlEventEditingChanged1:(UITextField *)sender {
    NSString *text = sender.text;
    
    // 若字符超过三位, 则截取掉他们
    if (text.length > 3) {
        text = [text substringWithRange:NSMakeRange(0, 3)];
        sender.text = text;
    }
}

// Stride editing did end
- (void)controlEventEditingDidEndStride:(UITextField *)sender {
    int value = (int)sender.text.intValue;
    float min = 40;
    float max = 100;
    
    // 如果是英制
    if ([WMUserDataObject metricBritishSystem]) {
        min = 15.748;
        max = 39.37;
        //        value = floor(value * 0.3937);
    }
    
    if (value < min) {
        value = ceil(min);
    } else if (value > max) {
        value = ceil(max);
    }
    
    sender.text = [NSString stringWithFormat:@"%d", value];
}

// Height editing did end
- (void)controlEventEditingDidEndHeight:(UITextField *)sender {
    int value = (int)sender.text.integerValue;
    float min = 40;
    float max = 280;
    
    if ([WMUserDataObject metricBritishSystem]) {
        min = 15.748;
        max = 110.236;
    }
    
    if (value < min) {
        value = ceil(min);
    } else if(value > max) {
        value = ceil(max);
    }
    
    sender.text = [NSString stringWithFormat:@"%d", value];
}

// Weight editing did end
- (void)controlEventEditingDidEndWeight:(UITextField *)sender {
    int value = (int)sender.text.integerValue;
    float min = 30;
    float max = 600;
    
    if ([WMUserDataObject metricBritishSystem]) {
        min = 66.15;
        max = 1323;
    }
    
    if (value < min) {
        value = floor(min);
    } else if(value > max) {
        value = floor(max);
    }
    
    sender.text = [NSString stringWithFormat:@"%d", value];
}

// Age editing did end
- (void)controlEventEditingDidEndAge:(UITextField *)sender {
    int value = (int)sender.text.integerValue;
    float min = 1;
    float max = 150;
    
    if (value < min) {
        value = min;
    } else if(value > max) {
        value = max;
    }
    
    sender.text = [NSString stringWithFormat:@"%d", value];
}

// Male btn
- (void)btn1ControlEventTouchUpInside:(UIButton *)sender {
    if ([WMUserDataObject gender]) {
        [WMUserDataObject setGender:NO];
        // 改变 Male Female selected
        [self selected:YES button:sender];
        [self selected:NO button:_genderBtn2];
    }
}

// Female btn
- (void)btn2ControlEventTouchUpInside:(UIButton *)sender {
    if (![WMUserDataObject gender]) {
        [WMUserDataObject setGender:YES];
        // 改变 Male Female selected
        [self selected:YES button:sender];
        [self selected:NO button:_genderBtn1];
    }
}

// Metric btn
- (void)sys1ControlEventTouchUpInside:(UIButton *)sender {
    if ([WMUserDataObject metricBritishSystem]) {
        // Save
        [WMUserDataObject setMetricBritishSystem:NO];
        // Update metric
        [self selected:YES button:sender];
        [self selected:NO button:_systemBtn2];
        
        // Update views
        // Stride
        _strideLabel.text = [WMUserDataObject cmFromInch:_strideLabel.text];
        // Unit
        _strideItemLabel.text = [WMUserDataObject strideUnit];
        // Height
        _heightLabel.text = [WMUserDataObject cmFromInch:_heightLabel.text];
        // Unit
        _heightItemLabel.text = [WMUserDataObject strideUnit];
        // Weight
        _weightLabel.text = [WMUserDataObject kgFromLb:_weightLabel.text];
        // Unit
        _weightItemLabel.text = [WMUserDataObject weightUnit];
        
        // 存储数据
        [WMUserDataObject setStride:_strideLabel.text.intValue];
        [WMUserDataObject setHeight:_heightLabel.text.intValue];
        [WMUserDataObject setWeight:_weightLabel.text.intValue];
        [WMUserDataObject setAge:_ageLabel.text.intValue];
    }
}

// British btn
- (void)sys2ControlEventTouchUpInside:(UIButton *)sender {
    if (![WMUserDataObject metricBritishSystem]) {
        // Save
        [WMUserDataObject setMetricBritishSystem:YES];
        // Update british
        [self selected:YES button:sender];
        [self selected:NO button:_systemBtn1];
        
        // Update other views
        // Stride
        _strideLabel.text = [WMUserDataObject inchFromCm:_strideLabel.text];
        // Unit
        _strideItemLabel.text = [WMUserDataObject strideUnit];
        // Height
        _heightLabel.text = [WMUserDataObject inchFromCm:_heightLabel.text];
        // Unit
        _heightItemLabel.text = [WMUserDataObject strideUnit];
        // Weight
        _weightLabel.text = [WMUserDataObject lbFromKg:_weightLabel.text];
        // Unit
        _weightItemLabel.text = [WMUserDataObject weightUnit];
        
        // 存储数据
        [WMUserDataObject setStride:_strideLabel.text.intValue];
        [WMUserDataObject setHeight:_heightLabel.text.intValue];
        [WMUserDataObject setWeight:_weightLabel.text.intValue];
        [WMUserDataObject setAge:_ageLabel.text.intValue];
    }
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

#pragma mark - Assistor

// 更新用户信息设置
- (void)refreshUserInformation {
    // Stride
    _strideLabel.text = [NSString stringWithFormat:@"%d", [WMUserDataObject stride]];
    // Unit
    _strideItemLabel.text = [WMUserDataObject strideUnit];
    // Height
    _heightLabel.text = [NSString stringWithFormat:@"%d", [WMUserDataObject height]];
    // Unit
    _heightItemLabel.text = [WMUserDataObject strideUnit];
    // Weight
    _weightLabel.text = [NSString stringWithFormat:@"%d", [WMUserDataObject weight]];
    // Unit
    _weightItemLabel.text = [WMUserDataObject weightUnit];
    
}

// 改变 UIButton 的选中状态, 主要用在 Gender
- (void)selected:(BOOL)selected button:(UIButton *)sender {
    NSString *text = @"◎";
    UIColor *mColor = [UIColor lightGrayColor];
    
    if (selected) {
        text = @"◉";
        mColor = [UIColor mDeepBlueColorAlpha:1.0f];
    }
    
    [sender setTitle:text forState:UIControlStateNormal];
    [sender setTitleColor:mColor forState:UIControlStateNormal];
}

@end
