//
//  ZXNavForumViewController.h
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXRootNavViewController.h"

typedef void(^closeCallback)(BOOL animate);

@interface ZXNavForumViewController :UINavigationController

- (void)close:(BOOL)animate;

- (void)setCloseCallback:(closeCallback)block;

@property (strong, nonatomic)UINavigationController *navVC;

@end
