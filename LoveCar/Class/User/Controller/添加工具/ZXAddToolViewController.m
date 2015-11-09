//
//  ZXAddToolViewController.m
//  LoveCar
//
//  Created by zency on 15/10/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXAddToolViewController.h"
#import "UIViewController+ZXTabBar.h"
#import "ZXUserTop.h"
#import "ZXUserItemModel.h"
#import "ZXUserCollectionViewCell.h"

@interface ZXAddToolViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (weak, nonatomic)ZXUserTop *userTop;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic)UIImageView *imageView;

@end

@implementation ZXAddToolViewController

#pragma mark - 初始化

- (void)initCollectionView{
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZXUserCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

- (void)initNavBar{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]init]];
}

#pragma mark - getter(load lazy)

- (ZXUserTop *)userTop{
    if (!_userTop) {
        ZXUserTop *view = [[ZXUserTop alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        
        [view setBackCallback:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        //[self.view addSubview:view];
        self.navigationItem.titleView = view;
        
        _userTop = view;
    }
    return _userTop;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        
        [self.navigationController.tabBarViewController.view addSubview:imageView];
        
        _imageView = imageView;
    }
    return _imageView;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    //self.navigationController.navigationBar.hidden = NO;
    [self.userTop awakeFromNib];
    
    [self initCollectionView];
    
    [self initNavBar];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   // self.navigationController.navigationBar.alpha = 0;
    
    [self.collectionView reloadData];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.imageView removeFromSuperview];
    
   // self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    [self.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(handleGesture:)];
}

#pragma mark - 状态栏
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - collectionView代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.plugins.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZXUserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.item = self.plugins[indexPath.row];
    
    [cell setHiddenAddBtn:NO];
    
    [cell setDidSelected:^{
        [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXUserCollectionViewCell *cell = (ZXUserCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [cell didSelected];
    
    if ([cell selected]) {
        //YES 添加
        [self.data insertObject:self.plugins[indexPath.row] atIndex:self.plugins.count - 1];
        
    }else{
        //NO 删除
        [self.data removeObject:self.plugins[indexPath.row]];
    }
    
}

#pragma mark - collectionLayout代理

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [UIScreen mainScreen].bounds.size.width/4;
    
    return CGSizeMake(width - 1, width - 1);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(-20, 0, 0, 0);
}

#pragma mark - 内部逻辑算法

/**
 *  截取屏幕的方法
 */
- (void)cutScreem{
    
    UIGraphicsBeginImageContextWithOptions(self.tabBarViewController.view.bounds.size, YES, 1.0);
    
    [self.navigationController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    self.imageView.image = image;
    
}

- (void)handleGesture:(UIPanGestureRecognizer *)gesture{
    CGPoint point = [gesture translationInView:self.view];
    
    if (point.x > 0) {
        self.userTop.alpha = ([UIScreen mainScreen].bounds.size.width - point.x * 1.1)/[UIScreen mainScreen].bounds.size.width;
    }
    
//    [gesture setTranslation:CGPointZero inView:self.view];
}

@end
