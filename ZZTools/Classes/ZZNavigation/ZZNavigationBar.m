//
//  ZZNavigationBar.m
//  YinZhang
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZZNavigationBar.h"
#import "NSBundle+privateBundle.h"

#ifndef SCREEN_WIDTH
#define NAV_HEIGHT 64
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#endif

@interface ZZNavigationBar () <UIGestureRecognizerDelegate>

@end

@implementation ZZNavigationBar

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isEqual:self.lowestView]) {
        // 当代理响应时
        if ([_delegate respondsToSelector:@selector(navigationTap)]) {
            [_delegate navigationTap];
        }
    }
    return NO;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"ZZNavigationBar" owner:nil options:nil] lastObject];
        self = [[[NSBundle privateBundleWithName:@"ZZNavigationBar" targetClass:[self class]]  loadNibNamed:@"ZZNavigationBar" owner:self options:nil] lastObject];
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAV_HEIGHT);
        self.lowestView.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAV_HEIGHT);
//        NSLog(@"%f",self.lowestView.frame.size.width);
//        NSLog(@"%f",self.frame.size.width);
        UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        tapGes.delegate = self;
        [self.lowestView addGestureRecognizer:tapGes];
    }
    return self;
}

- (IBAction)back:(id)sender {
    if ([self getCurrentVC].navigationController) {
        [[self getCurrentVC].navigationController popViewControllerAnimated:YES];
    } else {
        [[self getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setZzBackgroundColor:(UIColor *)zzBackgroundColor {
    self.statusView.backgroundColor = zzBackgroundColor;
    self.backView.backgroundColor = zzBackgroundColor;
}

- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    // app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    // 如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        // 多层present
        while (appRootVC.presentedViewController) {
            appRootVC = appRootVC.presentedViewController;
            if (appRootVC) {
                nextResponder = appRootVC;
            }else{
                break;
            }
        }
        // nextResponder = appRootVC.presentedViewController;
    }else{
        
        // NSLog(@"===%@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        // UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}

@end
