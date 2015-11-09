//
//  ZXDetailViewController.h
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXNewsModel.h"
#import "ZXPostModel.h"

typedef enum : NSUInteger {
    ZXDetailViewControllerNews,
    ZXDetailViewControllerPost,
    ZXDetailViewControllerLink,
    ZXDetailViewControllerEventLink
} ZXDetailViewControllerStatus;

@interface ZXDetailViewController : UIViewController

@property (assign,nonatomic)ZXDetailViewControllerStatus status;

@property (strong, nonatomic)ZXNewsModel *newsModel;

@property (strong, nonatomic)ZXPostModel *postModel;

@property (copy, nonatomic)NSString *link;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
