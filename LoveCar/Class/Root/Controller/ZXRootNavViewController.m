//
//  ZXRootNavViewController.m
//  LoveCar
//
//  Created by zency on 15/10/14.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXRootNavViewController.h"
#import "UIViewController+ZXTabBar.h"

@interface ZXRootNavViewController ()

@end

@implementation ZXRootNavViewController

/**
 *  懒加载
 *
 *  @return 返回初始化之后的值
 */
- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        imageView.frame = self.view.bounds;
        
        [self.topViewController.view addSubview:imageView];
        
        _imageView = imageView;
    }
    return _imageView;
}

- (NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  截取屏幕的方法
 */
- (void)cutScreem{
    
    UIGraphicsBeginImageContextWithOptions(self.tabBarViewController.view.bounds.size, YES, 0.0);
    
    [self.tabBarViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self.images addObject:image];
   // NSLog(@"%@",self.images);
}

/**
 *  重写父类的方法
 *
 *  @param viewController <#viewController description#>
 *  @param animated       <#animated description#>
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [self cutScreem];
    
    self.imageView = nil;
    
    self.imageView.image = [self.images lastObject];
    
    [super pushViewController:viewController animated:animated];
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    //[self.imageView removeFromSuperview];
    
    //[self.images removeLastObject];
    
    return [super popViewControllerAnimated:animated];
}

@end
