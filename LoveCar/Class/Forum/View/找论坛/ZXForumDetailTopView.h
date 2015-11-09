//
//  ZXForumDetailTopView.h
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXForumDetailTopView : UIView

@property (strong, nonatomic)NSArray *moderators;

@property (strong, nonatomic)NSArray *subForum;

@property (copy, nonatomic)NSString *title;

@property (assign, nonatomic)NSInteger postNum;

@property (assign, nonatomic)NSInteger themeNum;

@end
