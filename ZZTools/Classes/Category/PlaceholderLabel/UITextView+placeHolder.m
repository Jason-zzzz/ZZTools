//
//  NSArray+UITextView.m
//  XZ_login
//
//  Created by apple on 2019/3/15.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "UITextView+placeHolder.h"
#import <objc/runtime.h>

@implementation UITextView (placeHolder)

static NSString * placeLabelName = @"zzPlaceHolderLabel";

- (ZZPlaceHolderLabel *)zzPlaceHolderLabel {
    return objc_getAssociatedObject(self, &placeLabelName);
}

- (void)setZzPlaceHolderLabel:(UILabel *)zzPlaceHolderLabel {
    objc_setAssociatedObject(self, &placeLabelName, zzPlaceHolderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)placeHolder:(NSString *)placeHolder {
    
    CGRect frame = CGRectMake(0, 0, self.frame.size.width+10, self.frame.size.height+10);
    
    // _placeholderLabel
    if (!self.zzPlaceHolderLabel) {
        self.zzPlaceHolderLabel = [[ZZPlaceHolderLabel alloc] initWithFrame:frame];
        self.zzPlaceHolderLabel.backgroundColor = [UIColor yellowColor];
    }
    
    // same font
    self.font = [UIFont systemFontOfSize:13.f];
    
    [self setValue:self.zzPlaceHolderLabel forKey:@"_placeholderLabel"];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    static UIEvent *e = nil;
    
    if (e != nil && e == event) {
        e = nil;
        return [super hitTest:point withEvent:event];
    }
    
    e = event;
    
    if (event.type == UIEventTypeTouches) {
        NSSet *touches = [event touchesForView:self];
        UITouch *touch = [touches anyObject];
        if (touch.phase == UITouchPhaseBegan) {
            NSLog(@"Touches began");
        }else if(touch.phase == UITouchPhaseEnded){
            NSLog(@"Touches Ended");
            
        }else if(touch.phase == UITouchPhaseCancelled){
            NSLog(@"Touches Cancelled");
            
        }else if (touch.phase == UITouchPhaseMoved){
            NSLog(@"Touches Moved");
            
        }
    }
    return [super hitTest:point withEvent:event];
}
@end
