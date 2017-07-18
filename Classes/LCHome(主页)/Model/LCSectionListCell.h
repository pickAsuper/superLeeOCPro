//
//  LCSectionListCell.h
//  HaoBan
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 tsingda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCSectionListCell : UITableViewCell

/** 顺序 */
@property (nonatomic, weak) UILabel *orderLabel;

/** 播放的标志 */
@property (nonatomic, weak) UIImageView *playMarks;


/** 视频的名称 */
@property (nonatomic, weak) UILabel *titleLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
