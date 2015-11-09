//
//  ZXEventNewsCellFrame.h
//  LoveCar
//
//  Created by zency on 10/19/15.
//  Copyright (c) 2015 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kEventNewsCellMargin 6
#define kEventNewsTitleFont [UIFont systemFontOfSize:16]
#define kEventNewsViewMargin 5

@class ZXEventNews;
@interface ZXEventNewsCellFrame : NSObject

@property (nonatomic, strong) ZXEventNews *eventNews;

/** 父视图 */
@property (nonatomic, assign, readonly) CGRect eventNewsViewFrame;

/** 活动大图 */
@property (nonatomic, assign, readonly) CGRect eventBigImgViewFrame;

/** 活动标题 */
@property (nonatomic, assign, readonly) CGRect eventTitleLabelFrame;

/** 活动截至时间 */
@property (nonatomic, assign, readonly) CGRect eventEndTimeLabelFrame;

/** 活动地点 */
@property (nonatomic, assign, readonly) CGRect eventPlaceLabelFrame;

/** 感兴趣人数 */
@property (nonatomic, assign, readonly) CGRect eventInterestBtnFrame;

/** 活动分享 */
@property (nonatomic, assign, readonly) CGRect eventShareBtnFrame;

/** 左上角标 */
@property (nonatomic, assign, readonly) CGRect topLeftBadgeViewFrame;

/** 右下角标 */
@property (nonatomic, assign, readonly) CGRect bottomRightBadgeViewFrame;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
