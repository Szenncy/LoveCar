//
//  ZXForumDetailViewController.m
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXForumDetailViewController.h"
#import "UIViewController+ZXTabBar.h"
#import "ZXForumDetailTopView.h"
#import "ZXHttpTool.h"
#import "Config.h"
#import "ZXModerator.h"
#import "ZXPostModel.h"
#import "ZXHotPostTableViewCell.h"
#import "ZXtoolBar.h"
#import "ZXDetailViewController.h"
#import "MJRefresh.h"
#import "ZXRootNavViewController.h"
#import "UIView+Toast.h"

@interface ZXForumDetailViewController ()<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    //帖子数
    NSInteger _postNum;
    //主题数
    NSInteger _themeNum;
    //标识
    BOOL _show;
    //数量
    NSInteger _count;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic)ZXForumDetailTopView *tableViewHeader;

/**
 *  存储版主
 */
@property (strong, nonatomic)NSArray *moderators;

/**
 *  存储分论坛
 */
@property (strong, nonatomic)NSArray *subForum;

/**
 *  请求参数
 */
@property (strong, nonatomic)NSMutableDictionary *param;

/**
 *  存储帖子信息
 */
@property (strong, nonatomic)NSMutableArray *postList;

/**
 *  底部工具栏
 */
@property (weak, nonatomic)ZXtoolBar *toolBar;

@end

@implementation ZXForumDetailViewController

#pragma mark - 初始化
/**
 *  初始化导航栏
 */
- (void)initNav{
    /**
     *  左边的按钮
     */
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    leftbtn.frame = CGRectMake(0, 0, 52, 30);
    
    [leftbtn setImage:[UIImage imageNamed:@"nav_fanhui"] forState:UIControlStateNormal];
    
    [leftbtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [leftbtn setTitleColor:[UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0] forState:UIControlStateNormal];
    
    [leftbtn addTarget:self action:@selector(backTouch) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    
    /**
     *  右侧的按钮
     */
    
    UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    sortBtn.frame = CGRectMake(0, 0, 35, 30);
    
    [sortBtn setTitle:@"排序" forState:UIControlStateNormal];
    
    [sortBtn setTitleColor:[UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0] forState:UIControlStateNormal];
    
    UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    typeBtn.frame = CGRectMake(0, 0, 35, 30);
    
    [typeBtn setTitle:@"分类" forState:UIControlStateNormal];
    
    [typeBtn setTitleColor:[UIColor colorWithRed:(float)28/255 green:(float)158/255 blue:(float)222/255 alpha:1.0] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:sortBtn],[[UIBarButtonItem alloc]initWithCustomView:typeBtn]];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)initReFreshHeader{
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self initNetWorking];
    }];
    
    [header setImages:@[[UIImage imageNamed:@"load_1"],[UIImage imageNamed:@"load_2"],[UIImage imageNamed:@"load_3"],[UIImage imageNamed:@"load_4"]] forState:MJRefreshStateRefreshing];
    
    self.tableView.header = header;
    
    [header beginRefreshing];
}

/**
 *  初始化TableView
 */
