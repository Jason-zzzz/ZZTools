//
//  UIViewController+PrivateNavigationBar.h
//  YinZhang
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZNavigationBar.h"

@interface UIViewController (PrivateNavigationBar)

@property (strong, nonatomic) ZZNavigationBar * zzNavigationBar;

+ (instancetype)initView:(UIViewController *)controller;

@end
