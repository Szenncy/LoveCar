//
//  NSString+Date.m
//  时间
//
//  Created by zency on 15/9/19.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

//获得当前时间的时间戳
+ (id)stringTimeIntervalSince1970{
    return [self stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
}

+ (id)stringWithTimeFormat:(NSString *)timeFormate andTimeInterval:(NSTimeInterval)timeInterval{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = timeFormate;
    
    dateFormatter.locale = [NSLocale currentLocale];
    
    return [dateFormatter stringFromDate:date];
}

@end
