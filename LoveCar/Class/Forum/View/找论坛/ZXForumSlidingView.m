//
//  ZXForumSlidingView.m
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXForumSlidingView.h"

@interface ZXForumSlidingView()

@property (weak, nonatomic)UIView *backView;

@property (weak, nonatomic)UIView *contentView;

@property (weak, nonatomic)UIView *topView;

@property (weak, nonatomic)UILabel *titleLabel;

@property (weak, nonatomic)UIButton *closeBtn;

@property (weak, nonatomic)UITableView *tableView;

@end

@implementation ZXForumSlidingView

#pragma mark - 初始化

- (void)awakeFromNib{
    [self backView];
    [self contentView];
    [self topView];
    [self titleLabel];
    [self closeBtn];
    [self tableView];
}

#pragma mark - getter

- (UIView *)backView{
    if (!_backView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height - 20)];
        
        view.backgroundColor = [UIColor lightGrayColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch)];
        view.alpha = 0.3;
        
        [view addGestureRecognizer:tap];
        
        [self addSubview:view];
        
        _backView = view;
    }
    return _backView;
}

- (UIView *)contentView{
    if (!_contentView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width * 0.8, self.frame.size.height)];
        
        view.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:view];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            view.frame = CGRectMake(self.frame.size.width * 0.2, 0, self.frame.size.width * 0.8, self.frame.size.height);
            
        } completion:^(BOOL finished) {
            
        }];
        
        _contentView = view;
    }
    
    return _contentView;
}

- (UIView *)topView{
    if (!_topView) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.contentView.frame.size.width, 44)];
        
        [self.contentView addSubview:v];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(v.frame), self.frame.size.width, 1)];
        
        line.backgroundColor = [UIColor colorWithRed:(float)240/255 green:(float)240/255 blue:(float)240/255 alpha:1.0];
        
        [self.contentView addSubview:line];
        
        _topView = v;
    }
    return _topView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.topView.frame.size.width, self.topView.frame.size.height)];
        
        label.textColor = [UIColor blackColor];//[UIColor colorWithRed:(float)150/255 green:(float)150/255 blue:(float)150/255 alpha:1.0];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self.topView addSubview:label];
        
        _titleLabel = label;
    }
    return _titleLabel;;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.frame = CGRectMake(self.topView.frame.size.width - 46 - 8, 0.5 * (self.topView.frame.size.height - 30 ), 46, 30);
        
        [btn setTitle:@"关闭" forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(closeTouch) forControlEvents:UIControlEventTouchUpInside];
        
        [self.topView addSubview:btn];
        
        _closeBtn = btn;
    }
    return _closeBtn;
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.contentView.frame.size.width, self.contentView.frame.size.height - 64) style:UITableViewStyleGrouped];
        
        //tableView.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - setter

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLabel.text = title;
}

#pragma mark - 事件响应

- (void)tapTouch{
    [self animation];
}

- (void)closeTouch{
    [self animation];
}

#pragma mark - 动画

- (void)animation{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.contentView.frame = CGRectMake(self.frame.size.width, 0, [UIScreen mainScreen].bounds.size.width, self.contentView.frame.size.height);
        
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
       /* NSMutableArray *arr = [NSMutableArray array];
        
        for (ZXSlidingModel *item in self.bookArr) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];
            
            [arr addObject:data];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"chooseView"];
        
        
        if (_block) {
            _block();
        }*/
    }];
    
}

@end
