//
//  ZXForumDetailViewController.h
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXForumModel.h"
@interface ZXForumDetailViewController : UIViewController

@property (strong, nonatomic)ZXForumModel *forumModel;

@property (assign, nonatomic)NSInteger ID;

@property (copy,nonatomic)NSString *forumName;

@end
