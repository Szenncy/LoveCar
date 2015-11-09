//
//  ZXUserItemModel.h
//  LoveCar
//
//  Created by zency on 15/10/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"

@interface ZXUserItemModel : JSONModel

@property (copy, nonatomic)NSString *className;

@property (copy, nonatomic)NSString *dingYueEventName;

@property (copy, nonatomic)NSString *eventName;

@property (copy, nonatomic)NSString *imageName;

@property (strong, nonatomic)NSNumber *needLogin;

@property (strong, nonatomic)NSNumber *openStyle;

@property (copy, nonatomic)NSString *pageUrl;

@property (strong, nonatomic)NSNumber *pluginId;

@property (strong, nonatomic)NSNumber *subscribed;

@property (copy, nonatomic)NSString *title;

@property (strong, nonatomic)NSNumber <Optional>*selected;

@end
