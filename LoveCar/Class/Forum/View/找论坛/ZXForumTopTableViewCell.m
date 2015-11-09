//
//  ZXForumTopTableViewCell.m
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXForumTopTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ZXForumTopTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZXForumTopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ZXBrandsModel *)model{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] completed:nil];
    
    self.titleLabel.text = model.name;
}

- (void)setItem:(ZXForumModel *)item{
    _item = item;
    
    self.iconImageView.image = nil;
    
    if (item.name) {
         self.titleLabel.text = item.name;
    }else{
         self.titleLabel.text = item.forumName;
    }
    
   
}

- (void)setForumModel:(ZXForumModel *)forumModel{
    _forumModel = forumModel;
    
    self.iconImageView.image = nil;
    
    self.titleLabel.text = forumModel.forumName;
}

@end
