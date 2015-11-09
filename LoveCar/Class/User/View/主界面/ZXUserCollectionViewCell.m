//
//  ZXUserCollectionViewCell.m
//  LoveCar
//
//  Created by zency on 15/10/20.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXUserCollectionViewCell.h"
#import "Config.h"
@interface ZXUserCollectionViewCell()
{
    didSelected _selected;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation ZXUserCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(ZXUserItemModel *)item{
    _item = item;
    
    if ([item.title isEqualToString:@"打卡签到"]) {
        self.iconImageView.image = [UIImage imageNamed:@"plugin_weiqiandao"];
        self.titleLabel.text = @"未签到";
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.highlightedTextColor = [UIColor whiteColor];
        self.backgroundColor = ZXColor(255, 192, 108);
    }else{
        self.iconImageView.image = [UIImage imageNamed:item.imageName];
        self.titleLabel.text = item.title;
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor whiteColor];
        
    }

   // NSLog(@"%d",[self.item.selected boolValue]);
    self.addBtn.selected = [self.item.selected boolValue];
}

- (void)didSelected{
    self.addBtn.selected = !self.addBtn.selected;
    self.item.subscribed = @(self.addBtn.selected);
    self.item.selected = @(self.addBtn.selected);
//    NSLog(@"%d",[self.item.selected boolValue]);
}

- (void)setDidSelected:(didSelected)block{
    _selected = block;
}

- (void)setHiddenAddBtn:(BOOL)hidden{
    self.addBtn.hidden = hidden;
}

- (BOOL)selected{
    return self.addBtn.selected;
}

- (IBAction)addTouch:(id)sender {
   // [self didSelected];
    if (_selected) {
        _selected();
    }
}

@end
