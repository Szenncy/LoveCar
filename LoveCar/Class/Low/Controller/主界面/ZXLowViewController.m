//
//  ZXLowViewController.m
//  LoveCar
//
//  Created by zency on 15/10/10.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXLowViewController.h"
#import "ZXMainNavView.h"
#import "ZXHorizontalCollectionViewLayout.h"
#import "ZXCollectionViewCell.h"
#import "ZXSlidingModel.h"
#import "ZXRootNavViewController.h"
#import "UIViewController+ZXTabBar.h"

@interface ZXLowViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_titles;
}
@property (weak, nonatomic)ZXMainNavView *navView;

@property (weak, nonatomic)UICollectionView *collectionView;

@property (strong, nonatomic)NSMutableArray *array;
@end

@implementation ZXLowViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"降价";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_jiangjia_baitian"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_jiangjia_baitian_hit"];
    }
    return self;
}

- (void)initNavView{
    [self.navView awakeFromNib];
    
    _titles = [self controllerWithStoryBoardName:@[@"ZXLowPriceStoryboard",@"ZXActiveStoryboard",@"ZXLowCarStoryboard",@"ZXSignUpStoryboard"]];
    
    self.navView.sliderBar.titles = _titles;
    
    self.navView.chooseBtn.hidden = YES;
    
    self.navView.searchBtn.hidden = YES;
    
    [self.navView.sliderBar setSelectedCallback:^(NSInteger index) {
        
        self.collectionView.contentOffset = CGPointMake(self.collectionView.frame.size.width * index, 0);
    }];
}

#pragma mark - getter

- (ZXMainNavView *)navView{
    if (!_navView) {
        ZXMainNavView *v = [[ZXMainNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        
        //[self.view addSubview:v];
        
        self.navigationItem.titleView = v;
        
        _navView = v;
    }
    
    return _navView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        ZXHorizontalCollectionViewLayout *layout = [[ZXHorizontalCollectionViewLayout alloc]init];
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        
        collectionView.pagingEnabled = YES;
        
        collectionView.delegate = self;
        
        collectionView.dataSource = self;
        
        collectionView.backgroundColor = [UIColor whiteColor];
        
        [collectionView registerClass:[ZXCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        
        [self.view addSubview:collectionView];
        
        _collectionView = collectionView;
        
    }
    return _collectionView;
}

- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
        
        NSArray *objs = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LowPlist.plist" ofType:nil]];
        
        for (NSDictionary *dict in objs) {
            ZXSlidingModel *model = [[ZXSlidingModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            
            [_array addObject:model];
        }
    }
    return _array;
}


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavView];
    
    [self collectionView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ZXRootNavViewController *nav = (ZXRootNavViewController *)self.navigationController;
    
    nav.imageView.image = [nav.images lastObject];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    ZXRootNavViewController *nav = (ZXRootNavViewController *)self.navigationController;
    
    nav.tabBarViewController.tabBarView.hidden = NO;
    
    [nav.imageView removeFromSuperview];
    [nav.images removeLastObject];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.index = indexPath.item;
    cell.viewController = [self viewControllerWithIndexPath:indexPath];
    cell.navigationController = self.navigationController;
    
    return cell;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = (scrollView.contentOffset.x + scrollView.frame.size.width * 0.5)/scrollView.frame.size.width;
    
    self.navView.sliderBar.index = page;
}

#pragma mark - 内部逻辑算法

- (NSArray *)controllerWithStoryBoardName:(NSArray *)name{
    
    NSMutableArray *objs = [NSMutableArray array];
    
    for (NSInteger i = 0;i < name.count; i++) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name[i] bundle:nil];
        
        id vc = [storyBoard instantiateInitialViewController];
        
        [vc setValue:self.array[i] forKey:@"model"];
        
        [objs addObject:vc];
    }
    
    return objs;
}

- (UIViewController *)viewControllerWithIndexPath:(NSIndexPath *)indexPath{
    return _titles[indexPath.item];
}

@end
