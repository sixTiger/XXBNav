//
//  XXBNavigationController.m
//  XXBNavDemo
//
//  Created by xiaobing on 15/10/13.
//  Copyright © 2015年 xiaobing. All rights reserved.
//

#import "XXBNavigationController.h"

@interface XXBNavigationController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) id                        popDelegate;
@property(nonatomic , strong) UIPanGestureRecognizer    *panGestureRecognizer;
@end

@implementation XXBNavigationController

+ (void)initialize
{
    UIBarButtonItem *barItem =  [UIBarButtonItem appearance];
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSForegroundColorAttributeName] = [UIColor orangeColor];;
    [barItem setTitleTextAttributes:textDict forState:UIControlStateNormal];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor orangeColor];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [navBar setTitleTextAttributes:textAttrs];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:_popDelegate action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1)
    {
        return NO;
    }
    
    if ([gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused"
        // FIXME:todo change pan userfull point 可以调整手势的作用范围
        CGPoint point = [gestureRecognizer locationInView:self.view];
#pragma clang diagnostic pop
    }
    return YES;
}

@end
