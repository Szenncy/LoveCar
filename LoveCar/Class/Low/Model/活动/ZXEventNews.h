//
//  ZXEventNews.h
//  LoveCar
//
//  Created by zency on 10/19/15.
//  Copyright (c) 2015 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXEventNews : NSObject

/** 活动大图 */
@property (nonatomic, copy) NSString *eventBigImg;

/** 活动标题 */
@property (nonatomic, copy) NSString *eventTitle;

/** 活动截至时间 */
@property (nonatomic, copy) NSString *eventEndTime;

/** 活动地点 */
@property (nonatomic, copy) NSString *eventPlace;

/** 感兴趣人数 */
@property (nonatomic, assign) NSInteger eventInterest;

/** 活动小图 */
@property (nonatomic, copy) NSString *eventSmallImg;

/** 活动详细链接 */
@property (nonatomic, copy) NSString *eventLink;

@end
