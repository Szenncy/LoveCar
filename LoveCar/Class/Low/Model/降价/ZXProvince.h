//
//  ZXProvince.h
//  LoveCar
//
//  Created by zency on 15/10/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"
#import "ZXCity.h"

@protocol ZXProvince <NSObject>

@end

@interface ZXProvince : JSONModel

@property (copy, nonatomic)NSString *areaId;

@property (copy, nonatomic)NSString *name;

@property (strong, nonatomic)NSMutableArray <ZXCity>*cities;

@end
