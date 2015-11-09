//
//  ZXChooseView.m
//  LoveCar
//
//  Created by zency on 15/10/14.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXChooseView.h"
#import "UIView+Frame.h"

@interface ZXChooseView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    didChooseViewBlock _block;
    CGPoint _movePoint;
}
/**
 *  灰色的视图
 */
@property (weak, nonatomic)UIView *backgroundView;

/**
 *  内容视图
 */
@property (weak, nonatomic)UIView *contentView;

/**
 *  顶部视图
 */
@property (weak, nonatomic)UIView *topView;

/**
 *  标题
 */
@property (weak, nonatomic)UILabel *titleLabel;

/**
 *  返回按钮
 */
@property (weak, nonatomic)UIButton *backBtn;

/**
 *  展示和操作的视图
 */
@property (weak, nonatomic)UICollectionView *collectionView;

/**
 *  按钮
 */
@property (weak, nonatomic)UIButton *cellBtn;

@end

@implementation ZXChooseView

#pragma mark - 初始化

/**
 *  视图初始化
 */
- (void)awakeFromNib{
    [self backgroundView];
    [self contentView];
    [self topView];
    [self titleLabel];
    [self backBtn];
    [self collectionView];
    
}

#pragma mark - lazy load

/**
 *  懒加载
 *
 *  @return <#return value description#>
 */
- (UIView *)backgroundView{
    if (!_backgroundView) {
        UIView *view = [[UIView alloc]initWithFrame:self.bounds];
        
        view.backgroundColor = [UIColor lightGrayColor];
        
        view.alpha = 0.3;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch)];
        
        [view addGestureRecognizer:tap];
        
        [self addSubview:view];
        
        _backgroundView = view;
    }
    return _backgroundView;
}

- (UIView *)contentView{
    if (!_contentView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, -self.frame.size.height * 0.8, self.frame.size.width, self.frame.size.height * 0.8)];
        
        view.backgroundColor = [UIColor whiteColor];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.8);
            
        } completion:^(BOOL finished) {
            
        }];
        
        [self addSubview:view];
        
        _contentView = view;
    }
    
    return _contentView;
}


- (UIView *)topView{
    if (!_topView) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
        
        [self.contentView addSubview:v];
        
        _topView = v;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 64, v.frame.size.width, 1)];
        
        line.backgroundColor = [UIColor colorWithRed:(float)237/255 green:(float)237/255 blue:(float)237/255 alpha:1.0];
        
        [self.contentView addSubview:line];
    }
    return _topView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20 + (49 - 20)  * 0.5 , 100, 20)];
        
        label.text = @"已订阅标签";
        
        label.textColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0];
        
        [self.topView addSubview:label];
        
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.frame = CGRectMake(self.topView.frame.size.width - 60, 20 + (49 - 20)  * 0.5 , 50, 20);
        
        [btn setTitle:@"收起" forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(backTouch) forControlEvents:UIControlEventTouchUpInside];
        
        [self.topView addSubview:btn];
        
        _backBtn = btn;
    }
    return _backBtn;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        UILabel *label = [[UILabel alloc]init];
        
        label.font = [UIFont systemFontOfSize:15];
        
        label.text = @"你好啊啊";
        
        CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - (size.width + 10 ) * 4) / 5;
        
        layout.sectionInset = UIEdgeInsetsMake(10, width, 10 , width);
        
        layout.minimumInteritemSpacing = width;
        
        layout.minimumInteritemSpacing = 10;
        
        UICollectionView *v = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.contentView.size.width, self.contentView.size.height - 64) collectionViewLayout:layout];
        
        v.backgroundColor = [UIColor whiteColor];
        
        v.delegate = self;
        v.dataSource = self;
        
        [v registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        
        [v registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        
        v.userInteractionEnabled = YES;
        
        [v addGestureRecognizer:longPress];
        
        [self.contentView addSubview:v];
        
        _collectionView = v;
        
    }
    return _collectionView;
}

