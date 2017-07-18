//
//  LCHomeListTableViewCell.h
//  HaoBan
//
//  Created by admin on 2017/6/27.
//  Copyright © 2017年 tsingda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCHomeListTableViewCell : UITableViewCell


+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@property (nonatomic ,weak) UIImageView * iconImageView;

// 标题文字
@property (nonatomic, weak) UILabel *textStringLabel;

// 中间的时间 首页需隐藏
@property (nonatomic, weak) UILabel *timeLabel;
//观看数
@property (nonatomic, weak) UILabel *lookLabel;

// 监控时间数
@property (nonatomic, weak) UILabel *monitoringTimeLabel;


@end
