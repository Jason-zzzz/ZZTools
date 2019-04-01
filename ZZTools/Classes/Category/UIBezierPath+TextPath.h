//
//  UIBezierPath+TextPath.h
//  XZ_login
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (TextPath)

+ (UIBezierPath *)bezierPathWithText:(NSString *)text font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
