//
//  ZZObject.m
//  YufeiCamera
//
//  Created by huaxia on 2018/2/27.
//  Copyright © 2018年 Ömer Faruk Gül. All rights reserved.
//

#import "ZZObject.h"

@implementation ZZObject

- (ZZObject *)init {
    if (self = [super init]) {
        _alal = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

@end
