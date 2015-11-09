//
//  ZXForumTopView.h
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didCloseCallback)(void);

typedef void(^didBackCallBack)(void);

@interface ZXForumTopView : UIView

@property (assign, nonatomic)BOOL isBackHide;

@property (copy, nonatomic)NSString *title;

- (void)setCloseCallback:(didCloseCallback)block;

- (void)setBackCallback:(didBackCallBack)block;

@end
