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

+ (UIImage *)imageNamed:(NSString *)imageName inPrivateBundle:(NSString *)bundleName {
    
    NSURL* associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
    associateBundleURL = [associateBundleURL URLByAppendingPathComponent:bundleName];
    associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
    NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
    associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:associateBundleURL];
    
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}

@end
