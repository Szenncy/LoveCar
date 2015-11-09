//
//  ZXSliderBar.m
//  LoveCar
//
//  Created by zency on 15/10/12.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXSliderBar.h"
#import "ZXSliderBarItem.h"

@interface ZXSliderBar()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSInteger _selectedPage;
    CGPoint _movePoint;
    didSelectedCallback _selectedCallback;
}

@property (weak, nonatomic)UIView *line;

//@property (strong, nonatomic)NSMutableArray *items;

@property (weak, nonatomic)UIView *left;

@end

@implementation ZXSliderBar


#pragma mark - getter

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout.minimumInteritemSpacing = 20;
        
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        
        collectionView.delegate = self;
        
        collectionView.dataSource = self;
        
        collectionView.showsHorizontalScrollIndicator = NO;
        
        collectionView.backgroundColor = [UIColor whiteColor];
        
        [collectionView registerClass:[ZXSliderBarItem class] forCellWithReuseIdentifier:@"Cell"];
        
        [self addSubview:collectionView];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UIView *)line{
    if (!_line) {
        UIView *view = [[UIView alloc]init];
        
        view.backgroundColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0];;
        
        UILabel *label = [[UILabel alloc]init];
        
        UIViewController *vc = self.titles[0];
        
        label.text = vc.title;
        
        CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        view.frame = CGRectMake(10, self.collectionView.frame.size.height - 1.5, size.width, 1);
        
        [self.collectionView bringSubviewToFront:label];
        
        [self.collectionView addSubview:view];
        
        _line = view;
    }
    return _line;
}

- (UIView *)left{
    if (!_left) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width - 2, 0, 2, self.frame.size.height)];
        v.backgroundColor = [UIColor whiteColor];
        
        v.alpha = 0.9;
        
        [self addSubview:v];
        
        [self bringSubviewToFront:v];
        
        _left = v;
    }
    return _left;
}

#pragma mark - setter
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    
    [self.collectionView reloadData];
    
    [self line];
    
    [self left];
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    
    CGFloat offx = 0.0;
    
    CGSize size = CGSizeZero;
    
    UILabel *label = [[UILabel alloc]init];
    
    for(NSInteger i = 0; i <= index; i++) {
        
        label.text = [self.titles[i] valueForKey:@"title"];
        
        size = [label sizeThatFits:CGSizeMake(375, 20)];
        
        if (i == 0) {
            offx = 10;
        }else {
            offx +=20 + size.width;
        }
    }
    
    if (_selectedPage != index) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            if (offx < self.frame.size.width) {
                self.collectionView.contentOffset = CGPointMake(0, 0);
                _movePoint.x = 0;
            }else if(index > _selectedPage){
                self.collectionView.contentOffset = (CGPointMake(_movePoint.x + size.width + 20, 0));
                
                _movePoint.x = _movePoint.x + size.width + 20;
            }else if(index < _selectedPage){
                self.collectionView.contentOffset =(CGPointMake(_movePoint.x - size.width - 20, 0));
                _movePoint.x = _movePoint.x - size.width - 20;
            }
            
        }];
        _selectedPage = index;
        
        [self.collectionView reloadData];
    }

    //self.collectionView.contentOffset = CGPointMake(50 * index, 0);
    
//   // NSLog(@"-------%zd %zd",_selectedPage,_index);
//    
    //[self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
}

#pragma mark - 实现方法

- (void)setSelectedCallback:(didSelectedCallback)callback{
    _selectedCallback = callback;
}

#pragma mark - UICollection代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZXSliderBarItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (_selectedPage == indexPath.item) {
        item.isSelected = YES;
        
        [UIView animateWithDuration:.2 animations:^{
            self.line.frame = CGRectMake(item.frame.origin.x, self.frame.size.height - 1.5, item.frame.size.width, 1);
        }];
        
    }else{
        item.isSelected = NO;
    }
    
    item.title = [self.titles[indexPath.item] valueForKey:@"title"];
    
    return item;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UILabel *label = [[UILabel alloc]init];
    
    label.text = [self.titles[indexPath.item] valueForKey:@"title"];
    
    CGSize size = [label sizeThatFits:CGSizeMake(375, 20)];
    
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectedPage = indexPath.row;
    
    ZXSliderBarItem *item = (ZXSliderBarItem *)[collectionView cellForItemAtIndexPath:indexPath];
    
    CGFloat sum = (item.frame.origin.x - collectionView.contentOffset.x)/self.frame.size.width;
    
    if (sum > 0.5&&collectionView.contentOffset.x < collectionView.contentSize.width - collectionView.frame.size.width) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGFloat x = MIN(item.frame.size.width  + collectionView.contentOffset.x, collectionView.contentSize.width - collectionView.frame.size.width + 2);
            
            collectionView.contentOffset = CGPointMake(x + 20, 0);
            
            _movePoint.x = x + 20;
        }];
    }else if(sum < 0.5 && collectionView.contentOffset.x != 0){
        
        CGFloat x = MAX(collectionView.contentOffset.x - item.frame.size.width, 0);
        
        [UIView animateWithDuration:0.5 animations:^{
            collectionView.contentOffset = CGPointMake(x - 20, 0);
        }];
        _movePoint.x = x - 20;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.line.frame = CGRectMake(item.frame.origin.x, self.frame.size.height - 1.5, item.frame.size.width, 1);
    }];
    
    if (_selectedCallback) {
        _selectedCallback(indexPath.item);
    }
    
    [collectionView reloadData];
}

#pragma mark - scrollView代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

#pragma mark - 内部逻辑算法

- (UIViewController *)viewControllerWithIndexPath:(NSIndexPath *)indexPath{
    return self.titles[indexPath.item];
}


@end
