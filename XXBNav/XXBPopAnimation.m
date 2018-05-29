//
//  XXBPopAnimation.m
//  XXBNavDemo
//
//  Created by xiaobing5 on 2018/5/29.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBPopAnimation.h"

@implementation XXBPopAnimation
- (void)animateTransitionEvent {
    UIView *toView   = self.toViewController.view;
    UIView *fromeView   = self.fromViewController.view;
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat screenW = screenBounds.size.width;
    CGFloat screenH = screenBounds.size.height;
    toView.frame = screenBounds;
    fromeView.frame = screenBounds;
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:toView];
    [self.containerView addSubview:fromeView];
    
    [UIView animateWithDuration:self.transitionDuration
                     animations:^{
                         fromeView.frame = CGRectMake(0, screenH, screenW, screenH);
                         toView.frame = screenBounds;
                     } completion:^(BOOL finished) {
                         [self completeTransition];
                     }];
}
@end
