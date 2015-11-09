//
//  ZXLetterItem.h
//  LoveCar
//
//  Created by zency on 15/10/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"
#import "ZXProvince.h"

@interface ZXLetterItem : JSONModel

@property (copy, nonatomic)NSString *letter;

@property (strong, nonatomic)NSMutableArray <ZXProvince>*provinces;

@end
