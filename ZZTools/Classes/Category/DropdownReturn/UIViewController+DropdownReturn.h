//
//  UIViewController+DropdownReturn.h
//  XZ_login
//
//  Created by apple on 2019/4/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentVCAnimation.h"
#import "DismissVCAnimation.h"
#import "SwipeUpInteractiveTransition.h"
 

@interface UIViewController (DropdownReturn) <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) SwipeUpInteractiveTransition * interactiveTransition;
@property (nonatomic, strong) NSString * canDropdown;

@end

