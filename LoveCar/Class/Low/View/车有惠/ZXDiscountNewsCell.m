//
//  ZXDiscountNewsCell.m
//  LoveCar
//
//  Created by zency on 10/20/15.
//  Copyright (c) 2015 Zency. All rights reserved.
//

#import "ZXDiscountNewsCell.h"

#import "ZXDiscountNewsView.h"
#import "ZXDiscountNewsCellFrame.h"
#import "Config.h"

@interface ZXDiscountNewsCell ()

@property (nonatomic, weak) ZXDiscountNewsView *discountNewsView;

@end

@implementation ZXDiscountNewsCell

static NSString * const kCellIdentifier = @"DISCOUNT";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    ZXDiscountNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[ZXDiscountNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 取消点击cell时候的效果
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:ZXColor(235, 235, 235)];
        
        // 设置DiscountNewsView
        [self setupDiscountNewsView];
    }
    return self;
}

/**
 *  设置DiscountNewsView
 */
- (void)setupDiscountNewsView {
    /** DiscountNewsView父视图 */
    ZXDiscountNewsView *discountNewsView = [[ZXDiscountNewsView alloc] init];
    [self.contentView addSubview:discountNewsView];
    self.discountNewsView = discountNewsView;
}

/**
 *  override setter
 */
- (void)setDiscountNewsCellFrame:(ZXDiscountNewsCellFrame *)discountNewsCellFrame {
    _discountNewsCellFrame = discountNewsCellFrame;
    [self setupDiscountNewsData];
}

/**
 *  设置eventNews数据
 */
- (void)setupDiscountNewsData {
    self.discountNewsView.discountNewsCellFrame = self.discountNewsCellFrame;
    self.discountNewsView.frame = self.discountNewsCellFrame.discountNewsViewFrame;
}

@end
