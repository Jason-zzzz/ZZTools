//
//  TimeTool.m
//  YufeiCamera
//
//  Created by zhoulei on 10/17/16.
//  Copyright © 2016 Ömer Faruk Gül. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool
{
    NSString* _todayStr;
    NSString* _yesterdayStr;
}
+(TimeTool*)instance
{
    static TimeTool * _sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        _sharedInstance = [[self alloc]init];
    });
    return _sharedInstance;
}
+(NSString*)getStringFromStamp:(int) stamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:stamp];
    NSDateFormatter * formater = [[NSDateFormatter alloc] init ];
    [formater setTimeZone: [NSTimeZone systemTimeZone] ];
    formater.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [formater setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
    return  [formater stringFromDate: date];
}
+(NSString*)getStringFromStamp:(int) stamp withFormat:(NSString*)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:stamp];
    NSDateFormatter * formater = [[NSDateFormatter alloc] init ];
    [formater setTimeZone: [NSTimeZone systemTimeZone] ];
    formater.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"CN"];
    [formater setDateFormat:format];
    return  [formater stringFromDate: date];
}
+(NSString*)getStringFromDate:(NSDate*) date
{
    if(!date) return nil;    
    NSDateFormatter * formater = [[NSDateFormatter alloc] init ];
    [formater setTimeZone: [NSTimeZone systemTimeZone] ];
    formater.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [formater setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
    return  [formater stringFromDate: date];
}
+(NSDate*)getDateFromDateStr:(NSString*) str
{
    if(!str) return nil;
    NSDateFormatter * formater = [[NSDateFormatter alloc] init ];
    [formater setTimeZone: [NSTimeZone systemTimeZone] ];
    formater.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [formater setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
    return  [formater dateFromString: str];
}
+(NSString*)getHourMinSecondFrom:(NSDate*) date
{
    if(!date) return nil;
    NSDateFormatter * formater = [[NSDateFormatter alloc] init ];
    [formater setTimeZone: [NSTimeZone systemTimeZone] ];
    formater.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [formater setDateFormat:@"h:m:s a"];
    NSString * str = [formater stringFromDate: date];
    return str;
}
+(NSString*)getYearMonDayFrom:(NSDate*) date
{
    if(!date) return nil;
    NSDateFormatter * formater = [[NSDateFormatter alloc] init ];
    [formater setTimeZone: [NSTimeZone systemTimeZone] ];
    formater.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [formater setDateFormat:@"yy/MM/dd"];
    NSString * str = [formater stringFromDate: date];
    return str;
}
-(NSString*)getShowDateStrFrom:(NSDate*) date
{
    if(!date) return nil;
    NSString * str = [TimeTool getYearMonDayFrom:date];
    if([str isEqualToString:_todayStr]==YES){
        return  [TimeTool getHourMinSecondFrom: date];
    }
    else if([str isEqualToString: _yesterdayStr]){
        return   NSLocalizedString(@"yesterday" , @"yesterday");
    }else{
        return   [TimeTool getYearMonDayFrom: date];
    }
        
    return  nil;
}


#pragma mark ---- private methods

-(id)init
{
    self =[super init];
    if(self){
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setTimeZone: [NSTimeZone systemTimeZone] ];
        dateFormatter.locale = [NSLocale currentLocale];
        
        [dateFormatter setDateFormat:@"yy/MM/dd"];
        _todayStr = [dateFormatter stringFromDate:now];
        NSTimeInterval hour_to_seconds = 24*60*60;
        NSDate *yesterday = [now dateByAddingTimeInterval: -hour_to_seconds];
        _yesterdayStr = [dateFormatter stringFromDate:yesterday];
 
    }
    return self;
}

@end
