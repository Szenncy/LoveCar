//
//  NSString+Addition.m
//  03-QQ聊天
//
//  Created by 证翕 胡 on 15/8/15.
//  Copyright (c) 2015年 证翕 胡. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize) size{
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

@end
