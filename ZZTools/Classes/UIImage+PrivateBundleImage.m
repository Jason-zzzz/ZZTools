//
//  UIImage+PrivateBundleImage.m
//  ZZTools
//
//  Created by apple on 2019/3/6.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "UIImage+PrivateBundleImage.h"
#import "NSBundle+privateBundle.h"

@implementation UIImage (PrivateBundleImage)

+ (UIImage *)imageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName {
    
    NSBundle *bundle = [NSBundle privateBundleWithName:bundleName targetClass:[self class]];
    
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}

@end
