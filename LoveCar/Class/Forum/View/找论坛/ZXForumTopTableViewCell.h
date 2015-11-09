//
//  ZXForumTopTableViewCell.h
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXBrandsModel.h"
#import "ZXForumModel.h"

@interface ZXForumTopTableViewCell : UITableViewCell

@property (strong, nonatomic)ZXBrandsModel *model;

@property (strong, nonatomic)ZXForumModel *item;

@property (strong, nonatomic)ZXForumModel *forumModel;

@end
