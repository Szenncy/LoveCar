//
//  ZXFindCarSpecialSales.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015 Zency. All rights reserved.
//

#import "ZXFindCarSpecialSales.h"

@implementation ZXFindCarSpecialSales

- (void)setCheapRange:(NSString *)cheapRange {
    _cheapRange = [NSString stringWithFormat:@"直降%@万", cheapRange];
}

- (void)setDealerName:(NSString *)dealerName {
    _dealerName = [NSString stringWithFormat:@"(4S)%@", dealerName];
}

@end
