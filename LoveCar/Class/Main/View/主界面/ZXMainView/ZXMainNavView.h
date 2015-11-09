//
//  ZXMainNavView.h
//  LoveCar
//
//  Created by zency on 15/10/12.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXSliderBar.h"

typedef void(^didChooseCallback)();

@interface ZXMainNavView : UIView

@property (weak, nonatomic) IBOutlet ZXSliderBar *sliderBar;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

- (void)setDidChoose:(didChooseCallback)callBack;

@end
