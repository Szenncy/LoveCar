//
//  ZXFindCarSectionView.h
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXFindCarSectionView : UIView

@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, copy) NSString *sectionTitles;

- (instancetype)initWithSectionTitles:(NSString *)sectionTitles;

@end
