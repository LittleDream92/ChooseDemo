//
//  LevelCell.h
//  MyDemo
//
//  Created by Meng Fan on 16/9/13.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelCell : UITableViewCell

@property (nonatomic, copy) void(^clickLevelItemAction)(NSInteger num);

@end
