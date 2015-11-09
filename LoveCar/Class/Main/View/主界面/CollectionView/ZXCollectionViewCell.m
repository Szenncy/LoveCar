//
//  ZXCollectionViewCell.m
//  LoveCar
//
//  Created by zency on 15/10/12.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXCollectionViewCell.h"

@interface ZXCollectionViewCell()

@end

@implementation ZXCollectionViewCell

#pragma mark - setter
- (void)setIndex:(NSInteger)index{
    _index = index;
    
}

- (void)setViewController:(UIViewController *)viewController{
    _viewController = viewController;
    
    viewController.view.frame = self.bounds;
    
    [self addSubview:viewController.view];
}

- (void)setNavigationController:(UINavigationController *)navigationController{
    _navigationController = navigationController;
    
//    [self.viewController setValue:navigationController forKey:@"navigationController"];
}



@end
