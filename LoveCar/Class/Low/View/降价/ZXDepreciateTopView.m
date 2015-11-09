//
//  ZXDepreciateTopView.m
//  LoveCar
//
//  Created by zency on 10/19/15.
//  Copyright © 2015 Zency. All rights reserved.
//

#import "ZXDepreciateTopView.h"

#import "Config.h"

#define ZXTopViewButtonImageRatio 0.3

@interface ZXTopViewButton : UIButton
{
    CGFloat imageX;
    CGFloat imageY;
    CGFloat imageW;
    CGFloat imageH;
    
    CGFloat titleX;
    CGFloat titleY;
    CGFloat titleW;
    CGFloat titleH;
}

@end

@implementation ZXTopViewButton

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self.layer setBorderColor:ZXColor(248, 248, 248).CGColor];
    }
    return self;
}

/**
 *  设置图片在button中的layout
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    imageX = titleX + titleW + 3;
    imageH = 6;
    imageY = titleH / 2 - imageH / 2;
    imageW = 10;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/**
 *  设置文本在button中的layout
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    titleX = contentRect.size.width / 3;
    titleW = 30;
    titleH = contentRect.size.height;
    titleY = 0.0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end

#define kTopViewTextFont [UIFont systemFontOfSize:14.0]
#define kButtonWidth (ScreenWidth / 3)
#define kBUttonHeight 40.0

@interface ZXDepreciateTopView ()

@property (nonatomic, strong) UIButton *arrowBtn;

@end

@implementation ZXDepreciateTopView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.layer setBorderWidth:0.4];
        [self.layer setBorderColor:ZXColor(223, 223, 223).CGColor];
        [self setupTopView];
    }
    return self;
}

- (void)setupTopView {
    NSArray *titles = @[@"深圳", @"品牌", @"排序"];
    for (NSInteger i = 0 ; i < [titles count]; i++) {
        UIView *view = [self setupTopViewFrameWithTitle:titles[i] point:i];
        [self addSubview:view];
    }
}

- (ZXTopViewButton *)setupTopViewFrameWithTitle:(NSString *)title point:(NSInteger)point {
    
    ZXTopViewButton *view = [[ZXTopViewButton alloc] init];
    [view setFrame:CGRectMake(kButtonWidth * point, 0.0, kButtonWidth, kBUttonHeight)];
    [view.titleLabel setFont:kTopViewTextFont];
    [view setTitle:title forState:UIControlStateNormal];
    view.imageEdgeInsets = UIEdgeInsetsMake(50, 50, 0, 0);
    [view setTitleColor:ZXColor(45, 50, 55) forState:UIControlStateNormal];
    [view setImage:[UIImage imageNamed:@"cutprice_down"] forState:UIControlStateNormal];
    [view setImage:[UIImage imageNamed:@"lansanjiao"] forState:UIControlStateSelected];
    view.tag = point;
    
    if (view.tag == 0) {
        [view addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchDown];
    } else if (view.tag == 1) {
        [view addTarget:self action:@selector(selecZXries) forControlEvents:UIControlEventTouchDown];
    } else {
        [view addTarget:self action:@selector(selectSort) forControlEvents:UIControlEventTouchDown];
    }
    
    return view;
}

- (void)selectCity {
    NSLog(@"city taped");
}

- (void)selecZXries {
    NSLog(@"Series taped");
}

- (void)selectSort {
    NSLog(@"Sort taped");
}

@end
