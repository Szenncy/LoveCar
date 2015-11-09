//
//  ZXForumModel.m
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXForumModel.h"

@implementation ZXForumModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ID"}];
}

@end
