//
//  ZXSliderBarItem.m
//  LoveCar
//
//  Created by zency on 15/10/12.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXSliderBarItem.h"

@interface ZXSliderBarItem()

@property (weak, nonatomic)UILabel *label;

@end

@implementation ZXSliderBarItem

#pragma mark - getter
- (UILabel *)label{
    if (!_label) {
        UILabel *label = [[UILabel alloc]init];
        
        [self addSubview:label];
        
        _label = label;
    }
    
    return _label;
}

#pragma mark - setter
- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.label.text = title;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    
    if (isSelected) {
        self.label.textColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0];;
    }else{
        self.label.textColor = [UIColor blackColor];
    }
}

#pragma mark - layout 

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = self.bounds;
}

@end
