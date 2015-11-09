//
//  ZXForumTopView.m
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXForumTopView.h"

@interface ZXForumTopView()
{
    didCloseCallback _closeBlock;
    didBackCallBack _backBlock;
}
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *clostBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZXForumTopView

#pragma mark - 初始化
- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZXForumTopView" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    [self addSubview:self.contentView];
}

#pragma mark - setter

- (void)setIsBackHide:(BOOL)isBackHide{
    _isBackHide = isBackHide;
    
    self.backBtn.hidden = isBackHide;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setCloseCallback:(didCloseCallback)block{
    _closeBlock = block;
}

- (void)setBackCallback:(didBackCallBack)block{
    _backBlock = block;
}

#pragma mark - 事件响应
- (IBAction)backTouch:(id)sender {
    if (_backBlock) {
        _backBlock();
    }
}
- (IBAction)closeTouch:(id)sender {
    if (_closeBlock) {
        _closeBlock();
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.8, 44)];
}


@end
