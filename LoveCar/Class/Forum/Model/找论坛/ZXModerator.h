//
//  ZXModerator.h
//  LoveCar
//
//  Created by zency on 15/10/19.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"

@interface ZXModerator : JSONModel

@property (copy, nonatomic)NSString *moderatorName;

@property (strong, nonatomic)NSNumber *moderatorUid;

@end
