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
#import "XXBViewControllerProtocol.h"
#import "XXBViewController.h"

typedef NS_ENUM(NSInteger, XXBNavigationControllerOperation) {
    XXBNavigationControllerOperationNone,
    XXBNavigationControllerOperationPush,
    XXBNavigationControllerOperationPop
};

@interface XXBNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition  *percentDrivenTransition;
@property (nonatomic, assign) CGFloat                               transitionProgress;
@property(nonatomic , strong) UIPanGestureRecognizer                *panGestureRecognizer;
@property(nonatomic, strong) XXBTransitioningAnimation              *transitioningAnimation;
@property(nonatomic, strong) XXBPushAnimation                       *pushAnimation;
@property(nonatomic, strong) XXBPopAnimation                        *popAnimation;

/// 记录手势触发的 operation
@property(nonatomic, assign) XXBNavigationControllerOperation       operation;
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

- (void)setDefaultTransitionData {
    self.transitionProgress = 0.0;
    self.operation = XXBNavigationControllerOperationNone;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL shouldBegin = NO;
    if (gestureRecognizer == self.panGestureRecognizer) {
        if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
            /**
             *  如果正在执行专场动画就不响应手势
             */
            shouldBegin =  NO;
        } else {
            if (gestureRecognizer == self.panGestureRecognizer) {
                CGPoint translation = [self.panGestureRecognizer translationInView:self.view];
                if (translation.x > 0) {
                    // 左边划入
                    if (self.childViewControllers.count == 1) {
                        shouldBegin =  NO;
                    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused"
                        // FIXME:todo change pan userfull point 可以调整手势的作用范围
                        CGPoint point = [gestureRecognizer locationInView:self.view];
#pragma clang diagnostic pop
                        self.operation = XXBNavigationControllerOperationPop;
                        shouldBegin =  YES;;
                    }
                } else if (translation.x < 0) {
                    // 右边划入
                    XXBViewController *topVC = (XXBViewController *)self.topViewController;
                    if ([topVC respondsToSelector:@selector(enableRightDragPushViewController)]) {
                        BOOL enableRightDragPushViewController = [topVC enableRightDragPushViewController];
                        if (enableRightDragPushViewController) {
                            self.operation = XXBNavigationControllerOperationPush;
                            shouldBegin = YES;
                        }
                    }
                } else {
                    //上下划入
                }
                
            } else {
                shouldBegin = YES;
            }
        }
    }
    return shouldBegin;
}


- (void)handleNavigationTransition:(UIPanGestureRecognizer *)panGesture {
    switch (self.operation) {
        case XXBNavigationControllerOperationNone:
        {
            [self handleNavigationOperationNoneTransition:panGesture];
            break;
        }
        case XXBNavigationControllerOperationPush:
        {
            [self handleNavigationOperationPushTransition:panGesture];
            break;
        }
        case XXBNavigationControllerOperationPop:
        {
            [self handleNavigationOperationPopTransition:panGesture];
            break;
        }
        default:
            break;
    }
}

- (void)handleNavigationOperationNoneTransition:(UIPanGestureRecognizer *)panGesture {
    if ([self.interactivePopGestureRecognizer.delegate respondsToSelector:@selector(handleNavigationTransition:)]) {
        [self.interactivePopGestureRecognizer.delegate performSelector:@selector(handleNavigationTransition:) withObject:panGesture];
    }
}
- (void)handleNavigationOperationPopTransition:(UIPanGestureRecognizer *)panGesture {
    if ([self.interactivePopGestureRecognizer.delegate respondsToSelector:@selector(handleNavigationTransition:)]) {
        [self.interactivePopGestureRecognizer.delegate performSelector:@selector(handleNavigationTransition:) withObject:panGesture];
    }
}
- (void)handleNavigationOperationPushTransition:(UIPanGestureRecognizer *)panGesture {
    CGPoint translationPoint = [panGesture translationInView:self.view];
    CGFloat translationX = translationPoint.x;
    self.transitionProgress = translationX / (self.view.bounds.size.width * 1.0);
    self.transitionProgress = MIN(1.0, self.transitionProgress);
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            self.percentDrivenTransition.completionCurve = UIViewAnimationCurveLinear;
            XXBViewController *topVC = (XXBViewController *)self.topViewController;
            if ([topVC respondsToSelector:@selector(rightDragPushViewController)]) {
                XXBViewController *newViewController = [topVC rightDragPushViewController];
                [self pushViewController:newViewController animated:YES];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            // 当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
            [self.percentDrivenTransition updateInteractiveTransition:fabs(self.transitionProgress)];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            [self.percentDrivenTransition cancelInteractiveTransition];
            [self setDefaultTransitionData];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            [self.percentDrivenTransition finishInteractiveTransition];
            [self setDefaultTransitionData];
            break;
        }
            
        default:
            break;
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


- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    NSLog(@"XXB | %@", animationController);
    if ([animationController isKindOfClass: [XXBPushAnimation class]]) {
        return self.percentDrivenTransition;
    } else {
        return nil;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}
#pragma mark - UINavigationControllerDelegate END

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *popViewController = [super popViewControllerAnimated:animated];
    return popViewController;
}
#pragma mark - layz Load

//- (UIPercentDrivenInteractiveTransition *)percentDrivenTransition {
//
//}

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
