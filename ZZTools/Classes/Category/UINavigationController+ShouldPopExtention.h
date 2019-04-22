//
//  UINavigationController+ShouldPopExtention.h
//  XZ_login
//
//  Created by apple on 2019/4/18.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol UINavigationControllerShouldPop <NSObject>

- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController;
- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController;

@end

@interface UINavigationController (ShouldPopExtention)

@end

NS_ASSUME_NONNULL_END
