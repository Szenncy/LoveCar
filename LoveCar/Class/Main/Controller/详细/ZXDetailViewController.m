//
//  ZXDetailViewController.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXDetailViewController.h"
#import "UIViewController+ZXTabBar.h"
#import "UIWebView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "ZXNavTop.h"
#import "ZXRootNavViewController.h"
#import "ZXtoolBar.h"
#import "UIView+Toast.h"

@interface ZXDetailViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic)ZXNavTop *navTop;

@property (weak, nonatomic)ZXtoolBar *toolBar;

@property (strong, nonatomic)MBProgressHUD *progressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewOffBottom;

@end

@implementation ZXDetailViewController

#pragma mark - 初始化

- (void)initTool{
    [self.toolBar awakeFromNib];
}

- (void)initNavTop{
    [self.navTop awakeFromNib];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]init]];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    switch (self.status) {
        case ZXDetailViewControllerNews:
            self.navTop.status = ZXNavTopStatusNews;
            break;
        case ZXDetailViewControllerPost:
            self.navTop.status = ZXNavTopStatusPost;
            break;
        default:
            break;
    }
}

- (void)initContent{
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    
    switch (self.status) {
        case ZXDetailViewControllerNews:
        {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.newsModel.newsLink]]];
            self.toolBar.newsModel = self.newsModel;
            self.navTop.status = ZXNavTopStatusNews;
            
            self.progressView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            self.webViewOffBottom.constant = 49;
        }
            break;
        case ZXDetailViewControllerPost:{
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.postModel.postLink]]];
            self.toolBar.postModel = self.postModel;
            self.navTop.status = ZXNavTopStatusPost;
            
            self.progressView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            self.webViewOffBottom.constant = 49;
        }
            break;
        case ZXDetailViewControllerLink:{
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]]];
            
            self.toolBar.isLink = YES;
            
            self.navTop.status = ZXNavTopStatusNews;
            
            self.progressView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            self.webViewOffBottom.constant = 0;
        }
            break;
        case ZXDetailViewControllerEventLink:
        {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]]];
            
            self.toolBar.postModel = nil;
            
            self.navTop.status = ZXNavTopStatusPost;
            
            self.progressView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            self.webViewOffBottom.constant = 49;
        }
            break;
        default:
            break;
    }
}

#pragma mark - getter

- (ZXNavTop *)navTop{
    if (!_navTop) {
        ZXNavTop *top = [[ZXNavTop alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        
        self.navigationItem.titleView = top;
        
        [top setBackBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        _navTop = top;
    }
    return _navTop;
}

- (ZXtoolBar *)toolBar{
    if (!_toolBar) {
        ZXtoolBar *toolBar = [[ZXtoolBar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49)];
        
        [self.view addSubview:toolBar];
        
        _toolBar = toolBar;
    }
    return _toolBar;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavTop];
    
    [self initTool];
    
    [self initContent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webView代理

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

/**
 *  网页开始加载的时候调用
 */
- (void)webViewDidStartLoad:(UIWebView  *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    UIView *footerView = [[UIView alloc] init];
    [footerView setBackgroundColor:[UIColor orangeColor]];
    CGFloat height = 50.0;
    CGFloat width = self.view.frame.size.width;
    CGFloat x = 0.0;
    CGFloat y = self.view.frame.size.height - height * 2;
    [footerView setFrame:CGRectMake(x, y, width, height)];
    
}

/**
 *  网页加载完成的时候调用
 */
- (void )webViewDidFinishLoad:(UIWebView  *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    self.progressView.hidden = YES;
}

/**
 *  网页加载错误的时候调用
 */
- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    self.progressView.hidden = YES;
    
    [self.view makeToast:@"网络错误" duration:1.0 position:CSToastPositionCenter];
}

@end
