//
//  ZXFindForumViewController.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXFindForumViewController.h"
#import "ZXForumSlidingView.h"
#import "UIViewController+ZXTabBar.h"
#import "ZXForumTopViewController.h"
#import "ZXNavForumViewController.h"
#import "UIView+Frame.h"
#import "ZXForumDetailViewController.h"

@interface ZXFindForumViewController ()

@property (weak, nonatomic)ZXForumSlidingView *slidingView;

@property (weak, nonatomic)UIView *backgroundView;

@property (strong, nonatomic)ZXNavForumViewController *topNavVC;

@end

@implementation ZXFindForumViewController

#pragma mark - 初始化

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"找论坛";
    }
    return self;
}

#pragma mark - getter

- (ZXForumSlidingView *)slidingView{
    if (!_slidingView) {
        ZXForumSlidingView *v = [[ZXForumSlidingView alloc]initWithFrame:self.view.bounds];
        
        UINavigationController *navigationControll = [self.view.superview valueForKey:@"navigationController"];
        
        [navigationControll.tabBarController.view addSubview:v];
        
        _slidingView = v;
    }
    return _slidingView;
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
        
        view.backgroundColor = [UIColor lightGrayColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch)];
        view.alpha = 0.3;
        
        UINavigationController *navigationControll = [self.view.superview valueForKey:@"navigationController"];
        
        [view addGestureRecognizer:tap];
        
        [navigationControll.tabBarController.view addSubview:view];
        
        _backgroundView = view;
    }
    return _backgroundView;
}

#pragma mark - ViewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 事件响应

- (IBAction)topBtnTouch:(UIButton *)sender {
    
    switch (sender.tag) {
        case 529:
        {
            [self addNav:@"爱车俱乐部"];
            
        }
            break;
        case 530:
        {
            [self addNav:@"地方分会"];
        }
            break;
        case 531:
        {
            [self addNav:@"人·车·生活"];
        }
            break;
        default:
            break;
    }
    
}
- (IBAction)bottomBtnTouch:(UIButton *)sender {
    UINavigationController *navigationControll = [self.view.superview valueForKey:@"navigationController"];
    
//    NSLog(@"%@",navigationControll);
    
    ZXForumDetailViewController *vc = [[UIStoryboard storyboardWithName:@"ZXForumDetailStoryboard" bundle:nil] instantiateInitialViewController];
    
    vc.ID = sender.tag;
    vc.forumName = sender.titleLabel.text;
    
    [navigationControll pushViewController:vc animated:YES];
}

- (void)tapTouch{
    [self animationRemove];
}

- (void)panTouch:(UIPanGestureRecognizer *)gesture{
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            
        }break;
        case UIGestureRecognizerStateChanged:{
            CGPoint point = [gesture translationInView:self.view];
            
            CGFloat offx = self.topNavVC.view.x + point.x;
            
            if (offx < self.view.frame.size.width * 0.2) {
                self.topNavVC.view.x = self.view.frame.size.width * 0.2;
            }else{
                self.topNavVC.view.x = offx;
            }
            
            [gesture setTranslation:CGPointZero inView:self.view];
        }break;
        case UIGestureRecognizerStateEnded:{
            if (self.topNavVC.view.x > self.view.frame.size.width * 0.2) {
                [self animationRemove];
            }break;
        default:
            break;
        }
    }
}
#pragma mark - 内部逻辑运算

- (void)addNav:(NSString *)title{
    self.topNavVC = [[UIStoryboard storyboardWithName:@"ZXForumTopStoryboard" bundle:nil] instantiateInitialViewController];
    
    self.topNavVC.title = title;
    
    __weak ZXFindForumViewController *vc = self;
    
    [self.topNavVC setCloseCallback:^(BOOL animate) {
        if (animate) {
            [vc animationRemove];
        }else{
            [vc.backgroundView removeFromSuperview];
        }
    }];
    
    UINavigationController *navigationControll = [self.view.superview valueForKey:@"navigationController"];
    
    self.topNavVC.view.frame = CGRectMake(self.view.frame.size.width, 20, self.view.frame.size.width * 0.8, self.view.frame.size.height - 20);
    
    self.topNavVC.navVC = navigationControll;
    
    [self backgroundView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panTouch:)];
    
    [self.topNavVC.view addGestureRecognizer:pan];
    
    [navigationControll.tabBarController.view addSubview:self.topNavVC.view];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundView.alpha = 0.3;
        self.topNavVC.view.frame = CGRectMake(self.view.frame.size.width * 0.2, 20, self.view.frame.size.width * 0.8, self.view.frame.size.height-20);
    }];
    
}

- (void)animationRemove{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.topNavVC.view.frame = CGRectMake(self.view.frame.size.width, 20, [UIScreen mainScreen].bounds.size.width * 0.2, self.topNavVC.view.frame.size.height-20);
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.topNavVC.view removeFromSuperview];
        
    }];
    
}

@end
