//
//  ZXNavTop.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXNavTop.h"

@interface ZXNavTop()
{
    didBackCallBack _backBlock;
}
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *getDocumentBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;

@end

@implementation ZXNavTop

- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZXNavTop" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    [self addSubview:self.contentView];
    
}
- (IBAction)backTouch:(id)sender {
    if (_backBlock) {
        _backBlock();
    }
}
- (IBAction)getDocumentTouch:(id)sender {
}
- (IBAction)moreTouch:(id)sender {
}

- (void)setBackBlock:(didBackCallBack)block{
    _backBlock = block;
}

- (void)setStatus:(ZXNavTopStatus)status{
    _status = status;
    
    switch (self.status) {
        case ZXNavTopStatusNews:
        {
            self.segmentView.hidden = YES;
        }
            break;
        case ZXNavTopStatusPost:{
            self.segmentView.hidden = NO;
        }
            break;
        default:
            break;
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, -20, self.superview.bounds.size.width, 64)];
}

@end
