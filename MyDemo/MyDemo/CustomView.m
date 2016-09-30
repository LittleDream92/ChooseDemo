//
//  CustomView.m
//  MyDemo
//
//  Created by Meng Fan on 16/9/13.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

#import "CustomView.h"
#import "UIViewExt.h"

@implementation CustomView

-(void)awakeFromNib {
    [self setupViews];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    UIPanGestureRecognizer *pan1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan1:)];
    [self.arrow1 addGestureRecognizer:pan1];
    
    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan2:)];
    [self.arrow2 addGestureRecognizer:pan2];
}


- (void)pan1:(UIPanGestureRecognizer *)panGesture {
    NSLog(@"pan1");
    CGPoint point = [panGesture translationInView:self];
    static CGPoint centerPoint;
//    CGFloat blueViewX = CGRectGetMaxX(self.blueView.frame);
    
    //初始位置
    if (panGesture.state ==UIGestureRecognizerStateBegan) {
        centerPoint = panGesture.view.center;
    }
    
    panGesture.view.center = CGPointMake(point.x + centerPoint.x, 80);
    self.leadingContain.constant = point.x + centerPoint.x;
//    self.blueView.left = self.arrow1.center.x;
//    self.blueView.width = blueViewX - self.arrow1.center.x;
    
    if (panGesture.view.center.x < 10) {
        panGesture.view.center = CGPointMake(10,80);
    }else if (panGesture.view.center.x > 365 ) {
        panGesture.view.center = CGPointMake(365,80);
    }
    
}


- (void)pan2:(UIPanGestureRecognizer *)panGesture {
    NSLog(@"pan2");
    
    CGPoint point = [panGesture translationInView:self];
    static CGPoint centerPoint;
    
    //初始位置
    if (panGesture.state ==UIGestureRecognizerStateBegan) {
        centerPoint = panGesture.view.center;
    }
    
    CGFloat x = centerPoint.x+point.x;
    panGesture.view.center = CGPointMake(x, 80);
    self.trailingContrain.constant = 375-x;
//    self.blueView.right = x;
//    self.blueView.width = x - self.arrow1.center.x;

    
    if (panGesture.view.center.x < 10) {
        panGesture.view.center = CGPointMake(10,80);
    }
    if (panGesture.view.center.x > 365 ) {
        panGesture.view.center = CGPointMake(365,80);
    }
}

@end
