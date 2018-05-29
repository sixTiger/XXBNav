//
//  XXBBaseTransitioningAnimation.h
//  XXBNavDemo
//
//  Created by xiaobing5 on 2018/5/28.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XXBBaseTransitioningAnimation : NSObject <UIViewControllerAnimatedTransitioning>


/**
 transitionContext
 */
@property (nonatomic, weak) id <UIViewControllerContextTransitioning>   transitionContext;

/**
 动画执行时间(默认值为0.25s)
 */
@property (nonatomic) NSTimeInterval                                    transitionDuration;

/**
 源头控制器 == 在animateTransitionEvent使用才有效 ==
 */
@property (nonatomic, strong) UIViewController                          *fromViewController;

/**
 目标控制器 == 在animateTransitionEvent使用才有效 ==
 */
@property (nonatomic, strong) UIViewController                          *toViewController;

/**
 containerView == 在animateTransitionEvent使用才有效 ==
 */
@property (nonatomic, weak) UIView                                      *containerView;

/**
 动画事件 == 子类重写此方法实现动画效果 ==
 */
- (void)animateTransitionEvent;

/**
 *  动画事件结束
 */
- (void)completeTransition;

@end
