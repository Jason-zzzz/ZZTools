//
//  ZZPlaceHolderLabel.m
//  XZ_login
//
//  Created by apple on 2019/4/15.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "ZZPlaceHolderLabel.h"

@implementation ZZPlaceHolderLabel


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self sizeToFit];
        self.text = @"请输入内容";
        self.numberOfLines = 0;
        self.textColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:13.f];
        
    }
    return self;
}

@end
