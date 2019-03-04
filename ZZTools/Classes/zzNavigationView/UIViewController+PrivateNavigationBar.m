//
//  UIViewController+PrivateNavigationBar.m
//  YinZhang
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIViewController+PrivateNavigationBar.h"
#import <objc/runtime.h>

#ifndef SCREEN_WIDTH
#define NAV_HEIGHT 64
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#endif

@implementation UIViewController (PrivateNavigationBar)

#define ZZ_RUNTIME
#define WILL_APPEAR
#ifdef ZZ_RUNTIME
+ (void)load{
    
    // 获取交换后的方法
//    Method newMethod = class_getClassMethod([self class], @selector(initView));
    Method newMethod = class_getInstanceMethod([self class], @selector(setZzNavigationBarHeight:));
    
    // 获取替换前的方法
//    Method method = class_getClassMethod([self class], @selector(init));
    Method method = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    
    // 交换
    method_exchangeImplementations(newMethod, method);
}
#endif

- (void)setZzNavigationBarHeight:(BOOL)animated {
    // 替换viewWillAppear:以添加frame设置语句
    [self setZzNavigationBarHeight:animated];
    if (self.zzNavigationBar) {
//        NSLog(@"%f", SCREEN_WIDTH);
        self.zzNavigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    }
}

- (instancetype)initView {
    self.zzNavigationBar = [[ZZNavigationBar alloc] init];
//    [ZZTools setShadow:self.zzNavigationBar.lowestView width:1];
    
    // 调用self的相关参数需在调用self.zzNavigationBar的参数之后，避免先调用而触发实例controller的viewDidLoad方法 
//    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.zzNavigationBar];
    return self;
}

- (ZZNavigationBar *)zzNavigationBar{
    return objc_getAssociatedObject(self, @"zzNavigationBar");
}

-(void)setZzNavigationBar:(ZZNavigationBar *)zzNavigationBar{
    objc_setAssociatedObject(self, @"zzNavigationBar", zzNavigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
