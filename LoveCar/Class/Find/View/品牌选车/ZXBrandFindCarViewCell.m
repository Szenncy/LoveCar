//
//  ZXBrandFindCarViewCell.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015 Zency. All rights reserved.
//

#import "ZXBrandFindCarViewCell.h"
#import "Config.h"

@implementation ZXBrandFindCarViewCell

static NSString * const kCellIdentifier = @"BRANDFINDCAR";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    ZXBrandFindCarViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[ZXBrandFindCarViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置cell的背景色
        self.backgroundColor = [UIColor clearColor];
        
        self.iconView = [[UIImageView alloc] init];
        CGFloat iconViewX = 15.0;
        CGFloat iconViewY = 10.0;
        CGFloat iconViewW = 40.0;
        CGFloat iconViewH = 40.0;
        [self.iconView setContentMode:UIViewContentModeScaleAspectFit];
        [self.iconView setFrame:CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH)];
        [self.contentView addSubview:self.iconView];
        
        self.brandLabel = [[UILabel alloc] init];
        [self.brandLabel setFont:[UIFont systemFontOfSize:16.0]];
        [self.brandLabel setTextColor:ZXColor(45, 46, 50)];
        [self.brandLabel setFrame:CGRectMake(CGRectGetMaxY(self.iconView.frame) + 15, 0.0, 200.0, 60.0)];
        [self.contentView addSubview:self.brandLabel];
    }
    return self;
}

@end
