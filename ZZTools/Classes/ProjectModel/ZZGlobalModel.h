//
//  ZZObject.h
//  YufeiCamera
//
//  Created by huaxia on 2018/2/27.
//  Copyright © 2018年 Ömer Faruk Gül. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@interface ZZGlobalModel : NSObject

@property (nonatomic, strong) ALAssetsLibrary * alal;
@property (nonatomic, assign) float pmm; // 每毫米像素个数，根据屏幕大小不同而不同
@property (nonatomic, strong) NSString * iphoneType;

@end

