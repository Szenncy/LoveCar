//
//  ZXNavTop.h
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXNewsModel.h"
#import "ZXPostModel.h"

typedef enum : NSUInteger {
    ZXNavTopStatusNews,
    ZXNavTopStatusPost,
} ZXNavTopStatus;

typedef void(^didBackCallBack)();

@interface ZXNavTop : UIView

@property (strong, nonatomic)ZXNewsModel *newsModel;

@property (strong, nonatomic)ZXPostModel *postModel;

@property (assign, nonatomic)ZXNavTopStatus status;

- (void)setBackBlock:(didBackCallBack)block;

@end
