//
//  ZXUpdateTableViewCell.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXUpdateTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Date.h"

@interface ZXUpdateTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commtentImageView;


@end

@implementation ZXUpdateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(ZXNewsModel *)item{
    _item = item;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.newsImage] placeholderImage:nil];
    
    self.contentLabel.text = item.newsTitle;
    
    if ([item.newsType integerValue] == 2) {
        self.dateLabel.text = [NSString stringWithTimeFormat:@"yyyy-MM-dd" andTimeInterval:[item.newsCreateTime integerValue]];
        
        self.commentLabel.text = [NSString stringWithFormat:@"%@",item.commentCount];
        
        self.fromLabel.text = item.newsCategory;
        
        self.commtentImageView.hidden = NO;
        
        self.commentLabel.hidden = NO;
    }else{
        self.dateLabel.text = @"";
        
        self.commentLabel.text = @"";
        
        self.commtentImageView.hidden = YES;
        
        self.commentLabel.hidden = YES;
        
        self.fromLabel.text = @"热门";
    }
    
    
}

@end
