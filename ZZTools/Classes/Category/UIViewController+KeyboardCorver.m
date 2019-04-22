//
//  UIViewController+KeyboardCorver.m
//  KeyBoardTest
//
//  Created by CxDtreeg on 15/10/30.
//  Copyright © 2015年 CxDtreeg. All rights reserved.
//

#import "UIViewController+KeyboardCorver.h"

static void * keyboardHideTapGestureKey = (void *)@"keyboardHideTapGesture";//键盘点击隐藏手势
static void * objectViewKey = (void *)@"objectView";//目标视图
static void * objectArrayKey = (void *)@"objectArray";//目标视图 

@implementation UIViewController (KeyboardCorver)

@dynamic keyboardHideTapGesture;
@dynamic objectView;

+ (void)load{
    
    // 获取交换后的方法
    Method newMethod = class_getInstanceMethod([self class], @selector(zzViewDidAppear:));
    Method newMethodd = class_getInstanceMethod([self class], @selector(zzViewDidDissappear:));
    
    // 获取替换前的方法
    Method method = class_getInstanceMethod([self class], @selector(viewDidAppear:));
    Method methodd = class_getInstanceMethod([self class], @selector(viewDidDisappear:));
    
    // 交换
    method_exchangeImplementations(newMethod, method);
    method_exchangeImplementations(newMethodd, methodd);
}

- (void)zzViewDidDissappear:(BOOL)animated {
    
    [self findFirstResponse:self.view];
}

- (void)zzViewDidAppear:(BOOL)animated {
    [self zzViewDidAppear:animated];
    
}


#pragma mark - 设置输入组件数组 setter getter

- (void)setObjectArray:(NSArray *)objectArray {
    objc_setAssociatedObject(self, objectArrayKey, objectArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)objectArray {
    return objc_getAssociatedObject(self, objectArrayKey);
}

#pragma mark - 设置键盘隐藏单击手势 setter getter
- (void)setKeyboardHideTapGesture:(UITapGestureRecognizer *)keyboardHideTapGesture{
    objc_setAssociatedObject(self, keyboardHideTapGestureKey, keyboardHideTapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)keyboardHideTapGesture{
    return objc_getAssociatedObject(self, keyboardHideTapGestureKey);
}

#pragma mark - 设置获取目标对象 setter getter
- (void)setObjectView:(UIView *)objectView{
    objc_setAssociatedObject(self, objectViewKey, objectView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)objectView{
    return objc_getAssociatedObject(self, objectViewKey);
}

#pragma mark - 添加键盘通知
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotify:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotify:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [self setKeyboardHideTapGesture:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandel)]];
    [self.view addGestureRecognizer:self.keyboardHideTapGesture];
}

#pragma mark - 清理通知和移除手势
- (void)clearNotificationAndGesture{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view removeGestureRecognizer:self.keyboardHideTapGesture];
}

#pragma mark - 单击手势调用
- (void)tapGestureHandel{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - 查找第一响应者
- (void)findFirstResponse:(UIView *)view{
    UIView * ojView = self.objectView;
    ojView = nil;
    for (UIView * tempView in view.subviews) {
        if ([tempView isFirstResponder] &&
            ([tempView isKindOfClass:[UITextField class]] ||
             [tempView isKindOfClass:[UITextView class]])) {//要进行类型判断
                if (![self.objectArray containsObject:tempView]) {
                    NSMutableArray * arr = [NSMutableArray arrayWithArray:self.objectArray];
                    [arr addObject:tempView];
                    [self setObjectArray:(NSArray*)arr];
                    arr = nil;
                }
                [self setObjectView:tempView];
            }
        if (tempView.subviews.count != 0) {
            [self findFirstResponse:tempView];
        }
    }
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

#pragma mark - 键盘通知接收处理
- (void)keyboardNotify:(NSNotification *)notify{

    NSValue * frameNum = [notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = frameNum.CGRectValue;
    CGFloat keyboardHeight = rect.size.height;//键盘高度
    
    CGFloat duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];//获取键盘动画持续时间
    NSInteger curve = [[notify.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];//获取动画曲线
    
    if ([notify.name isEqualToString:UIKeyboardWillShowNotification]) {//键盘显示
        [self findFirstResponse:self.view];
        UIView * tempView = self.objectView;
        CGRect rect = [tempView.superview convertRect:tempView.frame fromView:self.view];//计算响应者到和屏幕的绝对位置
        CGPoint point = rect.origin;
        CGFloat keyboardY = APPWINDOWHEIGHT - keyboardHeight;
        CGFloat tempHeight = -point.y + tempView.frame.size.height;
        if (tempHeight > keyboardY) {
            CGFloat offsetY;
            if (APPWINDOWHEIGHT-tempHeight < 0) {//判断是否超出了屏幕,超出屏幕做偏移纠正
                offsetY = keyboardY - tempHeight + (tempHeight-APPWINDOWHEIGHT);
            }else{
                offsetY = keyboardY - tempHeight;
            }
            if (duration > 0) {
                if (tempView.userInteractionEnabled) {
                    [UIView animateWithDuration:duration delay:0 options:curve animations:^{
                        self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
                    } completion:^(BOOL finished) {
                        
                    }];
                }
            }else{
                self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
            }
            
        }
        
    }else if ([notify.name isEqualToString:UIKeyboardWillHideNotification]){//键盘隐藏
        if (duration > 0) {
            
            [UIView animateWithDuration:duration delay:0 options:curve animations:^{
                [self getCurrentVC].view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            }];
        }else{
            self.view.transform = CGAffineTransformIdentity;
        }
    }
}


@end
