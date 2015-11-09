//
//  ZXCategoryModel.h
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"
#import "ZXForumModel.h"

@interface ZXCategoryModel : JSONModel

@property (copy, nonatomic)NSString *categoryName;

@property (strong, nonatomic)NSNumber *forumNum;

@property (strong, nonatomic)NSMutableArray<ZXForumModel> *forums;

@end
