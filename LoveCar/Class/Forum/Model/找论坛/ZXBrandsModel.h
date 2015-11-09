//
//  ZXBrandsModel.h
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"
#import "ZXForumModel.h"

@protocol ZXBrandsModel

@end

//@class ZXForumModel;
@interface ZXBrandsModel : JSONModel

@property (strong, nonatomic)NSMutableArray <ZXForumModel> *forums;

@property (copy, nonatomic)NSString *icon;

@property (strong, nonatomic)NSNumber *ID;

@property (copy, nonatomic)NSString *name;

@end
