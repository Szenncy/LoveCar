//
//  ZXTitleCollectionViewCell.m
//  LoveCar
//
//  Created by zency on 15/10/20.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXTitleCollectionViewCell.h"

@interface ZXTitleCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZXTitleCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLabel.text = title;
}

@end
