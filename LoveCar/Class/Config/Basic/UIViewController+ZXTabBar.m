//
//  UIViewController+ZXTabBar.m
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "UIViewController+ZXTabBar.h"
#import <objc/runtime.h>

@implementation UIViewController (ZXTabBar)

const void *key;

- (void)setTabBarViewController:(ZXRootViewController *)tabBarViewController{
    objc_setAssociatedObject(self, key, tabBarViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ZXRootViewController *)tabBarViewController{
    return objc_getAssociatedObject(self, key);
}

@end
