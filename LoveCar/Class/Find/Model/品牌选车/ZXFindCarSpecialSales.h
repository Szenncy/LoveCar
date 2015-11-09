//
//  ZXFindCarSpecialSales.h
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXFindCarSpecialSales : NSObject

/** 车图片 */
@property (nonatomic, copy) NSString *seriesImage;

/** 车名字 */
@property (nonatomic, copy) NSString *carName;

/** 降价幅度 */
@property (nonatomic, copy) NSString *cheapRange;

/** 销售商 */
@property (nonatomic, copy) NSString *dealerName;

/** 电话 */
@property (nonatomic, copy) NSString *dealerTel;

@end
