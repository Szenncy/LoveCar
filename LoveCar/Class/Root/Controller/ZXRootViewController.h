//
//  ZXRootViewController.h
//  03-自定义TabBar
//
//  Created by 证翕 胡 on 15/8/20.
//  Copyright (c) 2015年 证翕 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXTabBarView.h"

@interface ZXRootViewController : UITabBarController

/**
 *  自定义tabBar
 */
@property (weak, nonatomic)ZXTabBarView *tabBarView;

@end
