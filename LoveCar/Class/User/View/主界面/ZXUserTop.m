//
//  ZXUserTop.m
//  LoveCar
//
//  Created by zency on 15/10/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXUserTop.h"

@interface ZXUserTop()
{
    didBackCallback _backBlock;
}
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZXUserTop

#pragma mark - 初始化
- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZXUserTop" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    [self addSubview:self.contentView];
}

#pragma mark - setter
- (void)setBackCallback:(didBackCallback)block{
    _backBlock = block;
}

#pragma mark - 返回
- (IBAction)backTouch:(id)sender {
    if (_backBlock) {
        _backBlock();
    }
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, -20, self.superview.bounds.size.width, 64)];
}

@end
