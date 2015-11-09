//
//  ZXSlidingModel.m
//  LoveCar
//
//  Created by zency on 15/10/14.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXSlidingModel.h"

@implementation ZXSlidingModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.type forKey:@"type"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


@end
