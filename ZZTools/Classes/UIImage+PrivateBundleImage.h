//
//  UIImage+PrivateBundleImage.h
//  ZZTools
//
//  Created by apple on 2019/3/6.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (PrivateBundleImage)

+ (UIImage *)imageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
