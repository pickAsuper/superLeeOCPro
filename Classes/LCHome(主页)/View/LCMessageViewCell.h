//
//  LCMessageViewCell.h
//  HaoBan
//
//  Created by admin on 2017/6/28.
//  Copyright © 2017年 tsingda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCMessageViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *date;

@end
