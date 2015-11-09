//
//  ZXEventViewController.m
//  LoveCar
//
//  Created by zency on 10/19/15.
//  Copyright (c) 2015 Zency. All rights reserved.
//

#import "ZXEventViewController.h"
#import "ZXDetailViewController.h"

#import "MJExtension.h"
#import "MJRefresh.h"

#import "ZXEventNews.h"
#import "ZXEventNewsCell.h"
#import "ZXEventNewsCellFrame.h"
#import "ZXHttpTool.h"

#import "Config.h"

@interface ZXEventViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *eventNewsFrame;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ZXEventViewController

#pragma mark - 初始化
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"活动";
    }
    return self;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self initTableView];
    // 下拉加载最新数据
    [self pullDownToRefreshEventNews];
}

#pragma mark - 刷新数据
/**
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshEventNews {
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestEventNews)];
    
    [header setImages:@[[UIImage imageNamed:@"load_1"],[UIImage imageNamed:@"load_2"],[UIImage imageNamed:@"load_3"],[UIImage imageNamed:@"load_4"]] forState:MJRefreshStateRefreshing];
    
    self.tableView.header = header;
    
    // 设置header
    [self.tableView.header beginRefreshing];
}

- (void)requestEventNews {
    [ZXHttpTool get:kGetSalesInfoURL params:nil success:^(id json) {
//        ZXLog(@"carnews------/n%@", json);
        
        // 通过数组字典返回模型，该数组中装的都是ZXEventNews模型
        NSArray *eventNewsArr = [ZXEventNews objectArrayWithKeyValuesArray:json];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (ZXEventNews *news in eventNewsArr) {
            ZXEventNewsCellFrame *f = [[ZXEventNewsCellFrame alloc] init];
            f.eventNews = news;
            [newsArray addObject:f];
        }
        
        self.eventNewsFrame = newsArray;
        // 刷新tableView
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"error-------/n%@", error);
        [self.tableView.header endRefreshing];
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.eventNewsFrame count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 构造ZXEventNewsCell
    ZXEventNewsCell *cell = [ZXEventNewsCell cellWithTableView:tableView];
    // 设置数据
    cell.eventNewsCellFrame = self.eventNewsFrame[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate methods
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXEventNewsCellFrame *enf = self.eventNewsFrame[indexPath.row];
    return enf.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXEventNewsCellFrame *enf = self.eventNewsFrame[indexPath.row];
    ZXEventNews *news = enf.eventNews;
    
    ZXDetailViewController *vc = [[UIStoryboard storyboardWithName:@"ZXDetailStoryboard" bundle:nil] instantiateInitialViewController];
    
    vc.status = ZXDetailViewControllerEventLink;
    
    vc.link = news.eventLink;
    
    //获得navigation控制器
    UINavigationController *navigationControll = [self.view.superview valueForKey:@"navigationController"];
    
    [navigationControll pushViewController:vc animated:YES];
}

- (void)initTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, ScreenHeight ) style:UITableViewStylePlain];
    // 取消cell的分割线
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 为tableView增加额外的滚动区域
    [tableView setContentInset:UIEdgeInsetsMake(0.0, 0.0, TableViewContentInset, 0.0)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
