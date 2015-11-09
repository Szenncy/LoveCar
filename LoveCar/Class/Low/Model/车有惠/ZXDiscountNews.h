//
//  ZXDiscountNews.h
//  LoveCar
//
//  Created by zency on 10/20/15.
//  Copyright (c) 2015 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXDiscountNews : NSObject

/** 促销活动图片 */
@property (nonatomic, copy) NSString *salePic;

/** 促销活动标题 */
@property (nonatomic, copy) NSString *saleTitle;

/** 副标题 */
@property (nonatomic, strong) NSArray *subSeries;

@property (nonatomic, copy) NSString *subSerie;

/** 报名人数 */
@property (nonatomic, copy) NSString *number;


@end
