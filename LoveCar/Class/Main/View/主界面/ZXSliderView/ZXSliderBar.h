//
//  ZXSliderBar.h
//  LoveCar
//
//  Created by zency on 15/10/12.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didSelectedCallback)(NSInteger index);

@interface ZXSliderBar : UIView

@property (weak, nonatomic)UICollectionView *collectionView;

@property (strong, nonatomic)NSArray *titles;

@property (assign, nonatomic)NSInteger index;

- (void)setSelectedCallback:(didSelectedCallback)callback;

@end
