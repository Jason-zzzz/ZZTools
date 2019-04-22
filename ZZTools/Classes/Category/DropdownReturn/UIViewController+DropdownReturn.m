//
//  UIViewController+DropdownReturn.m
//  XZ_login
//
//  Created by apple on 2019/4/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "UIViewController+DropdownReturn.h"
#import <objc/runtime.h>

static NSString *interactiveTransitionKey = @"interactiveTransition";
static NSString *canDropdownKey = @"canDropdown";

@implementation UIViewController (DropdownReturn)

- (SwipeUpInteractiveTransition *)interactiveTransition {
    return objc_getAssociatedObject(self, &interactiveTransitionKey);
}

- (void)setInteractiveTransition:(SwipeUpInteractiveTransition *)interactiveTransition {
    objc_setAssociatedObject(self, &interactiveTransitionKey, interactiveTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCanDropdown:(NSString *)canDropdown {
    objc_setAssociatedObject(self, &canDropdownKey, canDropdown, OBJC_ASSOCIATION_COPY);
    if (canDropdown.integerValue == 1) {
        if (!self.interactiveTransition) {
            self.interactiveTransition = [[SwipeUpInteractiveTransition alloc] initWithGestureViewController:self];
        }
    }
}

- (NSString *)canDropdown {
    return objc_getAssociatedObject(self, &canDropdownKey);
}

// 设置Presented的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[PresentVCAnimation alloc] init];
}

/// 设置Dismiss返回的动画设置
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DismissVCAnimation alloc] init];
}

/// 设置过场动画
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    
    return (self.interactiveTransition.isInteracting ? self.interactiveTransition : nil);
}


@end
