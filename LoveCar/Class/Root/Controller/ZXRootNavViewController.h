//
//  ZXRootNavViewController.h
//  LoveCar
//
//  Created by zency on 15/10/14.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXRootNavViewController : UINavigationController

/**
 *  显示截取的图片
 */
@property (weak, nonatomic)UIImageView *imageView;

/**
 *  存储截取图片的数组
 */
@property (strong, nonatomic)NSMutableArray *images;

@end
