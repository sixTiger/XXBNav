//
//  XXBBaseTransitioningAnimation.m
//  XXBNavDemo
//
//  Created by xiaobing5 on 2018/5/28.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBBaseTransitioningAnimation.h"

@implementation XXBBaseTransitioningAnimation
#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultData];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)setDefaultData {
    
    _transitionDuration = 0.25f;
}

#pragma mark - UIViewControllerAnimatedTransitioning START

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView      = [transitionContext containerView];
    self.transitionContext  = transitionContext;
    [self animateTransitionEvent];
}

#pragma mark - UIViewControllerAnimatedTransitioning END

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
    [UIView animateWithDuration:self.transitionDuration animations:^{
        toView.frame = screenBounds;
        toView.frame = screenBounds;
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];
}

#pragma mark - PUBLIC

- (void)completeTransition {
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
    if (self.toViewController || self.fromViewController) {
    } else {
    }
    self.fromViewController = nil;
    self.toViewController = nil;
    self.transitionContext = nil;
}

@end
