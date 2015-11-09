//
//  ZXtoolBar.h
//  LoveCar
//
//  Created by zency on 15/10/15.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXNewsModel.h"
#import "ZXPostModel.h"

@interface ZXtoolBar : UIView

@property (strong, nonatomic)ZXNewsModel *newsModel;

@property (strong, nonatomic)ZXPostModel *postModel;

@property (assign, nonatomic)BOOL isPost;

@property (assign, nonatomic)BOOL isLink;

@end
