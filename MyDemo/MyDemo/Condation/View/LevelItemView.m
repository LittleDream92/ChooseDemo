//
//  LevelItemView.m
//  MyDemo
//
//  Created by Meng Fan on 16/9/13.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

#import "LevelItemView.h"
#import "Masonry.h"
/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

#define kSize [[UIScreen mainScreen] bounds].size

#define kPadding 20

@interface LevelItemView ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *levelStrLabel;

@end

@implementation LevelItemView


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = (kSize.width- 4*kPadding)/3;
        
        WEAKSELF
        [self addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, width));
            make.left.equalTo(weakSelf);
            make.top.equalTo(weakSelf);
        }];
        
        [self addSubview:self.levelStrLabel];
        [self.levelStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.imgView.mas_bottom).offset(5);
            make.left.equalTo(weakSelf);
            make.width.equalTo(weakSelf);
        }];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imgName levelStr:(NSString *)levelStr {
    self = [self initWithFrame:frame];
    if (self) {
        
        self.imgView.image = [UIImage imageNamed:imgName];
        self.levelStrLabel.text = levelStr;
    }
    return self;
}

#pragma mark - lazyloading
-(UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor cyanColor];
    }
    return _imgView;
}

-(UILabel *)levelStrLabel {
    if (!_levelStrLabel) {
        _levelStrLabel = [[UILabel alloc] init];
//        _levelStrLabel.backgroundColor = [UIColor redColor];
        _levelStrLabel.textColor = [UIColor darkGrayColor];
        _levelStrLabel.textAlignment = NSTextAlignmentCenter;
        _levelStrLabel.font = [UIFont systemFontOfSize:15];
    }
    return _levelStrLabel;
}


@end
