//
//  ZXForumTopViewController.m
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXForumTopViewController.h"
#import "ZXForumTopView.h"
#import "ZXNavForumViewController.h"
#import "ZXHttpTool.h"
#import "Config.h"
#import "ZXForumTopViewModel.h"
#import "ZXForumTopTableViewCell.h"
#import "ZXCategoryModel.h"
#import "UIView+Toast.h"

typedef enum : NSUInteger {
    ZXForumTopViewControllerStatusClub,
    ZXForumTopViewControllerStatusCity,
    ZXForumTopViewControllerStatusLife,
    ZXForumTopViewControllerStatusNext
} ZXForumTopViewControllerStatus;

@interface ZXForumTopViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _sumNum;
    ZXForumTopViewControllerStatus _status;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic)ZXForumTopView *topView;

@property (strong, nonatomic)NSMutableArray *citydata;

@property (strong, nonatomic)NSMutableArray *lifedata;

@property (strong, nonatomic)NSMutableArray *data;

@property (strong, nonatomic)NSMutableArray *keys;

@end

@implementation ZXForumTopViewController

#pragma mark - 初始化

- (void)initTopView{
    [self.topView awakeFromNib];
    
    self.topView.title = self.navigationController.title;
    
    if (self.navigationController.viewControllers.count <= 1) {
        self.topView.isBackHide = YES;
    }else{
        self.topView.isBackHide = NO;
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc] init]];
    
    if ([self.navigationController.title isEqualToString:@"爱车俱乐部"]) {
        _status = ZXForumTopViewControllerStatusClub;
        if (self.brandModel) {
            _status = ZXForumTopViewControllerStatusNext;
            self.topView.title = self.brandModel.name;
        }
    }else if([self.navigationController.title isEqualToString:@"地方分会"]){
        _status = ZXForumTopViewControllerStatusCity;
    }else if([self.navigationController.title isEqualToString:@"人·车·生活"]){
        _status = ZXForumTopViewControllerStatusLife;
    }
}

- (void)initNetWorking{
    [ZXHttpTool get:kGetForumCarURL params:nil success:^(id json) {
        _sumNum = [json[@"letterNum"] integerValue];
        
        for (NSDictionary *dict in json[@"letters"]) {
            ZXForumTopViewModel *model = [[ZXForumTopViewModel alloc]initWithDictionary:dict error:nil];
            
            [self.data addObject:model];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
        [self.navigationController.view makeToast:@"网络错误" duration:1.0 position:CSToastPositionCenter];
        
    }];
}

- (void)initLife{
    [ZXHttpTool get:kGetForumLifeURL params:nil success:^(id json) {
        for (NSDictionary *dict in json[@"categories"]) {
            ZXCategoryModel *model = [[ZXCategoryModel alloc]initWithDictionary:dict error:nil];
            
            [self.lifedata addObject:model];
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"失败");
        
         [self.navigationController.view makeToast:@"网络错误" duration:1.0 position:CSToastPositionCenter];
    }];
}

- (void)initCity{
    [self citydata];
    [self.tableView reloadData];
}

- (void)initTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"ZXForumTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    
}

- (void)initItem{
    
}

#pragma mark - getter

