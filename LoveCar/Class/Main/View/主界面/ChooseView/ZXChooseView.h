//
//  ZXChooseView.h
//  LoveCar
//
//  Created by zency on 15/10/14.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXSlidingModel.h"

typedef void(^didChooseViewBlock)();

@interface ZXChooseView : UIView

@property (strong, nonatomic)NSMutableArray *bookArr;

@property (strong, nonatomic)NSMutableArray *noBookArr;

- (void)setDidChooseBlock:(didChooseViewBlock)block;

@end
