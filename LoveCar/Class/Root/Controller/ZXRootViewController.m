//
//  ZXRootViewController.m
//  03-自定义TabBar
//
//  Created by 证翕 胡 on 15/8/20.
//  Copyright (c) 2015年 证翕 胡. All rights reserved.
//

#import "ZXRootViewController.h"
#import "UIViewController+ZXTabBar.h"

#define kTabBarHeight 49

@interface ZXRootViewController ()<ZXTabBarViewDelegate,UINavigationControllerDelegate>
{
    BOOL tabBarIsShow;
    BOOL tabBarIsHide;
}
@end

@implementation ZXRootViewController

#pragma mark - 初始化
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //装载数据
        
        self.viewControllers = [self controllerWithStoryBoardName:@[@"ZXMainStoryboard",@"ZXForumStoryboard",@"ZXUserStoryboard",@"ZXFindStoryboard",@"ZXLowStoryboard"]];
        
        //隐藏系统tabBar
        self.tabBar.hidden = YES;
    }
    
    return self;
}

-(ZXTabBarView *)tabBarView{
    if (!_tabBarView) {
        ZXTabBarView *tabBar = [ZXTabBarView tabBarViewWithDelegate:self];
      
        tabBar.frame = self.tabBar.frame;
        
        tabBar.layer.contents = (id)[UIImage imageNamed:@"bg_article_nav"].CGImage;
        
        _tabBarView = tabBar;
        
        [self.view addSubview:tabBar];
    }
    return _tabBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setViewControllers:(NSArray *)viewControllers{
    
    //这里要换位置,先有装载数据才行
    NSMutableArray *objs = [NSMutableArray array];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *v = viewControllers[i];
        [objs addObject:v.tabBarItem];
    }
    
    self.tabBarView.tabBarItems = objs;
    
    [super setViewControllers:viewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tabBarView:(ZXTabBarView *)tabBarView andSelectedIndex:(NSInteger)index{
    self.selectedIndex = index;
}

/**
 *  被选中之后,跳转之间的控制器
 *
 *  @param selectedIndex <#selectedIndex description#>
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    [self.tabBarView setCurrentSelected:selectedIndex];
}

/**
 *  输入控制器的字符串,通过反射返回存有控制器对象的数组
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)controllerWithStoryBoardName:(NSArray *)name{
    
    NSMutableArray *objs = [NSMutableArray array];
    
    for (NSString *nibname in name) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:nibname bundle:nil];
        
        UINavigationController *nav = [storyBoard instantiateInitialViewController];
        
        nav.tabBarViewController = self;
        
        [objs addObject:nav];
    }
    
    return objs;
}

//#pragma mark - 
//
//- (void)navigationController:(UINavigationController *)navController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    
//    NSLog(@"-->%d",tabBarIsHide);
//    
//    if (!tabBarIsHide)
//    {
//        [self hideTabBar];
//    }
//    else
//    {
//        [self showTabBar];
//    }
//    
//    tabBarIsHide =!tabBarIsHide;
//    
//}
//
//- (void)hideTabBar {
//    if (!tabBarIsShow)
//    { //already hidden
//        return;
//    }
//    
//    [UIView animateWithDuration:0.35
//                     animations:^{
//                         CGRect tabFrame = self.tabBarView.frame;
//                         tabFrame.origin.x = 0 - tabFrame.size.width;
//                         self.tabBarView.frame = tabFrame;
//                     }];
//    tabBarIsShow = NO;
//}
//
//- (void)showTabBar {
//    if (tabBarIsShow)
//    { // already showing
//        return;
//    }
//   
//    [UIView animateWithDuration:0.35
//                     animations:^{
//                         CGRect tabFrame = self.tabBarView.frame;
//                         tabFrame.origin.x = CGRectGetWidth(tabFrame) + CGRectGetMinX(tabFrame);
//                        self.tabBarView.frame = tabFrame;
//                     }];
//    
//    tabBarIsShow = YES;
//}



@end
