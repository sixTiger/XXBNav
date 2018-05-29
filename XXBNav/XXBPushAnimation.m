//
//  XXBPushAnimation.m
//  XXBNavDemo
//
//  Created by xiaobing5 on 2018/5/29.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBPushAnimation.h"

@implementation XXBPushAnimation
/**
 动画事件 == 子类重写此方法实现动画效果 ==
 */
- (void)animateTransitionEvent {
    UIView *toView   = self.toViewController.view;
    UIView *fromeView   = self.fromViewController.view;
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat screenW = screenBounds.size.width;
    CGFloat screenH = screenBounds.size.height;
    toView.frame = CGRectMake(0, screenH, screenW, screenH);
    self.containerView.backgroundColor = [UIColor blackColor];
    [self.containerView addSubview:fromeView];
    [self.containerView addSubview:toView];
    
    [UIView animateWithDuration:self.transitionDuration
                     animations:^{
                         toView.frame = screenBounds;
                         toView.frame = screenBounds;
                     } completion:^(BOOL finished) {
                         [self completeTransition];
                     }];
}

@end
