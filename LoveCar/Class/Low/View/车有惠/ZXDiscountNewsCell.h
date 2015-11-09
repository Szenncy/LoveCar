//
//  ZXDiscountNewsCell.h
//  LoveCar
//
//  Created by zency on 10/20/15.
//  Copyright (c) 2015 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXDiscountNewsCellFrame;
@interface ZXDiscountNewsCell : UITableViewCell

@property (nonatomic, strong) ZXDiscountNewsCellFrame *discountNewsCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
