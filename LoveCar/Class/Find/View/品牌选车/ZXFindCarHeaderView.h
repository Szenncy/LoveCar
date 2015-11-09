//
//  ZXFindCarHeaderView.h
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXFindCarHeaderView : UIView

@property (nonatomic, assign, readonly) CGFloat cellHeight;

- (instancetype)initHeaderViewWithSeriesImage:(NSString *)seriesImage carName:(NSString *)carName cheapRange:(NSString *)cheapRange dealerName:(NSString *)dealerName;

@end
