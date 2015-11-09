//
//  ZXtoolBar.m
//  LoveCar
//
//  Created by zency on 15/10/15.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXtoolBar.h"

@interface ZXtoolBar()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet UIButton *labelBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBtnWidth;

@end

@implementation ZXtoolBar
#pragma mark - 初始化
- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZXtoolBar" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    [self addSubview:self.contentView];
}

#pragma mark - setter

- (void)setNewsModel:(ZXNewsModel *)newsModel{
    _newsModel = newsModel;
    
    [self.labelBtn setTitle:[NSString stringWithFormat:@"%@评",newsModel.commentCount] forState:UIControlStateNormal];
    
    [self.clickBtn setImage:[UIImage imageNamed:@"BBS_fabiao"] forState:UIControlStateNormal];
    
    self.clickBtn.layer.borderWidth = 1;
    
    self.clickBtn.layer.borderColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0].CGColor;
    
    self.clickBtn.layer.cornerRadius = 5;
    
}

- (void)setPostModel:(ZXPostModel *)postModel{
    _postModel = postModel;
    
    NSString *title = [NSString stringWithFormat:@"1/%zd 页",[postModel.replyCount integerValue] / 10 + 1];
    
    [self.labelBtn setTitle:title forState:UIControlStateNormal];
    
    self.rightBtnWidth.constant = [self.labelBtn.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    
    [self.clickBtn setTitle:@"发表回复" forState:UIControlStateNormal];
    
    [self.clickBtn setImage:[UIImage imageNamed:@"BBS_fabiao"] forState:UIControlStateNormal];
    
    self.clickBtn.layer.borderWidth = 1;
    
    self.clickBtn.layer.borderColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0].CGColor;
    
    self.clickBtn.layer.cornerRadius = 5;
    
}

- (void)setIsPost:(BOOL)isPost{
    _isPost = isPost;
    
    [self.labelBtn setTitle:nil forState:UIControlStateNormal];
    
    [self.clickBtn setTitle:@"发布新帖" forState:UIControlStateNormal];
    
    [self.clickBtn setImage:[UIImage imageNamed:@"BBS_fabiao"] forState:UIControlStateNormal];
    
    self.clickBtn.layer.borderWidth = 1;
    
    self.clickBtn.layer.borderColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0].CGColor;
    
    self.clickBtn.layer.cornerRadius = 5;
    
    self.rightBtnWidth.constant = 0;
}

- (void)setIsLink:(BOOL)isLink{
    _isLink = isLink;
    
    self.hidden = YES;
}

#pragma mark - 事件响应

- (IBAction)collectTouch:(id)sender {
}
- (IBAction)clickTouch:(id)sender {
}
- (IBAction)labelTouch:(id)sender {
}

@end
