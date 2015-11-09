//
//  ZXForumTopViewModel.h
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"
#import "ZXBrandsModel.h"

@interface ZXForumTopViewModel : JSONModel

@property (strong, nonatomic)NSNumber *brandNum;

@property (strong, nonatomic)NSArray <ZXBrandsModel> *brands;

@property (copy, nonatomic)NSString *letter;

@end
