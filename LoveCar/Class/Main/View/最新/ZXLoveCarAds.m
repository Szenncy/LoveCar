//
//  ZXLoveCarAds.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXLoveCarAds.h"
#import "UIImageView+WebCache.h"
#import "ZXFocusImg.h"
#import "ZXFocusPostModel.h"

@interface ZXLoveCarAds()<UIScrollViewDelegate>

@property (weak, nonatomic)UIScrollView *scrollView;

@property (weak, nonatomic)UIPageControl *pageControl;

@property (strong, nonatomic)NSTimer *timer;

@end

@implementation ZXLoveCarAds

#pragma mark - load lazy

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        
        scrollView.delegate = self;
        
        scrollView.pagingEnabled = YES;
        
        scrollView.showsHorizontalScrollIndicator = NO;
        
        scrollView.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:scrollView];
        
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        UIPageControl *control = [[UIPageControl alloc]initWithFrame:CGRectMake(30, self.frame.size.height - 25, 30, 30)];
        
        control.currentPageIndicatorTintColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0];
        
        control.pageIndicatorTintColor = [UIColor lightGrayColor];
        
        [self addSubview:control];
        
        _pageControl = control;
    }
    return _pageControl;
}

#pragma mark - setter

- (void)setFocusImgs:(NSArray *)focusImgs{
    _focusImgs = focusImgs;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * focusImgs.count, 0);
    
    for (NSInteger i = 0; i < focusImgs.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        
        if (!self.status) {
            ZXFocusImg *img = focusImgs[i];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:img.imgURL] placeholderImage:nil];
        }else{
            ZXFocusPostModel *img = focusImgs[i];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:img.focusImage] placeholderImage:nil];
        }
        
        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl.numberOfPages = focusImgs.count;
    
    [self startTimer];
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = (scrollView.contentOffset.x + scrollView.frame.size.width * 0.5)/scrollView.frame.size.width;
    
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

#pragma mark - 定时器

- (void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changePage) userInfo:self repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)changePage{
    NSInteger page = self.scrollView.contentOffset.x / self.scrollView.frame.size.width < self.pageControl.numberOfPages - 1?(self.scrollView.contentOffset.x / self.scrollView.frame.size.width)+1:0;
    
    if (page == 0) {
        self.scrollView.contentOffset = CGPointMake(page * self.scrollView.frame.size.width, 0);
    }else{
        [UIView animateWithDuration:0.4 animations:^{
            self.scrollView.contentOffset = CGPointMake(page * self.scrollView.frame.size.width, 0);
        }];
    }
    
    self.pageControl.currentPage = page;
}

@end
