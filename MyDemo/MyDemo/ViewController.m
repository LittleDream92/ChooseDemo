//
//  ViewController.m
//  MyDemo
//
//  Created by Meng Fan on 16/9/12.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

#import "UIViewExt.h"
#import "CondationViewController.h"
#import "CustomView.h"

/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

#define kSize [[UIScreen mainScreen] bounds].size

@interface ViewController ()

@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UIImageView *thumb1;
@property (nonatomic, strong) UIImageView *thumb2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    CustomView *view = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil] lastObject];
    view.frame = CGRectMake(0, 250, 375, 100);
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews {
    
    WEAKSELF
    
    [self.view addSubview:self.sliderView];
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kSize.width, 80));
        make.top.equalTo(@100);
        make.left.equalTo(weakSelf.view);
    }];
    
    [self.sliderView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 10, 20, 10));
    }];
    
    [self.sliderView addSubview:self.blueView];
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 10, 20, 10));
    }];
    
    [self.sliderView addSubview:self.thumb1];
    [self.thumb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.centerX.equalTo(weakSelf.sliderView.mas_left).offset(10);
        make.centerY.equalTo(weakSelf.bgView.mas_bottom).offset(5);
    }];
    
    [self.sliderView addSubview:self.thumb2];
    [self.thumb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.centerX.equalTo(weakSelf.sliderView.mas_right).offset(-10);
        make.centerY.equalTo(weakSelf.bgView.mas_bottom).offset(5);
    }];
    
}


#pragma mark - lazyloading
-(UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
//        _sliderView.backgroundColor = [UIColor yellowColor];
    }
    return _sliderView;
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor brownColor];
    }
    return _bgView;
}

-(UIView *)blueView {
    if (!_blueView) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

-(UIImageView *)thumb1 {
    if (!_thumb1) {
        _thumb1 = [[UIImageView alloc] init];
        _thumb1.userInteractionEnabled = YES;
        _thumb1.image = [UIImage imageNamed:@"upRrow"];
//        _thumb1.backgroundColor = [UIColor redColor];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(thumbAction1:)];
        [_thumb1 addGestureRecognizer:pan];
        
    }
    return _thumb1;
}

-(UIImageView *)thumb2 {
    if (!_thumb2) {
        _thumb2 = [[UIImageView alloc] init];
        _thumb2.userInteractionEnabled = YES;
        _thumb2.image = [UIImage imageNamed:@"upRrow"];
//        _thumb2.backgroundColor = [UIColor cyanColor];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(thumbAction2:)];
        [_thumb2 addGestureRecognizer:pan];
    }
    return _thumb2;
}

#pragma mark - action
- (void)thumbAction1:(UIPanGestureRecognizer *)panGesture {
    NSLog(@"thumb1");
    
    CGPoint point = [panGesture translationInView:self.sliderView];
    static CGPoint center;
    CGFloat thub2X = CGRectGetMinX(self.thumb2.frame);
    CGFloat blueViewX = CGRectGetMaxX(self.blueView.frame);
    
    //初始位置
    if (panGesture.state ==UIGestureRecognizerStateBegan) {
        center = panGesture.view.center;
    }
    
    CGFloat x = point.x+center.x;
    self.blueView.left = self.thumb1.center.x;
    self.blueView.width = blueViewX - self.thumb1.center.x;
    
    panGesture.view.center = CGPointMake(x, 65);
    
    if (panGesture.view.center.x < 10) {
        panGesture.view.center = CGPointMake(10,65);
    }else if (panGesture.view.center.x > thub2X ) {
        panGesture.view.center = CGPointMake(thub2X-15,65);
    }
}

- (void)thumbAction2:(UIPanGestureRecognizer *)panGesture {
    NSLog(@"thumb2");
    
    CGFloat thub1X = CGRectGetMaxX(self.thumb1.frame);
    
    CGPoint point = [panGesture translationInView:self.sliderView];
    static CGPoint center;
    
    //初始位置
    if (panGesture.state ==UIGestureRecognizerStateBegan) {
        center = panGesture.view.center;
    }
    
    CGFloat x = center.x+point.x;
    panGesture.view.center = CGPointMake(x, 65);
    self.blueView.width = x - self.thumb1.center.x;
    self.blueView.right = x;
    
    if (panGesture.view.center.x < thub1X) {
        self.blueView.width = self.thumb2.center.x - self.thumb1.center.x;
        self.blueView.right = self.thumb2.center.x;
        
        panGesture.view.center = CGPointMake(thub1X+15,65);
    }
    if (panGesture.view.center.x > 365 ) {
        self.blueView.width = 375-20;
        self.blueView.right = 365;
        
        panGesture.view.center = CGPointMake(365,65);
    }
}

- (IBAction)clickButtonAction:(id)sender {
    
    CondationViewController *condationVC = [[CondationViewController alloc] init];
    [self.navigationController pushViewController:condationVC animated:YES];
    
}

@end
