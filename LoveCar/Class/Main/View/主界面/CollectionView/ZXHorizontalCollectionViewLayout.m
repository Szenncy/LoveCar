//
//  ZXHorizontalCollectionViewLayout.m
//  02-水平collectionView
//
//  Created by zency on 15/9/11.
//  Copyright (c) 2015年 Zency. All rights reserved.
//

#import "ZXHorizontalCollectionViewLayout.h"

@interface ZXHorizontalCollectionViewLayout()
{
    /**
     *  存储子对象属性
     */
    NSMutableArray *_itemAtrributes;
}

@end

@implementation ZXHorizontalCollectionViewLayout

/**
 *  reloadData会调用这个程序
 */
- (void)prepareLayout{
    //1.重新初始化item数组
    _itemAtrributes = [NSMutableArray array];
    
//    NSLog(@"%ld",(long)[self.collectionView numberOfItemsInSection:0]);
    
    CGFloat y = - 60;
    
    CGFloat w = self.collectionView.frame.size.width;
    
    CGFloat h = self.collectionView.frame.size.height;
    
    
    //2.遍历collectionView里面的item,这里只有一个section
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        //这里设置item的x,y,w,h
        CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
        
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        attribute.frame = CGRectMake(x, y, w, h);
        
        [_itemAtrributes addObject:attribute];
    }
    
    
}

/**
 *  设置contentSize的大小,这里是分水平方向还是垂直方向
 *
 *  @return contentSize的大小
 */
- (CGSize)collectionViewContentSize{
    
//    NSLog(@"width:%f,height:%f",_itemAtrributes.count * self.collectionView.frame.size.width,self.collectionView.frame.size.height);
    
    return CGSizeMake(_itemAtrributes.count * self.collectionView.frame.size.width, 0);
}

/**
 *  返回指定大小的item
 *
 *  @param rect 指定大小,这里大小都一样,所以不用在意这个参数
 *
 *  @return 返回一系列item
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _itemAtrributes;
}

/**
 *  返回个别的item属性
 *
 *  @param indexPath 索引指定的indexpath
 *
 *  @return 返回指定的item属性对象
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return _itemAtrributes[indexPath.item];
}



@end
