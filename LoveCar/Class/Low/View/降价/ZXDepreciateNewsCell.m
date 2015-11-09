//
//  ZXDepreciateNewsCell.m
//  LoveCar
//
//  Created by zency on 10/19/15.
//  Copyright © 2015 Zency. All rights reserved.
//

#import "ZXDepreciateNewsCell.h"

#import "ZXDepreciateNewsView.h"
#import "ZXDepreciateNewsCellFrame.h"

#import "Config.h"

@interface ZXDepreciateNewsCell ()

@property (nonatomic, weak) ZXDepreciateNewsView *depreciateNewsView;

@end

@implementation ZXDepreciateNewsCell

static NSString * const kCellIdentifier = @"DEPRECIATE";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    ZXDepreciateNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[ZXDepreciateNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 取消点击cell时候的效果
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:ZXColor(235, 235, 235)];
        
        // 设置DepreciateNewsCell
        [self setupDepreciateNewsCell];
    }
    return self;
}

/**
 *  设置DepreciateNewsCell
 */
- (void)setupDepreciateNewsCell {
    /** DepreciateNewsCell父视图 */
    ZXDepreciateNewsView *depreciateNewsView = [[ZXDepreciateNewsView alloc] init];
    [self.contentView addSubview:depreciateNewsView];
    self.depreciateNewsView = depreciateNewsView;
}

/**
 *  override setter
 */
- (void)setDepreciateNewsCellFrame:(ZXDepreciateNewsCellFrame *)depreciateNewsCellFrame {
    _depreciateNewsCellFrame = depreciateNewsCellFrame;
    [self setupDepreciateNewsData];
}

/**
 *  设置DepreciateNews数据
 */
- (void)setupDepreciateNewsData {
    self.depreciateNewsView.depreciateNewsCellFrame = self.depreciateNewsCellFrame;
    self.depreciateNewsView.frame = self.depreciateNewsCellFrame.depreciateNewsViewFrame;
}

@end