//
//  XXBRightDragPushViewController.m
//  XXBNavDemo
//
//  Created by xiaobing5 on 2020/5/25.
//  Copyright © 2020 xiaobing. All rights reserved.
//

#import "XXBRightDragPushViewController.h"
#import "XXBRightDragPushTOVC.h"

@implementation XXBRightDragPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
}

- (BOOL)enableRightDragPushViewController {
    return YES;
}

- (XXBViewController *)rightDragPushViewController {
    return [[XXBRightDragPushTOVC alloc] init];
}
@end
