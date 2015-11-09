//
//  ZXFocusImg.h
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"

@interface ZXFocusImg : JSONModel

@property (strong, nonatomic)NSNumber *ID;

@property (copy, nonatomic)NSString *imgURL;

@property (copy, nonatomic)NSString *newsLink;

@property (strong, nonatomic)NSNumber *pageNum;

@property (copy, nonatomic)NSString <Optional>*pubTime;

@property (copy, nonatomic)NSString *statisticsUrl;

@property (copy, nonatomic)NSString *title;

@property (strong, nonatomic)NSNumber *type;

@property (copy, nonatomic)NSString *webLink;

@end
