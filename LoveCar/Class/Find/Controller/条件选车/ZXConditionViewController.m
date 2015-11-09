//
//  ZXConditionViewController.m
//  LoveCar
//
//  Created by zency on 15/10/13.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXConditionViewController.h"
#import "ZXTitleCollectionViewCell.h"

@interface ZXConditionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSArray *_collectionInfo;
}
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *levelViews;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *countryViews;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *dischargeViews;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *structureViews;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *changSpeedViews;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewRight;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBtnCenter;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBtnCenter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *circleCenter;
@property (weak, nonatomic) IBOutlet UIButton *circleBtn;
@property (weak, nonatomic) IBOutlet UILabel *saleLabel;
@property (weak, nonatomic) IBOutlet UIView *saleView;

@end

@implementation ZXConditionViewController

#pragma mark - 初始化

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"条件选车";
    }
    return self;
}

- (void)initView{
    [self loadView:self.levelViews];
    [self loadView:self.countryViews];
    [self loadView:self.dischargeViews];
    [self loadView:self.structureViews];
    [self loadView:self.changSpeedViews];
    
    UIPanGestureRecognizer *panLeft = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(leftDrag:)];
    [self.leftBtn addGestureRecognizer:panLeft];
    
    UIPanGestureRecognizer *panRight = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(rightDrag:)];
    [self.rightBtn addGestureRecognizer:panRight];
    
    [self initSaleView];
}

- (void)initCollectionView{
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZXTitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    _collectionInfo = @[@"ISO FIX儿童座椅接口",@"LATCH儿童座椅接口",@"前雾灯",@"定速巡航",@"无钥匙启动系统",@"天窗",@"多功能方向盘",@"车身稳定控制(ESP/DSC等)",@"倒车视频影像",@"自动泊车入位",@"第三排座椅",@"前排座椅加热",@"真皮/仿皮座椅",@"日间行车灯",@"中控彩色大屏",@"副驾驶座电动调节",@"8喇叭以上扬声器系统",@"氙气大灯",@"GPS导航系统",@"自动空调",@"后排出风口",@"外界音源接口(AUX/USB等)"];
}

- (void)initSaleView{
    
    for (NSInteger i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc]init];
        
        label.font = [UIFont systemFontOfSize:13];
        
        label.text = [NSString stringWithFormat:@"%ld",(i+1) * 10];
        
        CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT,MAXFLOAT)];
        
        label.frame = CGRectMake(50 + ([UIScreen mainScreen].bounds.size.width - 100)/9 + i * (float)([UIScreen mainScreen].bounds.size.width - 100)/ 7, 40, size.width, size.height);
        
        [self.saleView addSubview:label];
        
    }
    
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    
    [self initCollectionView];
}

#pragma mark - 内部逻辑算法
- (void)loadView:(NSArray *)objs{
    for (UIView *v in objs) {
        v.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        v.layer.borderWidth = 0.5;
    }
}
#pragma mark - collectiontViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _collectionInfo.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZXTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.title = _collectionInfo[indexPath.item];
    
    cell.layer.cornerRadius = 5;
    
    cell.layer.borderWidth = 0.5;
    
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UILabel *label = [[UILabel alloc]init];
    
    label.font = [UIFont systemFontOfSize:12];
    
    label.text = _collectionInfo[indexPath.item];
    
    CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    return CGSizeMake(size.width + 10, size.height + 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
#pragma mark - 事件响应
- (void)leftDrag:(UIPanGestureRecognizer *)gesture{
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.circleBtn.hidden = NO;
            [self.circleBtn setTitle:self.leftBtn.titleLabel.text forState:UIControlStateNormal];
            self.circleCenter.constant = self.leftBtnCenter.constant;
        }
            break;
        case UIGestureRecognizerStateEnded:
            self.circleBtn.hidden = YES;
        default:
            break;
    }
    
    [self setTitle];
    
    CGPoint point = [gesture translationInView:self.view];
    
    self.imageViewLeft.constant += point.x;
    self.leftBtnCenter.constant += point.x
    ;
    self.circleCenter.constant += point.x;
    
    CGFloat sum = [UIScreen mainScreen].bounds.size.width - 110;
    
    [self.leftBtn setTitle:[NSString stringWithFormat:@"%d",(int)((float)(self.imageViewLeft.constant/sum) * 70)] forState:UIControlStateNormal];
    
    [self.circleBtn setTitle:[NSString stringWithFormat:@"%d",(int)((float)(self.imageViewLeft.constant/sum) * 70)] forState:UIControlStateNormal];
    
    if (self.imageViewLeft.constant < 0) {
        self.imageViewLeft.constant = 0;
        self.leftBtnCenter.constant = 0;
        self.circleCenter.constant = 0;
        [self.leftBtn setTitle:@"0" forState:UIControlStateNormal];
    }
    
    if (self.imageViewLeft.constant >= [UIScreen mainScreen].bounds.size.width - 110) {
        self.imageViewLeft.constant = [UIScreen mainScreen].bounds.size.width - 110;
        self.leftBtnCenter.constant = [UIScreen mainScreen].bounds.size.width - 110;
        self.circleCenter.constant = [UIScreen mainScreen].bounds.size.width - 110;
        [self.leftBtn setTitle:@"70+" forState:UIControlStateNormal];
    }
    
    if (self.leftBtnCenter.constant - self.rightBtnCenter.constant > [UIScreen mainScreen].bounds.size.width - 110)
    {
        /*self.imageViewLeft.constant = [UIScreen mainScreen].bounds.size.width - 110 + self.rightBtnCenter.constant;
        self.leftBtnCenter.constant = [UIScreen mainScreen].bounds.size.width - 110 + self.rightBtnCenter.constant;
        self.circleCenter.constant = [UIScreen mainScreen].bounds.size.width - 110 + self.rightBtnCenter.constant;*/
        
        self.imageViewRight.constant +=point.x;
        self.rightBtnCenter.constant +=point.x;
        [self.rightBtn setTitle:[NSString stringWithFormat:@"%d",(int)((float)(self.imageViewRight.constant/sum) * 70 + 70)] forState:UIControlStateNormal];
    }
    
    
    [gesture setTranslation:CGPointZero inView:self.view];
    
}

