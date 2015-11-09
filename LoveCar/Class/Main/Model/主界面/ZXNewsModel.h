//
//  ZXNewsModel.h
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"

@interface ZXNewsModel : JSONModel

@property (strong, nonatomic)NSNumber *commentCount;

@property (strong, nonatomic)NSNumber *isSpread;

@property (copy, nonatomic)NSString<Optional> *newsCategory;

@property (strong, nonatomic)NSNumber<Optional> *newsCreateTime;

@property (strong, nonatomic)NSNumber *newsId;

@property (copy, nonatomic)NSString *newsImage;

@property (copy, nonatomic)NSString *newsLink;

@property (copy, nonatomic)NSString *newsTitle;

@property (copy, nonatomic)NSString<Optional> *pubTime;

@property (copy, nonatomic)NSString *webLink;

@property (strong, nonatomic)NSNumber *newsType;

@end
