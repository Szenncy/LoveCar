//
//  ZXBrandsModel.m
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXBrandsModel.h"

@implementation ZXBrandsModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ID"}];
}

@end
