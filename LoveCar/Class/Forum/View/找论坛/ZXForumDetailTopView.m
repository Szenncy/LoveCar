//
//  ZXForumDetailTopView.m
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXForumDetailTopView.h"
#import "ZXModerator.h"

@interface ZXForumDetailTopView()
@property (weak, nonatomic) IBOutlet UIImageView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *PostLabel;

@end

@implementation ZXForumDetailTopView

#pragma mark - 初始化

- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZXForumDetailTopView" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    [self addSubview:self.contentView];
}

#pragma mark - setter 
/**
 *  设置版主
 *
 *  @param moderators <#moderators description#>
 */
- (void)setModerators:(NSArray *)moderators{
    _moderators = moderators;
    NSMutableString *title = [NSMutableString string];
    
    for (NSInteger i = 0; i < moderators.count; i++) {
        if (i == 0) {
            ZXModerator *item = moderators[i];
            [title appendFormat:@"%@",item.moderatorName];
        }else{
            ZXModerator *item = moderators[i];
            [title appendFormat:@",%@",item.moderatorName];
        }
    }
    
    if (title.length == 0) {
        self.hostLabel.text = @"版主: 无";
        return;
    }
    
    self.hostLabel.text = [NSString stringWithFormat:@"版主: %@",title];
}

/**
 *  设置帖子数量
 *
 *  @param postNum <#postNum description#>
 */
- (void)setPostNum:(NSInteger)postNum{
    _postNum = postNum;
    
    self.PostLabel.text = [NSString stringWithFormat:@"帖子: %ld",(long)postNum];
}

/**
 *  设置主题
 *
 *  @param themeNum <#themeNum description#>
 */
- (void)setThemeNum:(NSInteger)themeNum{
    _themeNum = themeNum;
    
    self.titleNumLabel.text = [NSString stringWithFormat:@"主题: %ld",(long)themeNum];
}

/**
 *  设置标题
 *
 *  @param title <#title description#>
 */
- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLabel.text = title;
}

@end
