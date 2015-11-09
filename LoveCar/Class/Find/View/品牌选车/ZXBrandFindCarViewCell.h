//
//  ZXBrandFindCarViewCell.h
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXBrandFindCarViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *brandLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
