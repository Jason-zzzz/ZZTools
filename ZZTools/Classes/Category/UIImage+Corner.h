//
//  UIImage+HWCorner.h
//  AllView
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Corner)

//绘制图片圆角
- (UIImage *)drawCornerInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;

@end
