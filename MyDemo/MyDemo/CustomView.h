//
//  CustomView.h
//  MyDemo
//
//  Created by Meng Fan on 16/9/13.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *arrow1;
@property (weak, nonatomic) IBOutlet UIImageView *arrow2;

@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingContain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingContrain;

@end
