//
//  SwipeUpInteractiveTransition.h
//  XZ_login
//
//  Created by apple on 2019/4/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition
/// 手势中...
@property (nonatomic, assign) BOOL isInteracting;
/// 完成动画
@property (nonatomic, assign) BOOL shouldComplete;
// 初始化
- (instancetype)initWithGestureViewController:(UIViewController *)gestureVC;
@end
