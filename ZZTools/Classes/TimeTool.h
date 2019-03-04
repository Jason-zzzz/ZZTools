//
//  TimeTool.h
//  YufeiCamera
//
//  Created by zhoulei on 10/17/16.
//  Copyright © 2016 Ömer Faruk Gül. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTool : NSObject

+(TimeTool*)instance;
+(NSString*)getStringFromStamp:(int) stamp;
+(NSString*)getStringFromStamp:(int) stamp withFormat:(NSString*)format;
+(NSString*)getStringFromDate:(NSDate*) date;
+(NSDate*)getDateFromDateStr:(NSString*) str;
+(NSString*)getHourMinSecondFrom:(NSDate*) date;
+(NSString*)getYearMonDayFrom:(NSDate*) date;
-(NSString*)getShowDateStrFrom:(NSDate*) date;

@end
