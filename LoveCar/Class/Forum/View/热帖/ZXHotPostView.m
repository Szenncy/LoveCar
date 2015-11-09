//
//  ZXHotPostView.m
//  LoveCar
//
//  Created by zency on 15/10/15.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXHotPostView.h"

@interface ZXHotPostView()

@property (nonatomic, weak)UIImageView *imageView;

@property (nonatomic, weak)UILabel *titleLabel;

@property (nonatomic, weak)UIImageView *iconImageView;

@end

@implementation ZXHotPostView

#pragma mark - 初始化

- (void)awakeFromNib{
    [self imageView];
    [self iconImageView];
    [self titleLabel];
}

#pragma mark - getter 

- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        imageView.image = [UIImage imageNamed:@"retie_header"];
        
        [self addSubview:imageView];
        
        _imageView = imageView;
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 8, self.iconImageView.frame.origin.y, 200, 30)];
        
        title.text = @"24小时热贴";
        
        title.textColor = [UIColor whiteColor];
        
        title.font = [UIFont boldSystemFontOfSize:20];
        
        [self addSubview:title];
        
        _titleLabel = title;
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, (self.imageView.frame.size.height - 30) * 0.5, 30, 30)];
        
        imageView.image = [UIImage imageNamed:@"retie_hot"];
        
        [self addSubview:imageView];
        
        _iconImageView = imageView;
    }
    return _iconImageView;
}

@end
