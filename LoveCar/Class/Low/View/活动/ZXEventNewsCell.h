//
//  ZXEventNewsCell.h
//  LoveCar
//
//  Created by zency on 10/19/15.
//  Copyright (c) 2015 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXEventNewsCellFrame;
@interface ZXEventNewsCell : UITableViewCell

@property (nonatomic, strong) ZXEventNewsCellFrame *eventNewsCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
