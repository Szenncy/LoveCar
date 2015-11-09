//
//  ZXPostTableViewCell.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXPostTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Date.h"

@interface ZXPostTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *fromLabel;

@property (weak, nonatomic) IBOutlet UILabel *checkLabel;

@end

@implementation ZXPostTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(ZXPostModel *)item{
    _item = item;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.postImage] placeholderImage:nil];
    
    self.contentLabel.text = item.postTitle;
    
    self.fromLabel.text = item.forumName;
    
    self.checkLabel.text = [NSString stringWithFormat:@"%.1f W",(float)[item.viewCount floatValue]/10000];
}

@end
