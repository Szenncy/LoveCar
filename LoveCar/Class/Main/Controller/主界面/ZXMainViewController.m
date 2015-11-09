//
//  ZXMainViewController.m
//  LoveCar
//
//  Created by zency on 15/10/10.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXMainViewController.h"
#import "ZXMainNavView.h"
#import "ZXHorizontalCollectionViewLayout.h"
#import "ZXCollectionViewCell.h"
#import "UIViewController+ZXTabBar.h"
#import "ZXRootNavViewController.h"
#import "ZXUpdateViewController.h"
#import "ZXMainNewsViewController.h"
#import "ZXSlidingModel.h"
#import "ZXChooseView.h"

@interface ZXMainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    /**
     *  存储控制器的数组
     */
    NSMutableArray *_titles;
    /**
     *  存储订阅的数组
     */
    NSMutableArray *_book;
    /**
     *  存储未订阅的数组
     */
    NSMutableArray *_nobook;
}

/**
 *  自定义NavBar
 */
@property (weak, nonatomic)ZXMainNavView *navView;

/**
 *  滑动的控制器
 */
@property (weak, nonatomic)UICollectionView *collectionView;

/**
 *  筛选的视图
 */
@property (weak, nonatomic)ZXChooseView *chooseView;

/**
 *  存储所有可以订阅的数组
 */
@property (strong, nonatomic)NSMutableArray *array;
@end

@implementation ZXMainViewController

#pragma mark - 初始化
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_shouye_baitian"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_shouye_baitian_hit"];
    }
    return self;
}

/**
 *  初始化Nav
 */
- (void)initNavView{
    [self.navView awakeFromNib];
    
    [self array];
    
    /**
     *  从UserDefault获得存储的数组
     */
    
    NSArray *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseView"];
    
    /**
     *  如果为空,则固定
     */
    if (!obj) {
        _book = [NSMutableArray arrayWithArray:@[self.array[0],self.array[1],self.array[2],self.array[3],self.array[4],self.array[5]]];
    }else{
        
        NSMutableArray *objs = [NSMutableArray array];
        
        for (NSData *data in obj) {
            ZXSlidingModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            [objs addObject:model];
        }
        
        _book = [NSMutableArray arrayWithArray:objs
                 ];
    }
    
    //获取订阅之后的数据库数组
    _titles = (NSMutableArray *)[self controllerWithStoryBoardName:_book];
    
    //区分出没有订阅的数据
    for (NSInteger i = 0; i < _book.count; i++) {
        
        ZXSlidingModel *item = _book[i];
        
        [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([item.title isEqualToString:[obj valueForKey:@"title"]]) {
                [self.array removeObject:obj];
            }
        }];
    }
    
    _nobook = [NSMutableArray arrayWithArray:self.array];
    
    self.navView.sliderBar.titles = _book;
    
    //滑动栏的点击回调
    [self.navView.sliderBar setSelectedCallback:^(NSInteger index) {
        
        self.collectionView.contentOffset = CGPointMake(self.collectionView.frame.size.width * index, 0);
    }];
}

#pragma mark - getter

- (ZXMainNavView *)navView{
    if (!_navView) {
        ZXMainNavView *v = [[ZXMainNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        
        //点击选中的回调
        [v setDidChoose:^{
            [self chooseView];
        }];
        
        self.navigationItem.titleView = v;
        
        _navView = v;
    }
    
    return _navView;
}

- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
        
        NSArray *objs = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MainPlist.plist" ofType:nil]];
        
        for (NSDictionary *dict in objs) {
            ZXSlidingModel *item = [[ZXSlidingModel alloc]init];
            [item setValuesForKeysWithDictionary:dict];
            
            [_array addObject:item];
        }
        
    }
    return _array;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        ZXHorizontalCollectionViewLayout *layout = [[ZXHorizontalCollectionViewLayout alloc]init];
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        
        collectionView.pagingEnabled = YES;
        
        collectionView.backgroundColor = [UIColor whiteColor];
        
        collectionView.delegate = self;
        
        collectionView.dataSource = self;
        
        [collectionView registerClass:[ZXCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        
        [self.view addSubview:collectionView];
        
        _collectionView = collectionView;
        
    }
    return _collectionView;
}

- (ZXChooseView *)chooseView{
    if (!_chooseView) {
        
        ZXChooseView *v = [[ZXChooseView alloc]initWithFrame:self.view.bounds];
        
        [self.navigationController.tabBarViewController.view addSubview:v];
        
        //初始化UI
        [v awakeFromNib];
        
        //获得订阅的数组
        v.bookArr = _book;
        
        //获得未订阅的数组
        v.noBookArr = _nobook;
        
        //点击选择按钮的回调
        [v setDidChooseBlock:^{
            
            _titles = (NSMutableArray *)[self controllerWithStoryBoardName:_book];
            
            //self.navView.sliderBar.titles = _titles;
            
            [self.navView.sliderBar.collectionView reloadData];
            
            [self.collectionView reloadData];
            
        }];
        
        _chooseView = v;
    }
    
    return _chooseView;
}

#pragma mark - ViewDidLoad
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
    
    //视图选出现之后,将覆盖在上面的截图删去,显示自定义tabbar
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

- (NSArray *)controllerWithStoryBoardName:(NSMutableArray *)name{
    
    [_titles removeAllObjects];
    
    NSMutableArray *objs = [NSMutableArray array];
    
    for (NSInteger i = 0; i < name.count; i++) {
        if (i == 0) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ZXUpdateStoryboard" bundle:nil];
            
            ZXUpdateViewController *vc = [storyBoard instantiateInitialViewController];
            
            vc.model = name[i];
            
            [objs addObject:vc];
        }else{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ZXMainNewsStoryboard" bundle:nil];
            
            ZXMainNewsViewController *vc = [storyBoard instantiateInitialViewController];
            
            vc.model = name[i];
            
            [objs addObject:vc];
        }
    }
    
    return objs;
}

- (UIViewController *)viewControllerWithIndexPath:(NSIndexPath *)indexPath{
    return _titles[indexPath.item];
}


@end
