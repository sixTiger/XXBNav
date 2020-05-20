//
//  XXBLastViewController.m
//  XXBNavDemo
//
//  Created by xiaobing on 16/1/26.
//  Copyright © 2016年 xiaobing. All rights reserved.
//

#import "XXBLastViewController.h"
#import <XXBLibs.h>
#import <XXBLibs/XXBLibsCategory.h>

@implementation XXBLastViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,100, 44)];
    titleLabel.text = [NSString stringWithFormat:@"我是标题%@",@(arc4random_uniform(255))];
    self.navigationItem.titleView = titleLabel;
}
@end