- (void)initTableView{
    
    //表头视图
    [self.tableViewHeader awakeFromNib];
    
    self.tableViewHeader.moderators = self.moderators;
    
    self.tableViewHeader.subForum = self.subForum;
    
    self.tableViewHeader.themeNum = _themeNum;
    
    self.tableViewHeader.postNum = _postNum;
    
    if (!self.forumName) {
        self.forumName = self.forumModel.forumName?self.forumModel.forumName:self.forumModel.name;
    }
    
    self.tableViewHeader.title = self.forumName;
    
    //表cell注册
    [self.tableView registerNib:[UINib nibWithNibName:@"ZXHotPostTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

- (void)initNetWorking{
    /**
     *  网络请求tableHeader
     */
    
    if (!self.ID) {
        self.ID = self.forumModel.forumId?[self.forumModel.forumId integerValue]:[self.forumModel.ID integerValue];
    }
    
    [ZXHttpTool get:kGetForumInfoURL params:@{@"forumId":@(self.ID),@"ver":@"6.2"} success:^(id json) {
        [self loadModerators:json[@"moderators"]];
        [self loadSubForum:json[@"subForum"]];
        _postNum = [json[@"postNum"] integerValue];
        _themeNum = [json[@"themeNum"] integerValue];
        [self initTableView];
        
        //网络请求表信息
        //NSLog(@"%@",self.param);
        
        [ZXHttpTool get:kGetPostListNew params:self.param success:^(id json) {
            [self loadPostList:json[@"postList"]];
            
            if ([self.tableView.header isRefreshing]) {
                [self.tableView.header endRefreshing];
            }
            
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            NSLog(@"tableView 请求信息错误: %@",error);
            //NSLog(@"%@",error);
            
            //UINavigationController *navigationControll = [self.view.superview valueForKey:@"navigationController"];
            
            [self.navigationController.view makeToast:@"网络错误" duration:1.0 position:CSToastPositionCenter];
            
            [self.tableView.header endRefreshing];
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"tableHeader 请求错误: %@",error);
        
        //NSLog(@"%@",error);
        
        //UINavigationController *navigationControll = [self.view.superview valueForKey:@"navigationController"];
         [self.navigationController.view makeToast:@"网络错误" duration:1.0 position:CSToastPositionCenter];
        //[self.navigationControll.view makeToast:@"网络错误" duration:1.0 position:CSToastPositionCenter];
        
        [self.tableView.header endRefreshing];
    }];
    
}

- (void)initReFreshFooter{
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _count += 10;
        
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        paras[LIMIT] = @10;
        paras[OFFSET] = @(_count);
        paras[TYPE] = @0;
        paras[VER] = @"6.2";
        paras[FORUMID] = @(self.ID);
        paras[SELECTID] = @0;
        paras[SORTTYPE] = @1;
        paras[UID] = @"";
        
        [ZXHttpTool get:kGetPostListNew params:paras success:^(id json) {
           // NSLog(@"%@",json);
            [self loadPostList:json[@"postList"]];
            //[self setAdsWithJson:json];
            
            //[self setNewsArrWithJson:json[@"newsList"]];
            
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

- (void)initToolBar{
    [self.toolBar awakeFromNib];
    
    self.toolBar.isPost = YES;
}

#pragma mark - getter

- (ZXForumDetailTopView *)tableViewHeader{
    if (!_tableViewHeader) {
        ZXForumDetailTopView *header = [[ZXForumDetailTopView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        
        self.tableView.tableHeaderView = header;
        
        _tableViewHeader = header;
    }
    return _tableViewHeader;
}

- (NSMutableDictionary *)param{
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
        
        if (!self.ID) {
            self.ID = self.forumModel.forumId?[self.forumModel.forumId integerValue]:[self.forumModel.ID integerValue];
        }
        
        _param[FORUMID] = @(self.ID);
        _param[LIMIT] = @(10);
        _param[OFFSET] = @0;
        _param[SELECTID] = @0;
        _param[SORTTYPE] = @1;
        _param[UID] = @"";
        _param[TYPE] = @0;
        _param[VER] = @"6.2";
    }
    return _param;
}

- (NSMutableArray *)postList{
    if (!_postList) {
        _postList = [NSMutableArray array];
    }
    return _postList;
}

- (ZXtoolBar *)toolBar{
    if (!_toolBar) {
        ZXtoolBar *toolBar = [[ZXtoolBar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49)];
        
        [self.view addSubview:toolBar];
        
        _toolBar = toolBar;
    }
    return _toolBar;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    
    [self initReFreshHeader];
    //[self initNetWorking];
    
    [self initNav];
    
    [self initToolBar];
    
    [self initReFreshFooter];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //ZXRootNavViewController *nav = (ZXRootNavViewController *)self.navigationController;
    
    //nav.imageView.image = [nav.images lastObject];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    ZXRootNavViewController *nav = (ZXRootNavViewController *)self.navigationController;
    
    if (_show) {
        [nav.imageView removeFromSuperview];
        [nav.images removeLastObject];
    }
}


#pragma mark - 事件响应

- (void)backTouch{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 内部逻辑运算
/**
 *  装载版主信息
 */
- (void)loadModerators:(id)json{
    NSMutableArray *objs = [NSMutableArray array];
    
    for (NSDictionary *dict in json) {
        ZXModerator *obj = [[ZXModerator alloc]initWithDictionary:dict error:nil];
        
        [objs addObject:obj];
    }
    
    self.moderators = objs;
}
/**
 *  装载分论坛信息
 */
- (void)loadSubForum:(id)json{
    NSMutableArray *objs = [NSMutableArray array];
    
    for (NSDictionary *dict in json) {
        ZXForumModel *obj = [[ZXForumModel alloc]initWithDictionary:dict error:nil];
        
        [objs addObject:obj];
    }
    
    self.subForum = objs;
}

- (void)loadPostList:(id)json{
    for (NSDictionary *dict in json) {
        ZXPostModel *obj = [[ZXPostModel alloc]initWithDictionary:dict error:nil];
        
        [self.postList addObject:obj];
    }
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.postList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXHotPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.item = self.postList[indexPath.item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXDetailViewController *vc = [[UIStoryboard storyboardWithName:@"ZXDetailStoryboard" bundle:nil] instantiateInitialViewController];
    
    vc.status = ZXDetailViewControllerPost;
    
    vc.postModel = self.postList[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    _show = YES;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

@end
