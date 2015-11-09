//
//  ZXDepreciateViewController.m
//  LoveCar
//
//  Created by zency on 10/19/15.
//  Copyright © 2015 Zency. All rights reserved.
//

#import "ZXDepreciateViewController.h"
//#import "ZXDepreciateTopView.h"
#import "DOPDropDownMenu.h"
#import "ZXDetailViewController.h"
//#import "ZXWebViewController.h"

#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIView+Toast.h"

#import "ZXDepreciateNews.h"
#import "ZXDepreciateNewsCell.h"
#import "ZXDepreciateNewsCellFrame.h"
#import "ZXHttpTool.h"

#import "Config.h"
#import "ZXLetterItem.h"
#import "ZXForumTopViewModel.h"


@interface ZXDepreciateViewController () <UITableViewDataSource, UITableViewDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>
{
    NSInteger _cityCount;
    NSInteger _sumNum;
}
@property (nonatomic, strong) NSMutableDictionary *paras;

@property (nonatomic, strong) NSMutableArray *depreciateNewsFrame;

@property (strong, nonatomic) NSMutableArray *data;

@property (strong, nonatomic) NSMutableArray *citys;

@property (nonatomic, weak) UITableView *tableView;

@property (strong, nonatomic)NSArray *sortArr;

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int count;

@end

@implementation ZXDepreciateViewController

#pragma mark - 初始化
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"降价";
    }
    return self;
}

/**
 *  下拉加载最新数据
 */
- (void)initTableHeader {
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(initNetWorking)];
    
    [header setImages:@[[UIImage imageNamed:@"load_1"],[UIImage imageNamed:@"load_2"],[UIImage imageNamed:@"load_3"],[UIImage imageNamed:@"load_4"]] forState:MJRefreshStateRefreshing];
    
    self.tableView.header = header;
    // 设置header
    [self.tableView.header beginRefreshing];
}

- (void)initNetWorking {
    [ZXHttpTool get:kGetDiscountInfoURL params:self.paras success:^(id json) {
        //        ZXLog(@"success-------%@", json);
        
        // 通过数组字典返回模型，该数组中装的都是ZXDepreciateNews模型
        NSArray *depreciateArr = [ZXDepreciateNews objectArrayWithKeyValuesArray:json[@"discountList"]];
        
        // 创建frame模型对象
        NSMutableArray *depreciateArray = [NSMutableArray array];
        for (ZXDepreciateNews *news in depreciateArr) {
            ZXDepreciateNewsCellFrame *f = [[ZXDepreciateNewsCellFrame alloc] init];
            f.depreciateNews = news;
            [depreciateArray addObject:f];
        }
        
        self.depreciateNewsFrame = depreciateArray;
        // 刷新tableView
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"error-------%@", error);
        [self.tableView.header endRefreshing];
    }];
    
}


- (void)initBaseView {
    
    //self.view.backgroundColor = ZXColor(235, 235, 235);
    
    //ZXDepreciateTopView *topView = [[ZXDepreciateTopView alloc] init];
    //[topView setFrame:CGRectMake(0.0, 0.0, ScreenWidth, 35.0)];
    
    DOPDropDownMenu *topView = [[DOPDropDownMenu alloc]initWithOrigin:CGPointMake(0, 0) andHeight:35.0];
    
    topView.delegate = self;
    topView.dataSource = self;
    
    [topView selectDefalutIndexPath];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 35.0, ScreenWidth, ScreenHeight - 49 - 64 - 25.0) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setScrollIndicatorInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    self.tableView = tableView;
    tableView.backgroundColor = ZXColor(235, 235, 235);
    [self.view addSubview:tableView];
    [self.view addSubview:topView];
}

#pragma mark - lazy loading
- (NSMutableDictionary *)paras {
    if (!_paras) {
        _paras = [NSMutableDictionary dictionary];
        _paras[BRANDID] = @0;
        _paras[CITYID] = @348;
        _paras[PROVINCEID] = @30;
        _paras[SERIESID] = @0;
        _paras[SORTTYPE] = @1;
    }
    return _paras;
}

- (NSMutableArray *)citys{
    if (!_citys) {
        _citys = [NSMutableArray array];
        
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.json" ofType:nil]];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *obj in dict[@"area"]) {
            for (NSDictionary *dic in obj[@"provinces"]) {
                ZXProvince *p = [[ZXProvince alloc]initWithDictionary:dic error:nil];
                
                [_citys addObject:p];
            }
        }
        
    }
    return _citys;;
}

- (NSArray *)sortArr{
    if (!_sortArr) {
        _sortArr = @[@"降幅最大",@"降幅最低",@"价格最高"];
    }
    return _sortArr;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBaseView];
    // 下拉加载最新数据
    [self initTableHeader];
    
}

#pragma mark - Table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.depreciateNewsFrame count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXDepreciateNewsCell *cell = [ZXDepreciateNewsCell cellWithTableView:tableView];
    cell.depreciateNewsCellFrame = self.depreciateNewsFrame[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXDepreciateNewsCellFrame *dnf = self.depreciateNewsFrame[indexPath.row];
    return dnf.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXDepreciateNewsCellFrame *dnf = self.depreciateNewsFrame[indexPath.row];
    ZXDepreciateNews *news = dnf.depreciateNews;
    
    ZXDetailViewController *vc = [[UIStoryboard storyboardWithName:@"ZXDetailStoryboard" bundle:nil] instantiateInitialViewController];
    
    vc.status = ZXDetailViewControllerLink;
    
    vc.link = news.link;
    
    //获得navigation控制器
    UINavigationController *navigationControll = [self.view.superview valueForKey:@"navigationController"];
    
    [navigationControll pushViewController:vc animated:YES];
}

#pragma mark - DOPDropDownMenu代理

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

/**
 *  返回 menu 第column列有多少行
 */
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column{
    if (column == 0) {
        
        return self.citys.count;//self.classifys.count;
        
    }else if (column == 1){
        return 1;//self.areas.count;
    }else {
        return self.sortArr.count;//self.sorts.count;
    }
}

/**
 *  返回 menu 第column列 每行title
 */
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath{
    if (indexPath.column == 0) {
        
        ZXProvince *p = self.citys[indexPath.row];
        
        return p.name;
        
    } else if (indexPath.column == 1){
        return @"全部品牌";
    } else {
        return self.sortArr[indexPath.row];
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        
        ZXProvince *item = self.citys[row];
        
        return item.cities.count;
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        
        ZXProvince *p = self.citys[indexPath.row];
        
        ZXCity *c = p.cities[indexPath.item];
        
        return c.cityName;//self.cates[indexPath.item];
        
    }
    return nil;
}
/*
 - (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath
 {
 if (indexPath.column == 0 || indexPath.column == 1) {
 return @"--";
 }
 return nil;
 }
 
 - (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
 {
 if (indexPath.column == 0 && indexPath.item >= 0) {
 return @"--";
 }
 return nil;
 }*/
@end