#pragma mark - setter

- (void)setDidChooseBlock:(didChooseViewBlock)block{
    _block = block;
}

#pragma mark - 创建按钮

- (UIButton *)button{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [btn setBackgroundColor:[UIColor colorWithRed:(float)245/255 green:(float)245/255 blue:(float)245/255 alpha:1.0]];
    
    [btn setTitleColor:[UIColor colorWithRed:(float)80/255 green:(float)80/255 blue:(float)80/255 alpha:.8] forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 5;
    
    btn.layer.masksToBounds = YES;
    
    btn.layer.borderWidth = 1;
    
    btn.layer.borderColor = [UIColor colorWithRed:(float)220/255 green:(float)220/255 blue:(float)220/255 alpha:1.0].CGColor;
    
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    btn.userInteractionEnabled = NO;
    
    return btn;
}

#pragma mark - 事件响应

- (void)tapTouch{
    
    [self animation];
    
}

- (void)backTouch{
    [self animation];
}

#pragma mark - 内部逻辑事件

- (void)animation{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.contentView.frame = CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.contentView.frame.size.height);
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (ZXSlidingModel *item in self.bookArr) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];
            
            [arr addObject:data];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"chooseView"];

        
        if (_block) {
            _block();
        }
    }];
    
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.bookArr.count;
    }else{
        return self.noBookArr.count;
    }
    
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UIButton *btn = [self button];
        
        ZXSlidingModel *model = self.bookArr[indexPath.item];
        
        btn.frame = cell.contentView.bounds;
        
        [cell.contentView addSubview:btn];
        
        [btn setTitle:model.title forState:UIControlStateNormal];
        
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        ZXSlidingModel *model = self.noBookArr[indexPath.item];
        
        UIButton *btn = [self button];
        
        btn.frame = cell.contentView.bounds;
        
        [cell.contentView addSubview:btn];
        
        [btn setTitle:model.title forState:UIControlStateNormal];
        
        return cell;
    }
    
    return nil;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UILabel *label = [[UILabel alloc]init];
    
    label.font = [UIFont systemFontOfSize:15];
    
    label.text = @"你好啊啊";
    
    CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    return CGSizeMake(size.width + 10, size.height + 10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        
        header.backgroundColor = [UIColor clearColor];
        
        [header.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UILabel *label = [[UILabel alloc]init];
        
        label.frame = CGRectMake(5, (30 - 20) * 0.5, header.frame.size.width, 20);
        
        label.textColor = [UIColor colorWithRed:(float)80/255 green:(float)80/255 blue:(float)80/255 alpha:.8];
        
        label.font = [UIFont systemFontOfSize:13];
        
        label.text = @"长按拖动排序/点击删除";
        
        [header addSubview:label];
        
        return header;
    }else if(indexPath.section == 1){
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        
        [header.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UILabel *label = [[UILabel alloc]init];
        
        label.frame = CGRectMake(5, (30 - 20) * 0.5, header.frame.size.width, 20);
        
        label.textColor = [UIColor whiteColor];
        
        label.font = [UIFont systemFontOfSize:14];
        
        label.text = @"点击订阅更多标签";
        
        header.backgroundColor = [UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0];
        
        [header addSubview:label];
        
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.frame.size.width, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        if(indexPath.item == 0){
            return;
        }
        
        //移动
        UILabel *label = [[UILabel alloc]init];
        
        label.font = [UIFont systemFontOfSize:15];
        
        label.text = @"你好啊啊";
        
        CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - (size.width + 10 ) * 4) / 5;
        
        UICollectionViewCell *cell1 = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.noBookArr.count - 1 inSection:1]];
        
        UICollectionViewCell *originCell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        
        [UIView animateWithDuration:.4 animations:^{
            
            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
            
            if (self.noBookArr.count % 4 != 0) {
                cell.origin = CGPointMake(cell1.x + width + cell1.width,cell1.y);
            }else if(self.noBookArr.count % 4 == 0){
                cell.origin = CGPointMake(width, cell1.y + cell1.height + 10);
            }
            
           for (NSInteger i = indexPath.item + 1; i < self.bookArr.count; i ++ )
            {
                UICollectionViewCell *moveCell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
                
                moveCell.origin = CGPointMake(originCell.x + (size.width + 10 + width) * ((i - 1) % 4),originCell.y + (size.height + 10 + 10) * ((i - 1)/4));
            }
            
        } completion:^(BOOL finished) {
            ZXSlidingModel *model = self.bookArr[indexPath.item];
            [self.noBookArr addObject:model];
            
            [self.bookArr removeObject:model];
            
//            if (_block) {
//                _block();
//            }
            
            self.collectionView = nil;
            [self collectionView];
            
        }];
        
    }else if(indexPath.section == 1){
        
        UILabel *label = [[UILabel alloc]init];
        
        label.font = [UIFont systemFontOfSize:15];
        
        label.text = @"你好啊啊";
        
        CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - (size.width + 10 ) * 4) / 5;
        
        UICollectionViewCell *cell1 = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.bookArr.count - 1 inSection:0]];
        
        UICollectionViewCell *originCell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        
        [UIView animateWithDuration:.4 animations:^{
            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
            
            CGPoint point = originCell.frame.origin;
            
            for (NSInteger i = indexPath.item + 1; i < self.noBookArr.count; i ++ )
            {
                
                UICollectionViewCell *moveCell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:1]];
                
                moveCell.origin = CGPointMake(point.x + (originCell.width + width) * ((i - 1)%4),point.y + (originCell.height + 10) * ((i - 1)/4));
                
                [moveCell layoutIfNeeded];
            }
            
            //其他移动
            if (self.bookArr.count % 4 != 0) {
                cell.origin = CGPointMake(cell1.x + width + cell1.width,cell1.y);
            }else{
                cell.origin = CGPointMake(width, cell1.y + cell1.height + 10);
            }
            
            
            
        } completion:^(BOOL finished) {
            
            if (finished) {
                
                ZXSlidingModel *model = self.noBookArr[indexPath.item];
                
                [self.bookArr addObject:model];
                
                [self.noBookArr removeObject:model];
                
//                if (_block) {
//                    _block();
//                }
                self.collectionView = nil;
                [self collectionView];
                
            }
            
        }];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    ZXSlidingModel *fromModel = nil;
    //获取从哪来
    if (sourceIndexPath.section == 0) {
        fromModel = self.bookArr[sourceIndexPath.item];
    }else{
        fromModel = self.noBookArr[sourceIndexPath.item];
    }
    
    //获取目标
    if (destinationIndexPath.section == sourceIndexPath.section && sourceIndexPath.section == 0)
    {
        [self.bookArr exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        
    }else if (destinationIndexPath.section == sourceIndexPath.section && sourceIndexPath.section == 1){
        [self.noBookArr exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    }else if(destinationIndexPath.section != sourceIndexPath.section && destinationIndexPath.section == 0){
        
        [self.bookArr insertObject:fromModel atIndex:destinationIndexPath.item];
        
        [self.noBookArr removeObjectAtIndex:sourceIndexPath.item];
        
    }else if(destinationIndexPath.section != sourceIndexPath.section && destinationIndexPath.section == 1){
        
        [self.noBookArr insertObject:fromModel atIndex:destinationIndexPath.item];
        
        [self.bookArr removeObjectAtIndex:sourceIndexPath.item];
    }
    
//    if (_block) {
//        _block();
//    }
}

#pragma mark - 事件响应

- (void)longPress:(UILongPressGestureRecognizer *)gesture{
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *indePath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
            
            if (!indePath || (indePath.section == 0 && indePath.item == 0)) {
                break;
            }
            
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indePath];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.collectionView endInteractiveMovement];
        }
            break;
        default:
        {
            [self.collectionView cancelInteractiveMovement];
        }
            break;
    }
}


@end
