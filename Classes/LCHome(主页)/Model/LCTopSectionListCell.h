//
//  LCTopSectionListCell.h
//  HaoBan
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 tsingda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCTopSectionListCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

// 课程分类
@property (nonatomic, weak) UILabel *classCategoryLabel;

 // 课程积分
@property (nonatomic, weak) UILabel *classIntegralLabel;

// 进度
@property (nonatomic, weak) UILabel *progressLabel;

// 考试成绩
@property (nonatomic, weak) UILabel *testIntegralLabel;


// 课程简介内容
@property (nonatomic, weak) UILabel *courseStringLabel;
@end
