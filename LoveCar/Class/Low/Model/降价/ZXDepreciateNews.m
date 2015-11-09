//
//  ZXDepreciateNews.m
//  LoveCar
//
//  Created by zency on 10/19/15.
//  Copyright © 2015 Zency. All rights reserved.
//

#import "ZXDepreciateNews.h"

@implementation ZXDepreciateNews

- (void)setDiscount:(NSString *)discount {
    _discount = [NSString stringWithFormat:@"直降%@", discount];
}

- (void)setCurrentPrice:(NSString *)currentPrice {
    _currentPrice = [NSString stringWithFormat:@"现价%@", currentPrice];
}

@end
