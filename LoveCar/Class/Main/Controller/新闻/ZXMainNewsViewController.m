//
//  ZXMainNewsViewController.m
//  LoveCar
//
//  Created by zency on 15/10/12.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXMainNewsViewController.h"
#import "Config.h"
#import "ZXHttpTool.h"
#import "ZXFocusImg.h"
#import "ZXLoveCarAds.h"
#import "ZXNewsModel.h"
#import "ZXUpdateTableViewCell.h"
#import "ZXDetailViewController.h"
#import "MJRefresh.h"
#import "UIView+Toast.h"

#define kTableViewCellHeight 78

@interface ZXMainNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _count;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *paras;

@property (strong, nonatomic)NSMutableArray *focusImgs;

@property (strong, nonatomic)NSMutableArray *newsArr;

@property (strong, nonatomic)ZXLoveCarAds *ads;


@end

@implementation ZXMainNewsViewController

#pragma mark - 初始化

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //self.title = @"新闻";
    }
    return self;
}

- (void)initNetWorking{
    [ZXHttpTool get:self.model.url params:self.paras success:^(id json) {
        
        [self.focusImgs removeAllObjects];
        
        [self.newsArr removeAllObjects];
        
        [self setAdsWithJson:json];
        
        [self setNewsArrWithJson:json[@"newsList"]];
        
        [self.tableView reloadData];
        
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
        UINavigationController *navigationControll = [self.view.superview valueForKey:@"navigationController"];
        
        [navigationControll.view makeToast:@"网络错误" duration:1.0 position:CSToastPositionCenter];
        
        [self.tableView.header endRefreshing];
    }];
}

- (void)initReFreshHeader{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self initNetWorking];
    }];
    
    [header setImages:@[[UIImage imageNamed:@"load_1"],[UIImage imageNamed:@"load_2"],[UIImage imageNamed:@"load_3"],[UIImage imageNamed:@"load_4"]] forState:MJRefreshStateRefreshing];
    
    self.tableView.header = header;
    
    [header beginRefreshing];
    
}

- (void)initReFreshFooter{
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _count += 10;
        
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        paras[LIMIT] = @10;
        paras[OFFSET] = @(_count);
        paras[TYPE] = self.model.type;
        paras[VER] = @"6.2";
        
        [ZXHttpTool get:self.model.url params:paras success:^(id json) {
            
            [self setAdsWithJson:json];
            
            [self setNewsArrWithJson:json[@"newsList"]];
            
            [self.tableView reloadData];
            
            if ([self.tableView.header isRefreshing]) {
                [self.tableView.header endRefreshing];
            }
            
            if ([self.tableView.footer isRefreshing]) {
                [self.tableView.footer endRefreshing];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }];
    
    self.tableView.footer = footer;
    
}

- (void)initTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"ZXUpdateTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - getter

- (NSMutableDictionary *)paras{
    if (!_paras) {
        _paras = [NSMutableDictionary dictionary];
        _paras[LIMIT] = @10;
        _paras[OFFSET] = @0;
        _paras[TYPE] = self.model.type;
        _paras[VER] = @"6.2";
        
        _count = 10;
    }
    
    return _paras;
}

- (NSMutableArray *)focusImgs{
    if (!_focusImgs) {
        _focusImgs = [NSMutableArray array];
    }
    return _focusImgs;
}

- (ZXLoveCarAds *)ads{
    if (!_ads) {
        ZXLoveCarAds *ads = [[ZXLoveCarAds alloc]init];
        
        //self.tableView.tableHeaderView = ads;
        
        _ads = ads;
    }
    return _ads;
}

- (NSMutableArray *)newsArr{
    if (!_newsArr) {
        _newsArr = [NSMutableArray array];
    }
    return _newsArr;
}
#pragma mark - setter

- (void)setModel:(ZXSlidingModel *)model{
    _model = model;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTableView];
    
    //[self initNetWorking];
    
    [self initReFreshFooter];
    
    [self initReFreshHeader];
    
    self.title = self.model.title;
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXUpdateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.item = self.newsArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXDetailViewController *vc = [[UIStoryboard storyboardWithName:@"ZXDetailStoryboard" bundle:nil] instantiateInitialViewController];
    
    vc.status = ZXDetailViewControllerNews;
    
    vc.newsModel = self.newsArr[indexPath.row];
    
    UINavigationController *navigationControll = [self.view.superview valueForKey:@"navigationController"];
    
    [navigationControll pushViewController:vc animated:YES];
}


#pragma mark - json赋值

- (void)setNewsArrWithJson:(id)json{
    for (NSDictionary *dict in json) {
        ZXNewsModel *model = [[ZXNewsModel alloc]initWithDictionary:dict error:nil];
        
        [self.newsArr addObject:model];
    }
    
}

- (void)setAdsWithJson:(id)json{
    
    [self setFocusImgsWithJson:json[@"focusList"][@"focusImgs"]];
    
}

- (void)setFocusImgsWithJson:(id)json{
    for (NSDictionary *dict in json)
    {
        ZXFocusImg *img = [[ZXFocusImg alloc]initWithDictionary:dict error:nil];
        
        [self.focusImgs addObject:img];
    }
    
}

- (CGSize)sizeWithOriginWidth:(CGFloat)width andOriginHeight:(CGFloat)height{
    
    return CGSizeMake(self.tableView.frame.size.width, height * self.tableView.frame.size.width / width);
}

@end