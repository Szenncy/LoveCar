//
//  ZXForumModel.h
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"

@protocol ZXForumModel

@end

@interface ZXForumModel : JSONModel

@property (copy, nonatomic)NSString <Optional>*ID;

@property (copy, nonatomic)NSString <Optional>*name;

@property (strong, nonatomic)NSNumber <Optional>*forumId;

@property (copy, nonatomic)NSString <Optional>*forumName;

@end
