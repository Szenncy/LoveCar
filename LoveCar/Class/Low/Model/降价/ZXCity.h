//
//  ZXCity.h
//  LoveCar
//
//  Created by zency on 15/10/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"

@protocol ZXCity <NSObject>


@end

@interface ZXCity : JSONModel

@property (copy, nonatomic)NSString *cityId;

@property (copy, nonatomic)NSString *cityName;

@end
