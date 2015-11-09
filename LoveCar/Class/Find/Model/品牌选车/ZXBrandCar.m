//
//  ZXBrandCar.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015 Zency. All rights reserved.
//

#import "ZXBrandCar.h"
#import "MJExtension.h"

@implementation ZXBrandCar

// 字典中包含字典
// 将返回的json的字典的key作为为key，字典中的字典的数据类作为值
+ (NSDictionary *)objectClassInArray {
    return @{@"brands" : @"ZXBrand"};
}

- (void)setLetter:(NSString *)letter {
    _letter = letter.uppercaseString;
}

@end
