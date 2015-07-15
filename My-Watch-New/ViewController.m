//
//  ViewController.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/14.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "ViewController.h"

NSString * const idConnToMain = @"idConnToMain";
NSString * const idBLECell = @"idBLECell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *skipConnButton;
@property (weak, nonatomic) IBOutlet UITableView *bleTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 配置导航栏
    [self configureNavigationBar];
    // 配置蓝牙表视图
    [self configureBLETableView];
    // 配置跳过连接按钮
    [self configureSkipConnButton];
}

- (IBAction)skipConnClick:(id)sender {
    [self performSegueWithIdentifier:idConnToMain sender:self];
}

#pragma mark - Table View Datasource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.2f];
    headerLabel.text = NSLocalizedString(@"peripheralsNearby", @"Peripherals Nearby");
    headerLabel.font = [UIFont boldSystemFontOfSize:14.f];
    
    return headerLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idBLECell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idBLECell];
    }
    
    if (YES) {
        cell.detailTextLabel.text = @"124ABC";
        cell.textLabel.text = NSLocalizedString(@"peripheralScanning", @"Peripheral scanning ...");
    } else {
    
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.detailTextLabel.textColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.8f];
    cell.detailTextLabel.font = [UIFont italicSystemFontOfSize:13.f];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:17.f];
    
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:.1f];
}

#pragma mark - Configure Views

- (void)configureNavigationBar {
    UIBarButtonItem *backBBI = [[UIBarButtonItem alloc] init];
    backBBI.title = NSLocalizedString(@"back", @"Back");
    self.navigationItem.backBarButtonItem = backBBI;
}

- (void)configureBLETableView {
    _bleTableView.delegate = self;
    _bleTableView.dataSource = self;
    _bleTableView.tableFooterView = [[UIView alloc] init];
    _bleTableView.separatorColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:.2f];
}

- (void)configureSkipConnButton {
    _skipConnButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _skipConnButton.layer.borderWidth = .5f;
}

@end
