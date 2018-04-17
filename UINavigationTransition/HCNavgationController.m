//
//  HCNavgationController.m
//  UINavigationTransition
//
//  Created by hc on 2018/4/17.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "HCNavgationController.h"
#import "Animator.h"
@interface HCNavgationController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) Animator* animator;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;
@end

@implementation HCNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panRecognizer];
    
    self.delegate = self;
    self.animator = [Animator new];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    
}

- (void)pan:(UIPanGestureRecognizer*)recognizer
{
    UIView* view = self.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint location = [recognizer locationInView:view];
        
        if (location.x <  CGRectGetMidX(view.bounds) && self.viewControllers.count > 1) { // left half
            
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            
            [self popViewControllerAnimated:YES];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return self.animator;
    }
//    if (operation == UINavigationControllerOperationPush) {  //push动画
//        return self.animator;
//    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}

//UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }

    return YES;
}

@end
