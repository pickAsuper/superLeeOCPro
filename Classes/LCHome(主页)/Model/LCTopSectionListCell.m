//
//  LCTopSectionListCell.m
//  HaoBan
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 tsingda. All rights reserved.
//

#import "LCTopSectionListCell.h"

@implementation LCTopSectionListCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *LCTopSectionListCellID = @"LCTopSectionListCellID";
    LCTopSectionListCell *cell = [tableView dequeueReusableCellWithIdentifier:LCTopSectionListCellID];
    
    if (!cell) {
        cell = [[LCTopSectionListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LCTopSectionListCellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        KS_WS(ws);
        
        // 课程分类
        UILabel *classCategoryLabel  = [UILabel labelWithTitleString:@"课程分类:" Font:KS_FONT(14) textColor:RGB(95, 95, 95)];
        self.classCategoryLabel = classCategoryLabel;
        [self.contentView addSubview:classCategoryLabel];
        
        [classCategoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.contentView.mas_top).offset(XT(10));
            make.left.mas_equalTo(ws.contentView.mas_left).offset(XT(30));
        }];
        
        
        // 课程积分
        UILabel *classIntegralLabel  = [UILabel labelWithTitleString:@"课程积分:" Font:KS_FONT(14) textColor:RGB(95, 95, 95)];
        self.classIntegralLabel = classIntegralLabel;
        
        [self.contentView addSubview:classIntegralLabel];
        [classIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.contentView.mas_top).offset(XT(10));
            make.right.mas_equalTo(ws.contentView.mas_right).offset(XT(-30));
            make.width.mas_equalTo(120);
        }];
        
        
        // 进度
        UILabel *progressLabel  = [UILabel labelWithTitleString:@"进度:" Font:KS_FONT(14) textColor:RGB(95, 95, 95)];
        self.progressLabel = progressLabel;
        [self.contentView addSubview:progressLabel];
        
        [progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(classCategoryLabel.mas_bottom).offset(XT(30));
            make.left.mas_equalTo(ws.contentView.mas_left).offset(XT(30));
        }];
        
        
        // 考试成绩
        UILabel *testIntegralLabel  = [UILabel labelWithTitleString:@"考试成绩:" Font:KS_FONT(14) textColor:RGB(95, 95, 95)];
        self.testIntegralLabel = testIntegralLabel;
        
        [self.contentView addSubview:testIntegralLabel];
        [testIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(classCategoryLabel.mas_bottom).offset(XT(30));
            make.right.mas_equalTo(ws.contentView.mas_right).offset(XT(-30));
            make.width.mas_equalTo(120);
        }];

//        UILabel *bottomLine        = [[UILabel alloc] init];
//        bottomLine.backgroundColor = KS_C_HEX(0xd7d7d7, 1.0f);
//        [self.contentView addSubview:bottomLine];
//       
//        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(ws.contentView.mas_bottom);
//            make.width.mas_equalTo(KS_SCREEN_WIDTH);
//            make.height.mas_equalTo(XT(1));
//        }];
        
        UIView *BottomView = [[UIView alloc] init];
        BottomView.backgroundColor = RGB(247, 247, 247);
        [self.contentView addSubview:BottomView];
        [BottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.contentView.mas_left);
            make.bottom.mas_equalTo(ws.contentView.mas_bottom);
            make.width.mas_equalTo(KS_SCREEN_WIDTH);
            make.height.mas_equalTo(BottomViewH);
        }];
        
        
        // 课程简介
        UILabel *courseLabel  = [UILabel labelWithTitleString:@"课程简介" Font:KS_FONT(14) textColor:RGB(33, 164, 212)];
        [BottomView addSubview:courseLabel];
        
        [courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(BottomView.mas_top).offset(XT(30));
            make.left.mas_equalTo(BottomView.mas_left).offset(XT(30));
            make.right.mas_equalTo(ws.contentView.mas_right).offset(XT(-30));
        }];
        
        
        // 课程简介内容
        UILabel *courseStringLabel  = [UILabel labelWithTitleString:@"课程简介内容" Font:KS_FONT(14) textColor:RGB(95, 95, 95)];
        self.courseStringLabel = courseStringLabel;
        
        [BottomView addSubview:courseStringLabel];
        [courseStringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(courseLabel.mas_bottom).offset(XT(20));
            make.left.mas_equalTo(BottomView.mas_left).offset(XT(40));
            make.right.mas_equalTo(ws.contentView.mas_right).offset(XT(-30));
        }];
        
        
    }
    return self;

}

@end
