//
//  XXBLastViewController.m
//  XXBNavDemo
//
//  Created by xiaobing on 16/1/26.
//  Copyright © 2016年 xiaobing. All rights reserved.
//

#import "XXBLastViewController.h"
#import <XXBLibs.h>

@implementation XXBLastViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"myBack" style:UIBarButtonItemStylePlain target:self action:@selector(p_pop)];
    self.view.backgroundColor = [UIColor myRandomColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:button];
    button.center = self.view.center;
    [button addTarget:self action:@selector(p_popToRoot) forControlEvents:UIControlEventTouchUpInside];
}

- (void)p_pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)p_popToRoot
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
