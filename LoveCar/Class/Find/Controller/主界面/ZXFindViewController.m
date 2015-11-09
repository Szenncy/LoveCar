//
//  ZXFindViewController.m
//  LoveCar
//
//  Created by zency on 15/10/10.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXFindViewController.h"
#import "ZXMainNavView.h"
#import "ZXHorizontalCollectionViewLayout.h"
#import "ZXCollectionViewCell.h"
#import "ZXSlidingModel.h"

@interface ZXFindViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_titles;
}
@property (weak, nonatomic)ZXMainNavView *navView;

@property (weak, nonatomic)UICollectionView *collectionView;

@property (strong, nonatomic)NSMutableArray *array;

@end

@implementation ZXFindViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"找车";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_zhaoche_baitian"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_zhaoche_baitian_hit"];
    }
    return self;
}

- (void)initNavView{
    [self.navView awakeFromNib];
    
    _titles = [self controllerWithStoryBoardName:@[@"ZXBrandStoryboard",@"ZXConditionStoryboard"]];
    
    self.navView.sliderBar.titles = _titles;
    
    self.navView.chooseBtn.hidden = YES;
    
    [self.navView.sliderBar setSelectedCallback:^(NSInteger index) {
        
        self.collectionView.contentOffset = CGPointMake(self.collectionView.frame.size.width * index, 0);
    }];
}

#pragma mark - getter

- (ZXMainNavView *)navView{
    if (!_navView) {
        ZXMainNavView *v = [[ZXMainNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        
        self.navigationItem.titleView = v;
        
        _navView = v;
    }
    
    return _navView;
}

- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
        
        NSArray *objs = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FindPlist.plist" ofType:nil]];
        
        for (NSDictionary *dict in objs) {
            ZXSlidingModel *model = [[ZXSlidingModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [_array addObject:model];
        }
    }
    return _array;
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


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavView];
    
    [self collectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.index = indexPath.item;
    cell.viewController = [self viewControllerWithIndexPath:indexPath];
    
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
