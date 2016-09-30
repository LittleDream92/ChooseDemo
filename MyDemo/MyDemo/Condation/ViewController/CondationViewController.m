//
//  CondationViewController.m
//  MyDemo
//
//  Created by Meng Fan on 16/9/13.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

#import "CondationViewController.h"
#import "Masonry.h"

#import "PriceCell.h"
#import "LevelCell.h"

#define kSize [[UIScreen mainScreen] bounds].size

static NSString *const priceCellID = @"priceCellID";
static NSString *const levelCellID = @"levelCellID";

@interface CondationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CondationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupViews
- (void)setupViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - lazyloading
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor lightGrayColor];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        PriceCell *cell = [tableView dequeueReusableCellWithIdentifier:priceCellID];
        
        if (cell == nil) {
            cell = [[PriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceCellID];
        }
        
        cell.thumbMoveAction = ^(CGFloat x1, CGFloat x2) {
            NSLog(@"x1:%f;\nx2:%f", x1, x2);
        };
        
        return cell;
    }else {
        LevelCell *cell = [tableView dequeueReusableCellWithIdentifier:levelCellID];
        
        if (cell == nil) {
            cell = [[LevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:levelCellID];
        }
        
        cell.clickLevelItemAction = ^(NSInteger num) {
            NSLog(@"index:%ld", num);
        };
        
        return cell;
     }
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100.0f;
    }
    
    return (kSize.height - 64 - 100 - 20);
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}



@end
