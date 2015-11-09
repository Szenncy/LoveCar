//
//  UIImage+Addition.m
//  03-QQ聊天
//
//  Created by 证翕 胡 on 15/8/15.
//  Copyright (c) 2015年 证翕 胡. All rights reserved.
//

#import "UIImage+Addition.h"

@implementation UIImage (Addition)

- (UIImage *)resizeImage{
//    UIImageResizingModeTile,平铺
//    UIImageResizingModeStretch,拉伸
    
//    参数1:指定不拉伸的范围
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(self.size.height * 0.5, self.size.width * 0.5, self.size.height * 0.5, self.size.width * 0.5) resizingMode:UIImageResizingModeTile];
}

@end
