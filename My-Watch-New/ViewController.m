//
//  ViewController.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/14.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "ViewController.h"

NSString * const idConnToMain = @"idConnToMain";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavigationBar];
}

- (void)configureNavigationBar {
    UIBarButtonItem *backBBI = [[UIBarButtonItem alloc] init];
    backBBI.title = NSLocalizedString(@"back", @"Back");
    self.navigationItem.backBarButtonItem = backBBI;
}

@end
