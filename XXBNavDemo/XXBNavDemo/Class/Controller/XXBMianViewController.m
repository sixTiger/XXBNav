//
//  XXBViewController.m
//  XXBNavDemo
//
//  Created by xiaobing on 16/1/26.
//  Copyright © 2016年 xiaobing. All rights reserved.
//

#import "XXBMianViewController.h"
#import <XXBLibs.h>
#import <XXBLibs/XXBLibsCategory.h>
#import "XXBLastViewController.h"

@implementation XXBMianViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor myRandomColor];
    self.title = @"<<++++++>>";
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.navigationController pushViewController:[XXBLastViewController new] animated:YES];
}
@end
