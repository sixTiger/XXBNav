//
//  XXBNavigationController.m
//  XXBNavDemo
//
//  Created by xiaobing on 15/10/13.
//  Copyright © 2015年 xiaobing. All rights reserved.
//

#import "XXBNavigationController.h"
#import "XXBTransitioningAnimation.h"
#import "XXBPushAnimation.h"
#import "XXBPopAnimation.h"

@interface XXBNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property(nonatomic , strong) UIPanGestureRecognizer            *panGestureRecognizer;
@property(nonatomic, strong) XXBTransitioningAnimation          *transitioningAnimation;
@property(nonatomic, strong) XXBPushAnimation                   *pushAnimation;
@property(nonatomic, strong) XXBPopAnimation                    *popAnimation;

@end

@implementation XXBNavigationController

+ (void)initialize {
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

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    self.panGestureRecognizer = pan;
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
    [self setConfig];
    self.delegate = self;
}

/**
 *  用于解决某些情况下View的布局出错
 *
 *  比如说view的上边多了20的空白，或者tableView的上边多了64的空白的问题
 *
 */
- (void) setConfig {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL shouldBegin = NO;
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        /**
         *  如果正在执行专场动画就不响应手势
         */
        shouldBegin =  NO;
    } else {
        if (gestureRecognizer == self.panGestureRecognizer) {
            if (self.childViewControllers.count == 1) {
                shouldBegin =  NO;
            } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused"
                // FIXME:todo change pan userfull point 可以调整手势的作用范围
                CGPoint point = [gestureRecognizer locationInView:self.view];
#pragma clang diagnostic pop
                shouldBegin =  YES;;
            }
        } else {
            shouldBegin = YES;
        }
    }
    return shouldBegin;
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)PanGesture {
    if ([self.interactivePopGestureRecognizer.delegate respondsToSelector:@selector(handleNavigationTransition:)]) {
        [self.interactivePopGestureRecognizer.delegate performSelector:@selector(handleNavigationTransition:) withObject:PanGesture];
    }
}

#pragma mark - UINavigationControllerDelegate START

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    switch (operation) {
        case UINavigationControllerOperationPush:
            return self.pushAnimation;
            break;
        case UINavigationControllerOperationPop:
            return self.popAnimation;
            break;
        default:
            break;
    }
    return self.transitioningAnimation;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}
#pragma mark - UINavigationControllerDelegate END

#pragma mark - layz Load
- (XXBTransitioningAnimation *)transitioningAnimation {
    if (_transitioningAnimation == nil) {
        _transitioningAnimation = [[XXBTransitioningAnimation alloc] init];
    }
    return _transitioningAnimation;
}

- (XXBPushAnimation *)pushAnimation {
    if (_pushAnimation == nil) {
        XXBPushAnimation *pushAnimation = [[XXBPushAnimation alloc] init];
        _pushAnimation = pushAnimation;
    }
    return _pushAnimation;
}

- (XXBPopAnimation *)popAnimation {
    if (_popAnimation == nil) {
        XXBPopAnimation *popAnimation = [[XXBPopAnimation alloc] init];
        _popAnimation = popAnimation;
    }
    return _popAnimation;
}
@end