- (void)rightDrag:(UIPanGestureRecognizer *)gesture{
    CGPoint point = [gesture translationInView:self.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.circleBtn.hidden = NO;
            [self.circleBtn setTitle:self.rightBtn.titleLabel.text forState:UIControlStateNormal];
            self.circleCenter.constant = [UIScreen mainScreen].bounds.size.width - 100 + self.rightBtnCenter.constant;
        }
            break;
        case UIGestureRecognizerStateEnded:
            self.circleBtn.hidden = YES;
        default:
            break;
    }
    [self setTitle];
    
    self.imageViewRight.constant += point.x;
    
    self.rightBtnCenter.constant += point.x;
    
    self.circleCenter.constant += point.x;
    
    CGFloat sum = [UIScreen mainScreen].bounds.size.width - 110;
    
    [self.rightBtn setTitle:[NSString stringWithFormat:@"%d",(int)((float)(self.imageViewRight.constant/sum) * 70 + 70)] forState:UIControlStateNormal];
    
    [self.circleBtn setTitle:[NSString stringWithFormat:@"%d",(int)((float)(self.imageViewRight.constant/sum) * 70 + 70)] forState:UIControlStateNormal];
    
    if (self.imageViewRight.constant > 0) {
        self.imageViewRight.constant = 0;
        self.rightBtnCenter.constant = 0;
        self.circleCenter.constant = [UIScreen mainScreen].bounds.size.width - 100;
        [self.rightBtn setTitle:@"70+" forState:UIControlStateNormal];
        [self.circleBtn setTitle:@"70+" forState:UIControlStateNormal];
    }
    
    if (self.imageViewRight.constant <= -[UIScreen mainScreen].bounds.size.width + 110) {
        self.imageViewRight.constant = -[UIScreen mainScreen].bounds.size.width + 110;
        self.rightBtnCenter.constant = -[UIScreen mainScreen].bounds.size.width + 110;
        
        self.circleCenter.constant = 10;
        [self.rightBtn setTitle:@"0" forState:UIControlStateNormal];
        [self.circleBtn setTitle:@"0" forState:UIControlStateNormal];
    }
    
    if (self.leftBtnCenter.constant - self.rightBtnCenter.constant > [UIScreen mainScreen].bounds.size.width - 110)
    {
        /*self.imageViewRight.constant = -[UIScreen mainScreen].bounds.size.width + 110 + self.leftBtnCenter.constant;
        self.rightBtnCenter.constant = -[UIScreen mainScreen].bounds.size.width + 110 + self.leftBtnCenter.constant;
        
        self.circleCenter.constant = 10 + self.leftBtnCenter.constant;*/
        
        self.imageViewLeft.constant +=point.x;
        self.leftBtnCenter.constant +=point.x;
        [self.leftBtn setTitle:[NSString stringWithFormat:@"%d",(int)((float)(self.imageViewLeft.constant/sum) * 70)] forState:UIControlStateNormal];
    }
    
    [gesture setTranslation:CGPointZero inView:self.view];
}

#pragma mark - 内部逻辑算法

- (void)setTitle{
    
    if ([self.leftBtn.titleLabel.text isEqualToString:self.rightBtn.titleLabel.text]) {
        //NSLog(@"%@",self.leftBtn.titleLabel.text);
        if ([self.leftBtn.titleLabel.text isEqualToString:@"70+"]||[self.leftBtn.titleLabel.text isEqualToString:@"70"]) {
            self.saleLabel.text = @"70万以上";
        }else if([self.leftBtn.titleLabel.text isEqualToString:@"0"]){
            self.saleLabel.text = @"1万以下";
        }
        else{
            self.saleLabel.text = [NSString stringWithFormat:@"%@万",self.leftBtn.titleLabel.text];
        }
    }else{
        if ([self.rightBtn.titleLabel.text isEqualToString:@"70+"]||[self.leftBtn.titleLabel.text isEqualToString:@"70"])
        {
            if([self.leftBtn.titleLabel.text isEqualToString:@"0"]||[self.leftBtn.titleLabel.text isEqualToString:@"70+"]||[self.leftBtn.titleLabel.text isEqualToString:@"70"]){
                self.saleLabel.text = @"不限";
            }else{
                self.saleLabel.text = [NSString stringWithFormat:@"%@～70万以上",self.leftBtn.titleLabel.text];
            }
            
        }else{
            self.saleLabel.text = [NSString stringWithFormat:@"%@～%@万",self.leftBtn.titleLabel.text,self.rightBtn.titleLabel.text];
        }
    }

}

@end
