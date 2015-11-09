//
//  ZXBrandFindCarViewController.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015 Zency. All rights reserved.
//

#import "ZXBrandFindCarViewController.h"

#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "ZXHttpTool.h"

#import "ZXFindCarSpecialSales.h"
#import "ZXFindCarHeaderView.h"
#import "ZXBrandFindCarViewCell.h"
#import "ZXFindCarSectionView.h"
#import "ZXBrandCar.h"
#import "ZXBrand.h"

#import "Config.h"

@interface ZXBrandFindCarViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) ZXFindCarHeaderView *headerView;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *series;
@property (nonatomic, strong) NSArray *specialSales;

@end

@implementation ZXBrandFindCarViewController

static NSString * const CellIdentifier = @"BrandCar";

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"品牌选车";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self requestSpecialSalesDate];
    [self requestBrandCarDate];
}

- (void)requestSpecialSalesDate {
    [ZXHttpTool get:kGetSpecialSaleURL params:nil success:^(id json) {
//        ZXLog(@"%@", json);
        
        // 获取销售新闻
        ZXFindCarSpecialSales *specialSales = [ZXFindCarSpecialSales objectWithKeyValues:json];
        // 设置tableView header
        [self setupTableHeaderViewWithFocusPosts:specialSales];
        
    } failure:^(NSError *error) {
        NSLog(@"failed-------%@", error);
    }];
}

- (void)requestBrandCarDate {
    [ZXHttpTool get:kGetAllXCarBrandsURL params:nil success:^(id json) {
//        ZXLog(@"%@", json);
        
        // 获取各车品牌
        self.series = [ZXBrandCar objectArrayWithKeyValuesArray:json[@"letters"]];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"failed-------%@", error);
    }];
}

#pragma mark - Table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.series count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZXBrandCar *car = self.series[section];
    return car.brandNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXBrandFindCarViewCell *cell = [ZXBrandFindCarViewCell cellWithTableView:tableView];
    // 3.设置cell的属性
    ZXBrandCar *car = self.series[indexPath.section];
    ZXBrand *brand = car.brands[indexPath.row];
    
    [cell.brandLabel setText:brand.name];
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:brand.icon] placeholderImage:[UIImage imageNamed:@"zhanwei2_1"]];
    return cell;
}

#pragma mark - Table view delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZXBrandCar *car = self.series[section];
    ZXFindCarSectionView *headerView = [[ZXFindCarSectionView alloc] initWithSectionTitles:car.letter];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 23.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

/**
 * 设置索引
 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexTitles = [NSMutableArray array];
    for (ZXBrandCar *car in self.series) {
        [indexTitles addObject:car.letter];
    }
    return indexTitles;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - private method
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    // 设置tableView的额外滚动区域
    [tableView setContentInset:UIEdgeInsetsMake(0.0, 0.0, TableViewContentInset, 0.0)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionIndexColor = ZXColor(136, 140, 150);
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    tableView.sectionIndexMinimumDisplayRowCount = 30;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)setupTableHeaderViewWithFocusPosts:(ZXFindCarSpecialSales *)specialSales {
    ZXFindCarHeaderView *headerView = [[ZXFindCarHeaderView alloc] initHeaderViewWithSeriesImage:specialSales.seriesImage carName:specialSales.carName cheapRange:specialSales.cheapRange dealerName:specialSales.dealerName];
    [headerView setFrame:CGRectMake(0.0, 0.0, ScreenWidth, headerView.cellHeight + 15)];
    self.tableView.tableHeaderView = headerView;
}

@end
