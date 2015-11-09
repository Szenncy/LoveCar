//
//  ZXUserViewController.m
//  LoveCar
//
//  Created by zency on 15/10/10.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXUserViewController.h"
#import "ZXUserCollectionViewCell.h"
#import "ZXUserItemModel.h"
#import "ZXRootNavViewController.h"
#import "UIViewController+ZXTabBar.h"
#import "ZXGradualView.h"

@interface ZXUserViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIBarButtonItem *_rightBarBtn;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) UIView *navView;
@property (weak, nonatomic) UIButton *settingBtn;
@property (weak, nonatomic) IBOutlet UIButton *setting;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)NSMutableArray *datas;

@property (strong, nonatomic)NSMutableArray *plugins;

@property (weak, nonatomic)ZXGradualView *gradualView;

@end

@implementation ZXUserViewController

#pragma mark - 初始化
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
       // self.title = @"用户";
        self.tabBarItem.image = [UIImage imageNamed:@"touxiang_hui"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"touxiang_hui"];
    }
    return self;
}

- (void)initView{
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.borderWidth = 0.5;
    self.loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginBtn.layer.masksToBounds = YES;
    self.contentHeight.constant = [UIScreen mainScreen].bounds.size.height - 48;
}

- (void)initCollectionView{
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZXUserCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

- (void)initNav{
    
    [self.gradualView awakeFromNib];
    
    self.gradualView.backView.alpha = 0.0;
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list = self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                imageView.hidden = YES;
            }
        }
    }
    
    self.setting.hidden = YES;
    self.gradualView.settingBtn.hidden = NO;
}

#pragma mark - getter
- (UIView *)navView{
    if (!_navView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        
        view.alpha = 0.0;
        
        view.backgroundColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0];
        
        //[self.view addSubview:view];
        
        //self.navigationItem.titleView = view;
        
        _navView = view;
    }
    return _navView;
}

- (ZXGradualView *)gradualView{
    if (!_gradualView) {
        ZXGradualView *v = [[ZXGradualView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        
        self.navigationItem.titleView = v;
        
        _gradualView = v;
    }
    return _gradualView;
}

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
        
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"plugins.json" ofType:nil]];
        
       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *dic in dict[@"confirmed"]) {
            ZXUserItemModel *item = [[ZXUserItemModel alloc]initWithDictionary:dic error:nil];
            
            [_datas addObject:item];
        }
        
        ZXUserItemModel *item = [[ZXUserItemModel alloc]initWithDictionary:dict[@"adder"] error:nil];
        
        [_datas addObject:item];
    }
    return _datas;
}

- (NSMutableArray *)plugins{
    if (!_plugins) {
        _plugins = [NSMutableArray array];
        
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"plugins.json" ofType:nil]];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *dic in dict[@"plugins"]) {
            ZXUserItemModel *item = [[ZXUserItemModel alloc]initWithDictionary:dic error:nil];
            
            [_plugins addObject:item];
        }
        
    }
    return _plugins;
}

#pragma mark - DidViewLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self initCollectionView];
    
    [self initNav];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ZXRootNavViewController *nav = (ZXRootNavViewController *)self.navigationController;

    nav.imageView.image = [nav.images lastObject];
    
    [self.collectionView reloadData];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //self.navigationController.navigationBar.hidden = YES;
    self.gradualView.settingBtn.hidden = NO;
    //视图选出现之后,将覆盖在上面的截图删去,显示自定义tabbar
    ZXRootNavViewController *nav = (ZXRootNavViewController *)self.navigationController;
    
    nav.tabBarViewController.tabBarView.hidden = NO;
    
    [nav.imageView removeFromSuperview];
    
    [nav.images removeLastObject];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.alpha = 1.0;
}

#pragma mark - 状态栏
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - scrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.gradualView.backView.alpha = (float)(scrollView.contentOffset.y / 64.0);
    
    self.setting.hidden = YES;
    self.gradualView.settingBtn.hidden = NO;
   // self.navigationItem.rightBarButtonItem = _rightBarBtn;
    
    if (scrollView.contentOffset.y <= - 64) {
       // [self.settingBtn removeFromSuperview];
        self.setting.hidden = NO;
        self.gradualView.settingBtn.hidden = YES;
       // self.navigationItem.rightBarButtonItem = nil;
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.setting.hidden = YES;
    self.gradualView.settingBtn.hidden = NO;
}

#pragma mark - collectionView代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZXUserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.item = self.datas[indexPath.item];
    
    [cell setHiddenAddBtn:YES];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZXUserItemModel *item = self.datas[indexPath.item];
    
    if ([item.title isEqualToString:@"添加工具"]) {
        id vc = [[UIStoryboard storyboardWithName:@"ZXAddToolStoryboard" bundle:nil] instantiateInitialViewController];
        
        [vc setValue:self.datas forKey:@"data"];
        
        [vc setValue:self.plugins forKey:@"plugins"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - collectionLayout代理

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [UIScreen mainScreen].bounds.size.width/4;
    
    return CGSizeMake(width - 1, width-1);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

#pragma mark - 事件响应


@end
