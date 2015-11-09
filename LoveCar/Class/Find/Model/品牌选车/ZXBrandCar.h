//
//  ZXBrandCar.h
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXBrandCar : NSObject

/** 汽车品牌 */
@property (nonatomic, strong) NSMutableArray *brands;

/** 所有品牌数目 */
@property (nonatomic, assign) NSInteger letterNum;

/** 品牌所有车型数目 */
@property (nonatomic, assign) NSInteger brandNum;

/** 品牌首字母 */
@property (nonatomic, copy) NSString *letter;

@end
