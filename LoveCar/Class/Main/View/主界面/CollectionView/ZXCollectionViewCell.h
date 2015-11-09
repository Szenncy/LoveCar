//
//  ZXCollectionViewCell.h
//  LoveCar
//
//  Created by zency on 15/10/12.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXCollectionViewCell : UICollectionViewCell

@property (assign, nonatomic)NSInteger index;

@property (strong, nonatomic)UIViewController *viewController;

@property (strong, nonatomic)UINavigationController *navigationController;

@end
