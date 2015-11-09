//
//  ZXFocusPostModel.h
//  LoveCar
//
//  Created by zency on 15/10/15.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"

@interface ZXFocusPostModel : JSONModel

@property (copy, nonatomic)NSString *focusId;

@property (copy, nonatomic)NSString *focusImage;

@property (copy, nonatomic)NSString *focusLink;

@property (copy, nonatomic)NSString *focusTitle;

@property (copy, nonatomic)NSString *focusType;

@property (copy, nonatomic)NSString *statisticsUrl;

@end
