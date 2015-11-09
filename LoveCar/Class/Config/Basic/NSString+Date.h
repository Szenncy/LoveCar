//
//  NSString+Date.h
//  时间
//
//  Created by zency on 15/9/19.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)

//1.获得当前的时间戳
+ (id)stringTimeIntervalSince1970;

//2.根据时间戳和格式获得时间
+ (id)stringWithTimeFormat:(NSString *)timeFormate andTimeInterval:(NSTimeInterval)timeInterval;

//3.根据时间戳获得微信时间显示



@end
