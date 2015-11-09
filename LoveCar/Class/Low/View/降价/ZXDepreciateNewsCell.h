//
//  ZXDepreciateNewsCell.h
//  LoveCar
//
//  Created by zency on 10/19/15.
//  Copyright © 2015 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXDepreciateNewsCellFrame;
@interface ZXDepreciateNewsCell : UITableViewCell

@property (nonatomic, strong) ZXDepreciateNewsCellFrame *depreciateNewsCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
