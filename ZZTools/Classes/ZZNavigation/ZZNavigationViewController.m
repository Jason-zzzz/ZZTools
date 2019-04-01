//
//  ZZNavigationViewController.m
//  YinZhang
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZZNavigationViewController.h"

@interface ZZNavigationViewController () <UIGestureRecognizerDelegate>

@end

@implementation ZZNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.interactivePopGestureRecognizer.delegate = self;
//    self.interactivePopGestureRecognizer.enabled = YES;
    
    self.navigationBar.hidden = YES;
//    _zzNavgationBar = [[ZZNavigationBar alloc] init];
//    [self.view addSubview:_zzNavgationBar];
    // Do any additional setup after loading the view.
}


//#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer{
//    //判断是否为rootViewController
//    if (self.navigationController && self.navigationController.viewControllers.count == 1) {
//        return NO;
//    }
//    [self popViewControllerAnimated:YES];
//    return NO;
//}


@end
