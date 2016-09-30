//
//  LevelCell.m
//  MyDemo
//
//  Created by Meng Fan on 16/9/13.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

#import "LevelCell.h"
#import "Masonry.h"
#import "LevelItemView.h"
#import "UIViewExt.h"

/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

#define kSize [[UIScreen mainScreen] bounds].size

#define kPadding 20

@interface LevelCell ()

@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UIView *line;


@end


@implementation LevelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        WEAKSELF
        [self.contentView addSubview:self.levelLabel];
        [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(5);
        }];
        
        [self.contentView addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.levelLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kSize.width, 1));
        }];
        
        CGFloat width = (kSize.width- 4*kPadding)/3;
        
        for (int i = 1; i < 10; i++) {
            CGRect frame = CGRectZero;
            if (i < 4) {
                frame = CGRectMake(i*kPadding+(i-1)*width, 35, width, width+30);
            }
            else if(i < 7) {
                frame = CGRectMake((i-3)*kPadding+(i-4)*width, 35+width+20+15, width, width+30);
            }else if(i < 10) {
                frame = CGRectMake((i-6)*kPadding+(i-7)*width, 35+2*(width+20+15), width, width+30);
            }
            
            LevelItemView *btnView = [[LevelItemView alloc] initWithFrame:frame imageName:@"upRrow" levelStr:[NSString stringWithFormat:@"车型%d",i]];
            btnView.tag = 200+i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
            
            [self.contentView addSubview:btnView];
        }

    }
    return self;
}


#pragma mark - lazyloading
-(UILabel *)levelLabel {
    if (!_levelLabel) {
        _levelLabel = [[UILabel alloc] init];
        
        _levelLabel.textColor = [UIColor darkGrayColor];
        _levelLabel.font = [UIFont systemFontOfSize:15];
        _levelLabel.text = @"级别";
    }
    return _levelLabel;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor grayColor];
    }
    return _line;
}


#pragma mark - action
- (void)OnTapBtnView:(UITapGestureRecognizer *)tapG {
    if (self.clickLevelItemAction) {
        self.clickLevelItemAction(tapG.view.tag-200);
    }
}


@end
