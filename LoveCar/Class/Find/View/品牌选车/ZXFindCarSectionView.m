//
//  ZXFindCarSectionView.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015 Zency. All rights reserved.
//

#import "ZXFindCarSectionView.h"
#import "Config.h"

@implementation ZXFindCarSectionView

- (instancetype)initWithSectionTitles:(NSString *)sectionTitles {
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(18.0, 0.0, ScreenWidth, 23.0)];
        [self setBackgroundColor:ZXColor(248, 248, 248)];
        [self.layer setBorderColor:ZXColor(221, 221, 221).CGColor];
        [self.layer setBorderWidth:0.4];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:sectionTitles];
        [attrStr setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName : ZXColor(142, 142, 142)} range:NSMakeRange(0, attrStr.length)];
        
        self.headerLabel = [[UILabel alloc] initWithFrame:self.frame];
        [self.headerLabel setBackgroundColor:ZXColor(248, 248, 248)];
        self.headerLabel.opaque = NO;
        [self.headerLabel setAttributedText:attrStr];
        [self addSubview:self.headerLabel];
    }
    return self;
}

@end
