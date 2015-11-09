//
//  ZXUserTop.h
//  LoveCar
//
//  Created by zency on 15/10/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didBackCallback)(void);

@interface ZXUserTop : UIView

- (void)setBackCallback:(didBackCallback)block;

@end
