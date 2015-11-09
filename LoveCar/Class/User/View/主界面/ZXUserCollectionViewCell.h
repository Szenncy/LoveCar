//
//  ZXUserCollectionViewCell.h
//  LoveCar
//
//  Created by zency on 15/10/20.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXUserItemModel.h"

typedef void(^didSelected)(void);

@interface ZXUserCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic)ZXUserItemModel *item;

- (void)didSelected;

- (BOOL)selected;

- (void)setDidSelected:(didSelected)block;

- (void)setHiddenAddBtn:(BOOL)hidden;

@end
