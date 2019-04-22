//
//  UINavigationController+ShouldPopExtention.m
//  XZ_login
//
//  Created by apple on 2019/4/18.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "UINavigationController+ShouldPopExtention.h"
#import <objc/runtime.h>
static NSString * const kOriginDelegate = @"kOriginDelegate";
@implementation UINavigationController (ShouldPopExtention)

static dispatch_once_t onceToken;
+ (void)load {
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(navigationBar:shouldPopItem:);
        SEL swizzledSelector = @selector(zzNavigationBar:shouldPopItem:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
          class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
          method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (BOOL)zzNavigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    UIViewController * vc = self.topViewController;
    if (item != vc.navigationItem) {
        return YES;
    }
    
    if ([vc conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
        if ([(id<UINavigationControllerShouldPop>)vc navigationControllerShouldPop:self]) {
            return [self zzNavigationBar:navigationBar shouldPopItem:item];
        } else {
            return NO;
        }
    } else {
        return [self zzNavigationBar:navigationBar shouldPopItem:item];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        UIViewController * vc = [self topViewController];
        if ([vc conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
            if (![(id<UINavigationControllerShouldPop>)vc navigationControllerShouldStartInteractivePopGestureRecognizer:self]) {
                return NO;
            }
        }
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [kOriginDelegate UTF8String]);
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [kOriginDelegate UTF8String]);
        return [originDelegate gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [kOriginDelegate UTF8String]);
        return [originDelegate gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return YES;
}




@end
