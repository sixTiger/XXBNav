//
//  XXBViewController.m
//  XXBNavDemo
//
//  Created by xiaobing on 16/1/26.
//  Copyright © 2016年 xiaobing. All rights reserved.
//

#import "XXBViewController.h"
#import <XXBLibs.h>
#import "XXBLastViewController.h"

@implementation XXBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor myRandomColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.navigationController pushViewController:[XXBLastViewController new] animated:YES];
}
@end
