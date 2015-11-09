//
//  ZXNavForumViewController.m
//  LoveCar
//
//  Created by zency on 15/10/16.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXNavForumViewController.h"

@interface ZXNavForumViewController ()
{
    closeCallback _block;
}
@end

@implementation ZXNavForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)close:(BOOL)animate{
    if (_block) {
        _block(animate);
    }
}

- (void)setCloseCallback:(closeCallback)block{
    _block = block;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
