//
//  ZXEventNewsCell.m
//  LoveCar
//
//  Created by zency on 10/19/15.
//  Copyright (c) 2015 Zency. All rights reserved.
//

#import "ZXEventNewsCell.h"
#import "ZXEventNewsView.h"
#import "ZXEventNewsCellFrame.h"

#import "Config.h"

@interface ZXEventNewsCell ()

/**
 *  eventNews父视图
 */
@property (nonatomic, weak) ZXEventNewsView *eventNewsView;

@end

@implementation ZXEventNewsCell

static NSString * const kCellIdentifier = @"EVENT";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    ZXEventNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[ZXEventNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 取消点击cell时候的效果

        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:ZXColor(235, 235, 235)];
        // 设置EventNewsView
        [self setupEventNewsView];
    }
    return self;
}

/**
 *  设置EventNewsView
 */
- (void)setupEventNewsView {
    /** eventNews父视图 */
    ZXEventNewsView *eventNewsView = [[ZXEventNewsView alloc] init];
    [self.contentView addSubview:eventNewsView];
    self.eventNewsView = eventNewsView;
}

/**
 *  override setter
 */
- (void)setEventNewsCellFrame:(ZXEventNewsCellFrame *)eventNewsCellFrame {
    _eventNewsCellFrame = eventNewsCellFrame;
    // 设置eventNews数据
    [self setupEventNewsData];
}

/**
 *  设置eventNews数据
 */
- (void)setupEventNewsData {
    self.eventNewsView.eventNewsCellFrame = self.eventNewsCellFrame;
    self.eventNewsView.frame = self.eventNewsCellFrame.eventNewsViewFrame;
}

@end