- (ZXForumTopView *)topView{
    if (!_topView) {
        ZXForumTopView *top = [[ZXForumTopView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        
        [top setCloseCallback:^{
            ZXNavForumViewController *nav = (ZXNavForumViewController *)self.navigationController;
            
            [nav close:YES];
        }];
        
        [top setBackCallback:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        self.navigationItem.titleView = top;
        
        _topView = top;
    }
    return _topView;
}

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (NSMutableArray *)keys{
    if (!_keys) {
        _keys = [NSMutableArray array];
    }
    return _keys;
}

- (NSMutableArray *)lifedata{
    if (!_lifedata) {
        _lifedata = [NSMutableArray array];
    }
    return _lifedata;
}

- (NSMutableArray *)citydata{
    if (!_citydata) {
        _citydata = [NSMutableArray array];
        
        NSString *jsonString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
        
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray *obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *dicy in obj) {
            ZXCategoryModel *model = [[ZXCategoryModel alloc]initWithDictionary:dicy error:nil];
            
            [_citydata addObject:model];
        }
        
    }
    return _citydata;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopView];
    
    switch (_status) {
        case ZXForumTopViewControllerStatusClub:
            [self initNetWorking];
            break;
        case ZXForumTopViewControllerStatusCity:
            [self initCity];
            break;
        case ZXForumTopViewControllerStatusLife:
            [self initLife];
            break;
        default:
            [self initItem];
            break;
    }
    
    [self initTableView];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    switch (_status) {
        case ZXForumTopViewControllerStatusClub:
            return self.data.count;
            break;
        case ZXForumTopViewControllerStatusCity:
            return self.citydata.count;
            break;
        case ZXForumTopViewControllerStatusLife:
            return self.lifedata.count;
            break;
        default:
            return 1;
            break;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (_status) {
        case ZXForumTopViewControllerStatusClub:
        {
            ZXForumTopViewModel *model = self.data[section];
            
            return model.brands.count;
        }
            break;
        case ZXForumTopViewControllerStatusCity:
        {
            ZXCategoryModel *model = self.citydata[section];
            
            return model.forums.count;
        }
            break;
        case ZXForumTopViewControllerStatusLife:
        {
            ZXCategoryModel *model = self.lifedata[section];
            
            return model.forums.count;
        }
            break;
        default:
            return self.brandModel.forums.count;
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXForumTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    switch (_status) {
        case ZXForumTopViewControllerStatusClub:
        {
            ZXForumTopViewModel *model = self.data[indexPath.section];
            
            ZXBrandsModel *brand = model.brands[indexPath.item];
            
            cell.model = brand;
        }
            break;
        case ZXForumTopViewControllerStatusCity:
        {
            ZXCategoryModel *model = self.citydata[indexPath.section];
            
            ZXForumModel *item = model.forums[indexPath.row];
            
            cell.item = item;
        }
            break;
        case ZXForumTopViewControllerStatusLife:
        {
            ZXCategoryModel *model = self.lifedata[indexPath.section];
            
            ZXForumModel *item = model.forums[indexPath.row];
            
            cell.item = item;
        }
            break;
        default:
        {
            cell.forumModel = self.brandModel.forums[indexPath.row];
        }
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (_status) {
        case ZXForumTopViewControllerStatusClub:
        {
            ZXForumTopViewModel *model = self.data[section];
            
            [self.keys addObject:model.letter];
            
            return model.letter;
        }
            break;
        case ZXForumTopViewControllerStatusCity:
        {
            ZXCategoryModel *model = self.citydata[section];
            
            [self.keys addObject:model.categoryName];
            
            return model.categoryName;
        }
            break;
        case ZXForumTopViewControllerStatusLife:
        {
            ZXCategoryModel *model = self.lifedata[section];
            
            [self.keys addObject:model.categoryName];
            
            return model.categoryName;
        }
            break;
        default:
            break;
    }
    
    return nil;
    
}
/**
 *  设置tableView点击事件
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_status == ZXForumTopViewControllerStatusClub) {
        ZXForumTopViewController *vc = [[UIStoryboard storyboardWithName:@"ZXForumTopStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ZXForumTopViewController"];
        
        ZXForumTopViewModel *model = self.data[indexPath.section];
        
        ZXBrandsModel *item = model.brands[indexPath.item];
        
        vc.brandModel = item;
        
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ZXNavForumViewController *nav = (ZXNavForumViewController *)self.navigationController;
        
        id vc = [[UIStoryboard storyboardWithName:@"ZXForumDetailStoryboard" bundle:nil] instantiateInitialViewController];
        
        [nav close:NO];
        [nav.view removeFromSuperview];
        
        switch (_status) {
            case ZXForumTopViewControllerStatusNext:
            {
                [vc setValue:self.brandModel.forums[indexPath.item] forKey:@"forumModel"];
            }
                break;
            case ZXForumTopViewControllerStatusCity:
            {
                ZXCategoryModel *model = self.citydata[indexPath.section];
                
                [vc setValue:model.forums[indexPath.item] forKey:@"forumModel"];
            }
                break;
            case ZXForumTopViewControllerStatusLife:{
                ZXCategoryModel *model = self.lifedata[indexPath.section];
                
                [vc setValue:model.forums[indexPath.item] forKey:@"forumModel"];
            }
                break;
            default:
                break;
        }
        
        [nav.navVC pushViewController:vc animated:YES];
    }
}

/**
 *  设置索引
 *
 *  @param tableView <#tableView description#>
 *
 *  @return <#return value description#>
 */
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    //数组中的字符串排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    
    NSArray *sortArr = [self.keys sortedArrayUsingDescriptors:@[sort]];
    
    if (_status == ZXForumTopViewControllerStatusLife) {
        return nil;
    }
    
    return sortArr;
}

- (NSInteger)idWithModel:(id)model{
    return [[model valueForKey:@"forumId"] integerValue];
}

- (NSString *)titleWithModel:(id)model{
    return [model valueForKey:@"forumName"];
}

@end