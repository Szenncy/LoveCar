//
//  ZXGradualView.m
//  LoveCar
//
//  Created by zency on 15/10/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXGradualView.h"

@implementation ZXGradualView

- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZXGradualView" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    [self addSubview:self.contentView];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:CGRectMake(0, - 20, self.superview.bounds.size.width, 64)];
}

@end
