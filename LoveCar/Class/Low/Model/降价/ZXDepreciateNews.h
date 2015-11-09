//
//  ZXDepreciateNews.h
//  LoveCar
//
//  Created by zency on 10/19/15.
//  Copyright (c) 2015 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXDepreciateNews : NSObject

/** 降价汽车图片 */
@property (nonatomic, copy) NSString *imageUrl;

/** 降价汽车名称 */
@property (nonatomic, copy) NSString *carName;

/** 降价幅度 */
@property (nonatomic, copy) NSString *discount;

/** 现价 */
@property (nonatomic, copy) NSString *currentPrice;

/** 有无现车 */
@property (nonatomic, copy) NSString *tag;

/** 降价详细链接 */
@property (nonatomic, copy) NSString *link;

/** 电话 */
@property (nonatomic, copy) NSString *telephone;

@end
