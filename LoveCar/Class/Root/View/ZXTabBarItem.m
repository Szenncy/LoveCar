//
//  ZXBarButton.m
//  03-自定义TabBar
//
//  Created by 证翕 胡 on 15/8/20.
//  Copyright (c) 2015年 证翕 胡. All rights reserved.
//

#import "ZXTabBarItem.h"

//图片的高度
#define kImageViewHeigh 22

//围标的高度
#define kbadgeValueButtonHeight 20

//间隔
#define padding 5

//字体大小
#define fontSize 10

//微标图像的名称
#define bageValue @"numbver_tip"


@interface ZXTabBarItem()

/**
 *  存储图片
 */
@property (weak, nonatomic)UIImageView *imageView;

/**
 *  存储图标
 */
@property (weak, nonatomic)UILabel *titleLabel;

/**
 *  围标按钮
 */
@property (weak, nonatomic)UIButton *badgeValueButton;

//背景图片
@property (weak, nonatomic)UIImageView *backImageView;

//圆形图片
@property (weak, nonatomic)UIImageView *circleImageView;

@end

@implementation ZXTabBarItem

+ (id)tabBarItem{
    return [[self alloc]init];
}

/**
 *  懒加载imageView
 *
 *  @return <#return value description#>
 */
- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:imageView];
        
        _imageView = imageView;
    }
    return _imageView;
}

/**
 *  懒加载背景图片
 *
 *  @return <#return value description#>
 */
- (UIImageView *)backImageView{
    if (!_backImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
//        imageView.backgroundColor = [UIColor blackColor];
        
        imageView.image = [UIImage imageNamed:@"daohang_zhong"];
        
        imageView.alpha = 0.8;
        
        [self addSubview:imageView];
        
        [self sendSubviewToBack:imageView];
        
        _backImageView = imageView;
    }
    return _backImageView;
}

/**
 *  圆形的图片
 *
 *  @return <#return value description#>
 */
- (UIImageView *)circleImageView{
    if (!_circleImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //imageView.backgroundColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0];
        
        imageView.backgroundColor = [UIColor clearColor];
        
        imageView.alpha = 0.2;
        
        [self addSubview:imageView];
        
        [self sendSubviewToBack:imageView];
        
        _circleImageView = imageView;
    }
    
    return _circleImageView;
}

/**
 *  懒加载标题
 *
 *  @return <#return value description#>
 */
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        
        label.textColor = [UIColor grayColor];
        
        label.font = [UIFont systemFontOfSize:fontSize];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        
        _titleLabel = label;
    }
    return _titleLabel;
}

/**
 *  懒加载 微标
 *
 *  @return <#return value description#>
 */
- (UIButton *)badgeValueButton{
    if (!_badgeValueButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        btn.userInteractionEnabled = NO;
        
        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        
        [self addSubview:btn];
        
        _badgeValueButton = btn;
    }
    return _badgeValueButton;
}

/**
 *  布局
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.special) {
        self.imageView.frame = CGRectMake((self.frame.size.width - kImageViewHeigh) * 0.5, padding * 2, kImageViewHeigh, kImageViewHeigh);
        
        self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) - 3, self.frame.size.width, self.frame.size.height - CGRectGetMaxY(self.imageView.frame));
    }else{
        self.imageView.frame = CGRectMake((self.frame.size.width - 40) * 0.5, padding - 1, 40 , 40 );
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        
        self.imageView.layer.cornerRadius = 40 * 0.5;
        
        self.imageView.layer.masksToBounds = YES;
        
        self.imageView.layer.borderWidth = 2;
        
        self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //self.imageView.layer.borderColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)240/255 alpha:1.0].CGColor;
        
        self.circleImageView.frame = CGRectMake((self.frame.size.width - 48) * 0.5, 0, 48, 48);
        
        self.circleImageView.layer.cornerRadius = 48 * 0.5;
        
        self.circleImageView.layer.masksToBounds = YES;
        
        self.backImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 10);
        //self.backImageView.backgroundColor = [UIColor blackColor];
    }
    
}

/**
 *  设置属性
 *
 *  @param tabBarItem <#tabBarItem description#>
 */
- (void)setTabBarItem:(UITabBarItem *)tabBarItem{
    
    _tabBarItem = tabBarItem;
    self.imageView.image = tabBarItem.image;
    self.titleLabel.text = tabBarItem.title;
    self.badgeValue = tabBarItem.badgeValue;
    
}

- (void)setSpecial:(BOOL)special{
    _special = special;
}


/**
 *  重写setter方法
 *
 *  @param Selected <#Selected description#>
 */
- (void)setSelected:(BOOL)Selected{
    _Selected = Selected;
    if (Selected) {
        if (!self.special) {
            self.imageView.image = self.tabBarItem.selectedImage;
            self.titleLabel.textColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0];
        }else{
            self.imageView.layer.borderColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)240/255 alpha:1.0].CGColor;
            self.circleImageView.backgroundColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0];
        }
        
    }else{
        
        if (!self.special) {
            self.imageView.image = self.tabBarItem.image;
            self.titleLabel.textColor = [UIColor grayColor];
        }else{
            self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            
            self.circleImageView.backgroundColor = [UIColor clearColor];
        }
        
    }
}

/**
 *  重写setbadgeValue方法
 *
 *  @param badgeValue <#badgeValue description#>
 */
- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    
    if (badgeValue.length == 0) {
        return;
    }
    
    CGSize size = [self sizeForDynamicWithTitle:badgeValue andSize:CGSizeMake(self.frame.size.width - self.imageView.center.x + padding, kbadgeValueButtonHeight)];
    
    self.badgeValueButton.titleEdgeInsets = UIEdgeInsetsMake(0, padding, padding, padding);
    
    self.badgeValueButton.frame = CGRectMake(self.frame.size.width * 0.5 + padding, padding, size.width + padding * 3, kbadgeValueButtonHeight);
    
    [self.badgeValueButton setBackgroundImage:[self resizeWithImage:[UIImage imageNamed:bageValue]] forState:UIControlStateNormal];
    
    [self.badgeValueButton setTitle:badgeValue forState:UIControlStateNormal];
}

#pragma mark - 内部逻辑运算

/**
 *  拉伸图片
 *
 *  @param image <#image description#>
 *
 *  @return <#return value description#>
 */
- (UIImage *)resizeWithImage:(UIImage *)image{
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0,kbadgeValueButtonHeight * 0.5,0,kbadgeValueButtonHeight * 0.5)];
}

/**
 *  自动获取字符串视图的大小
 *
 *  @param title <#title description#>
 *  @param size  <#size description#>
 *
 *  @return <#return value description#>
 */
- (CGSize)sizeForDynamicWithTitle:(NSString *)title andSize:(CGSize)size{
 
    return [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}


@end
