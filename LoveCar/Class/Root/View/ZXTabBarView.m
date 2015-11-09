//
//  ZXTabBarView.m
//  03-自定义TabBar
//
//  Created by 证翕 胡 on 15/8/20.
//  Copyright (c) 2015年 证翕 胡. All rights reserved.
//

#import "ZXTabBarView.h"
#import "ZXTabBarItem.h"

//设置背景图片
#define BgImageName @"tabbar_bg"
//设置tag
#define TagNum 10000
//零
#define Zero 0
@interface ZXTabBarView()

/**
 *  存储当前被选中的按钮
 */
@property (strong,nonatomic)ZXTabBarItem *currentTabBarItem;

/**
 *  存储item到数组中
 */
@property (strong, nonatomic)NSMutableArray *items;

//背景图片
//@property (weak, nonatomic)UIView *backView;

@end

@implementation ZXTabBarView

+ (id)tabBarView{
  
    ZXTabBarView *tabBar = [[self alloc]init];
    
    tabBar.layer.contents = (id)[UIImage imageNamed:BgImageName].CGImage
    ;
    
    return tabBar;
}

+ (id)tabBarViewWithDelegate:(id <ZXTabBarViewDelegate>)delegate{
    ZXTabBarView *tabBar = [[self alloc]init];
    
    tabBar.delegate = delegate;
    
    tabBar.layer.contents = (id)[UIImage imageNamed:BgImageName].CGImage
    ;
    
    return tabBar;
}

/**
 *  懒加载items数组
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

/*- (UIView *)backView{
    if (!_backView) {
        UIView *v = [[UIView alloc]init];
        
        v.frame = self.bounds;
        
        v.alpha = 0.9;
        
        v.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:v];
        
        [self sendSubviewToBack:v];
        _backView = v;
    }
    return _backView;
}*/

/**
 *  重写setter方法
 *
 *  @param tabBarItems <#tabBarItems description#>
 */
- (void)setTabBarItems:(NSArray *)tabBarItems{
    _tabBarItems = tabBarItems;
    
    //计算bar的宽度
    CGFloat barWidth = self.frame.size.width / tabBarItems.count;
    
    //计算bar的高度
    CGFloat barHeight = self.frame.size.height;
    
    for (int i = Zero; i < tabBarItems.count; i++) {
        
        ZXTabBarItem *tabBarItem = [ZXTabBarItem tabBarItem];
        
        tabBarItem.tabBarItem = tabBarItems[i];
        
        /*if (i < 2) {
            tabBarItem.frame = CGRectMake(i * (barWidth + 10), Zero, barWidth + 10, barHeight);
            
            tabBarItem.layer.contents = (id)[UIImage imageNamed:@"daohang_bian"].CGImage;
        }else if (i == 2){
            tabBarItem.frame = CGRectMake(i * barWidth, Zero , barWidth - 40,barHeight);
            
            tabBarItem.layer.contents = (id)[UIImage imageNamed:@"daohang_zhong"].CGImage;
            
            tabBarItem.special = YES;
        }else
        {
            
        }*/
        
        if (i != 2) {
            
            tabBarItem.frame = CGRectMake(i * barWidth, Zero, barWidth, barHeight + 5);
            
//            tabBarItem.layer.contents = (id)[UIImage imageNamed:@"daohang_bian"].CGImage;

        }else{
            tabBarItem.frame = CGRectMake(i * barWidth, Zero , barWidth,barHeight);
            
            tabBarItem.special = YES;
        }
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i * barWidth, Zero, barWidth, barHeight)];
        
        view.layer.contents = (id)[UIImage imageNamed:@"daohang_bian"].CGImage;
        
        view.alpha = 0.95;
        
        [self addSubview:view];
        
        [self sendSubviewToBack:view];
        
        tabBarItem.tag = i + TagNum;
        
        [tabBarItem addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.items addObject:tabBarItem];
        
        [self addSubview:tabBarItem];
        
    }
    [self setCurrentSelected:Zero];
    
    //[self backView];
}

/**
 *  设置当前按钮
 *
 *  @param selectedIndex <#selectedIndex description#>
 */
- (void)setCurrentSelected:(NSUInteger)selectedIndex{

    _currentTabBarItem.Selected = NO;
    
    _currentTabBarItem = self.items[selectedIndex];
    
    _currentTabBarItem.Selected = YES;
}

//点击按钮响应事件
- (void)btnClick:(ZXTabBarItem *)btn{
    
    [self setCurrentSelected:btn.tag - TagNum];
    
    [self.delegate tabBarView:self andSelectedIndex:btn.tag - TagNum];
}

@end
