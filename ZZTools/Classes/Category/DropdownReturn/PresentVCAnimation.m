//
//  PresentVCAnimation.m
//  XZ_login
//
//  Created by apple on 2019/4/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "PresentVCAnimation.h"

@implementation PresentVCAnimation
// 设置动画的时间长度
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 前一个ViewController,动画的发起者
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 后一个ViewController,动画的结束者
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 转场动画的最终的frame
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toVC];
    // 下面敲黑板啦
    // 转换的容器view,这里是存放转场动画的容器
    UIView *containerView = [transitionContext containerView];
    // 这里一般情况下,没有涉及到VC的View放大或者缩小,即可看做是屏幕的尺寸
    CGRect bounds = [UIScreen mainScreen].bounds;
    // 这是后一个ViewController的frame
    toVC.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height);
    [containerView addSubview:toVC.view];
    
    // 下面是改变前一个ViewController和后一个ViewController的动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        fromVC.view.alpha = 0.5;
        toVC.view.frame = finalFrameForVC;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVC.view.alpha = 1.0;
    }];
}

-(void)animationEnded:(BOOL)transitionCompleted {
}
@end
