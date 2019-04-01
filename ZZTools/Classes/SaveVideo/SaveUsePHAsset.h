//
//  SaveUsePHAsset.h
//  YufeiCamera
//
//  Created by huaxia on 2018/1/30.
//  Copyright © 2018年 Ömer Faruk Gül. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveUsePHAsset : NSObject

+ (void)saveVideo:(NSURL *)url name:(NSString *)name complete:(void (^)(NSString * astID))complete;

@end
