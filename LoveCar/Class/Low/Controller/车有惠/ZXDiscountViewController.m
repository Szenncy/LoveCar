//
//  ZXDiscountViewController.m
//  LoveCar
//
//  Created by zency on 10/20/15.
//  Copyright (c) 2015 Zency. All rights reserved.
//

#import "ZXDiscountViewController.h"
#import "ZXDetailViewController.h"

#import "MJExtension.h"
#import "MJRefresh.h"


#import "ZXDiscountNewsCell.h"
#import "ZXDiscountNewsCellFrame.h"
#import "ZXDiscountNews.h"

#import "ZXHttpTool.h"
#import "Config.h"

@interface ZXDiscountViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *discountNewsCellFrame;

@property (nonatomic, weak) UITableView *tableView;

@property (weak, nonatomic)UIView *cityView;

@property (strong, nonatomic)UIButton *cityBtn;

@end

@implementation ZXDiscountViewController

#pragma mark - 初始化

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"车有惠";
    }
    return self;
}

/**
 *  下拉加载最新数据
 */
- (void)initTableHeader {
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(initNetworking)];
    
    [header setImages:@[[UIImage imageNamed:@"load_1"],[UIImage imageNamed:@"load_2"],[UIImage imageNamed:@"load_3"],[UIImage imageNamed:@"load_4"]] forState:MJRefreshStateRefreshing];
    
    self.tableView.header = header;
    // 设置header
    [self.tableView.header beginRefreshing];
}

/**
 *  网络初始化
 */
- (void)initNetworking {
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[CITYID] = @475;
    
    [ZXHttpTool get:kGetSalesByCityId params:paras success:^(id json) {
        //        ZXLog(@"salesList--------/n%@", json);
        
        // 通过数组字典返回模型，该数组中装的都是ZXDiscountNews模型
        NSArray *dicountNewsArr = [ZXDiscountNews objectArrayWithKeyValuesArray:json];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (ZXDiscountNews *news in dicountNewsArr) {
            ZXDiscountNewsCellFrame *f = [[ZXDiscountNewsCellFrame alloc] init];
            f.discountNews = news;
            [newsArray addObject:f];
        }
        
        self.discountNewsCellFrame = newsArray;
        // 刷新tableView
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"error------%@", error);
        [self.tableView.header endRefreshing];
    }];
}

/**
 *  初始化tableView
 */
- (void)initTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 35.0, ScreenWidth, ScreenHeight - 35) style:UITableViewStylePlain];
    // 取消cell的分割线
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 为tableView增加额外的滚动区域
    [tableView setContentInset:UIEdgeInsetsMake(0.0, 0.0, TableViewContentInset, 0.0)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = ZXColor(235, 235, 235);
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
#pragma mark - getter
- (UIView *)cityView{
    if (!_cityView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, 35.0)];
        
        view.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:view];
        
        UILabel *label = [[UILabel alloc]init];
        
        label.font = [UIFont systemFontOfSize:13];
        
        label.text = @"当前城市:";
        
        CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        label.frame = CGRectMake(8.0, (35.0 - size.height) * 0.5 + 3, size.width, size.height);
        
        [view addSubview:label];
        
        self.cityBtn.frame = CGRectMake(CGRectGetMaxX(label.frame) - 15, (35.0 - size.height) * 0.5 + 3, size.width, size.height);
        
        [view addSubview:self.cityBtn];
        
        _cityView = view;
    }
    return _cityView;
}

- (UIButton *)cityBtn{
    if (!_cityBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:@"北京" forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [btn setImage:[UIImage imageNamed:@"shezhi_jiantou"] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        _cityBtn = btn;
    }
    return _cityBtn;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self initTableView];
    // 下拉加载最新数据
    [self initTableHeader];
    
    [self cityView];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.discountNewsCellFrame count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZXDiscountNewsCell *cell = [ZXDiscountNewsCell cellWithTableView:tableView];
    cell.discountNewsCellFrame = self.discountNewsCellFrame[indexPath.row];
    return cell;
    
}

#pragma mark - Table view delegate methods
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZXDiscountNewsCellFrame *dnf = self.discountNewsCellFrame[indexPath.row];
    return dnf.cellHeight;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*ZXDiscountNewsCellFrame *dnf = self.discountNewsCellFrame[indexPath.row];
    ZXDiscountNews *news = dnf.discountNews;
    
    ZXDetailViewController *vc = [[UIStoryboard storyboardWithName:@"ZXDetailStoryboard" bundle:nil] instantiateInitialViewController];
    
    vc.status = ZXDetailViewControllerLink;
    
    vc.link = news.subSerie;
    
    //获得navigation控制器
    UINavigationController *navigationControll = [self.view.superview valueForKey:@"navigationController"];
    
    [navigationControll pushViewController:vc animated:YES];*/
}

@end
