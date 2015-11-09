//
//  ZXMainNavView.m
//  LoveCar
//
//  Created by zency on 15/10/12.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXMainNavView.h"

@interface ZXMainNavView()
{
    didChooseCallback _chooseBlock;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ZXMainNavView

- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZXMainNavView" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    [self addSubview:self.contentView];
    
    self.width.constant = 308 * [UIScreen mainScreen].bounds.size.width / 375;
    
    [self.contentView layoutIfNeeded];
}

- (IBAction)chooseTouch:(UIButton *)sender {
    
    if (_chooseBlock) {
        _chooseBlock();
    }
    
}

- (IBAction)searchTouch:(UIButton *)sender {
}

#pragma mark - setter

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, -20, self.superview.bounds.size.width, 64)];
}

- (void)setDidChoose:(didChooseCallback)callBack{
    _chooseBlock = callBack;
}

@end
