//
//  NSArray+UITextView.h
//  XZ_login
//
//  Created by apple on 2019/3/15.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZZPlaceHolderLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (placeHolder) 

@property (nonatomic, strong) ZZPlaceHolderLabel * zzPlaceHolderLabel;
- (void)placeHolder:(NSString *)placeHolder;

@end

NS_ASSUME_NONNULL_END
