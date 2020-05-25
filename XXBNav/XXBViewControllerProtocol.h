//
//  XXBViewControllerProtocol.h
//  XXBNavDemo
//
//  Created by xiaobing5 on 2020/5/25.
//  Copyright © 2020 xiaobing. All rights reserved.
//

#ifndef XXBViewControllerProtocol_h
#define XXBViewControllerProtocol_h
#import <UIKit/UIKit.h>
@class XXBViewController;

@protocol XXBViewControllerProtocol <NSObject>

@optional

/// 是否允许从右侧滑动 Push ViewController
- (BOOL)enableRightDragPushViewController;

/// 右侧滑动需要Push 的  ViewController
- (XXBViewController *)rightDragPushViewController;
//- (BOOL)enableRightDragPushNewViewController;

//- (UI)enableRightDragPushNewViewController;

////相应viewController的push动画
//- (void)performPushViewControllerAnimationsWithPushAnimatorType:(PushAnimatorType)pushAnimatorType
//                                           panGestureRecognizer:(UIPanGestureRecognizer *)recognizer
//                                                       progress:(CGFloat)progress;
//
////相应viewController的pop动画
//- (void)performPopViewControllerAnimationsWithPopAnimatorType:(PopAnimatorType)popAnimatorType
//                                         panGestureRecognizer:(UIPanGestureRecognizer *)recognizer
//                                                     progress:(CGFloat)progress;

@end

#endif /* XXBViewControllerProtocol_h */
