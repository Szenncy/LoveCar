//
//  ZXHotPostTableViewCell.m
//  LoveCar
//
//  Created by zency on 15/10/15.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXHotPostTableViewCell.h"
#import "NSString+Date.h"
@interface ZXHotPostTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeLabelWidth;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *isImageView;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewLabel;

@property (weak, nonatomic) IBOutlet UIImageView *changImageView;

@end

@implementation ZXHotPostTableViewCell

#pragma mark - 初始化

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - setter

- (void)setItem:(ZXPostModel *)item{
    _item = item;
    
    if ([item.postType integerValue]== 0) {
        self.contentLabel.text = [NSString stringWithFormat:@"%@",item.postTitle];;
        self.typeLabelWidth.constant = 0 ;
    }else if([item.postType integerValue] == 1){
        //精华
        self.contentLabel.text = [NSString stringWithFormat:@"          %@",item.postTitle];
        self.typeLabelWidth.constant = 36;
        self.typeLabel.text = @"精华";
        self.typeLabel.textColor = [UIColor whiteColor];
        self.typeLabel.backgroundColor = [UIColor redColor];
        self.typeLabel.layer.cornerRadius = 5;
        self.typeLabel.layer.masksToBounds = YES;
    }else if([item.postType integerValue] == 2)
    {   //活动
        self.contentLabel.text = [NSString stringWithFormat:@"          %@",item.postTitle];
        self.typeLabelWidth.constant = 36;
        self.typeLabel.text = @"活动";
        self.typeLabel.textColor = [UIColor whiteColor];
        self.typeLabel.backgroundColor = [UIColor blueColor];
        self.typeLabel.layer.cornerRadius = 5;
        self.typeLabel.layer.masksToBounds = YES;
    }else if([item.postType integerValue] == 3)
    {   //投票
        self.contentLabel.text = [NSString stringWithFormat:@"          %@",item.postTitle];
        self.typeLabelWidth.constant = 36;
        self.typeLabel.text = @"投票";
        self.typeLabel.textColor = [UIColor whiteColor];
        self.typeLabel.backgroundColor = [UIColor yellowColor];
        self.typeLabel.layer.cornerRadius = 5;
        self.typeLabel.layer.masksToBounds = YES;
    }
    
    //self.contentLabel.text = item.postTitle;
    
    if ([item.hasImage integerValue] == 0) {
        self.isImageView.hidden = YES;
    }else{
        self.isImageView.hidden = NO;
    }
    
    self.fromLabel.text = item.forumName;
    
    self.timeLabel.text = [NSString stringWithTimeFormat:@"yyyy-MM-dd hh:mm" andTimeInterval:[item.createDate integerValue]];
    
    if (item.adId) {
        self.viewLabel.text = [NSString stringWithFormat:@"%@",item.replyCount];
        self.changImageView.image = [UIImage imageNamed:@"baitian_pinglun_old"];
    }else{
        self.viewLabel.text = [NSString stringWithFormat:@"%.1f W",(float)[item.viewCount floatValue]/10000];
        self.changImageView.image = [UIImage imageNamed:@"dianji_black"];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
