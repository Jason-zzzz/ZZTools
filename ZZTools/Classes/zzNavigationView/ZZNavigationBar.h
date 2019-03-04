//
//  ZZNavigationBar.h
//  YinZhang
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZZNavigationBarDelegate <NSObject>
- (void)navigationTap; //声明协议方法
@end

@interface ZZNavigationBar : UIView

@property (nonatomic, weak) id <ZZNavigationBarDelegate> delegate; //声明协议变量
@property (weak, nonatomic) IBOutlet UIView *lowestView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *titleBackView;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *zzBackgroundColor;

@end
