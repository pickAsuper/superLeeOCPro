//
//  LCHomeListTableViewCell.m
//  HaoBan
//
//  Created by admin on 2017/6/27.
//  Copyright © 2017年 tsingda. All rights reserved.
//

#import "LCHomeListTableViewCell.h"



@implementation LCHomeListTableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView
{
    NSString *LCHomeListTableViewCellID = @"LCHomeListTableViewCell";
    
    LCHomeListTableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:LCHomeListTableViewCellID];
    if (cell == nil) {
        cell = [[LCHomeListTableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LCHomeListTableViewCellID];
    }
    return cell;

}




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        KS_WS(ws);
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = RGB(248, 248, 248);
        [self.contentView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.contentView.mas_top);
//            make.right.mas_equalTo(ws.contentView.mas_right);
//            make.left.mas_equalTo(ws.contentView.mas_left);
            make.width.mas_equalTo(KS_SCREEN_WIDTH);
            make.height.mas_equalTo(8);
        }];
        
        // 图片
        UIImageView * iconImageView = [[UIImageView alloc]init];
        self.iconImageView = iconImageView;
        iconImageView.image = [UIImage imageNamed:@"image3.png"];
        [self.contentView addSubview:iconImageView];
     
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topView.mas_bottom).offset(XT(10));
            make.bottom.mas_equalTo(ws.contentView.mas_bottom).offset(XT(-10));
            make.left.mas_equalTo(ws.contentView.mas_left).offset(XT(10));
            make.width.mas_equalTo(130);
        }];

        
        // 标题文字
       UILabel *textStringLabel =  [UILabel labelWithTitleString:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊" Font:KS_FONT(13)textColor:[UIColor blackColor]];
        textStringLabel.numberOfLines = 2;
        self.textStringLabel = textStringLabel;
        
//   textStringLabel.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview: textStringLabel];
        
        [textStringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(iconImageView.mas_top).offset(XT(5));
            make.left.mas_equalTo(iconImageView.mas_right).offset(XT(10));
            make.right.mas_equalTo(ws.contentView.mas_right).offset(XT(-10));

        }];
        
        // 中间的时间 首页需隐藏
        UILabel *timeLabel = [UILabel labelWithTitleString:@"[2017-06-27]" Font:KS_FONT(12) textColor: RGB(154, 154, 154)];
        self.timeLabel = timeLabel;
//timeLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:timeLabel];

        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(textStringLabel.mas_bottom).offset(XT(5));
            make.left.mas_equalTo(iconImageView.mas_right).offset(XT(10));
            make.right.mas_equalTo(ws.contentView.mas_right).offset(XT(-10));
        }];

        
        
        
        // 浏览次数图片
        UIImageView * lookImageView = [[UIImageView alloc]init];
        lookImageView.image = [UIImage imageNamed:@"浏览.png"];
        [self.contentView addSubview:lookImageView];
        
        [lookImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.mas_right).offset(5);
            make.bottom.mas_equalTo(iconImageView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        
        }];

        // 观看数
        UILabel *lookLabel = [UILabel labelWithTitleString:@"(2017)" Font:KS_FONT(12) textColor: RGB(154, 154, 154)];
//lookLabel.backgroundColor = [UIColor yellowColor];
        self.lookLabel = lookLabel;
        
        [self.contentView addSubview:lookLabel];
        
        [lookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(iconImageView.mas_bottom);
            make.left.mas_equalTo(lookImageView.mas_right).offset(XT(5));
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        
        
        // 监控时间的图片
        UIImageView * monitoringTimeImageView = [[UIImageView alloc]init];
        monitoringTimeImageView.image = [UIImage imageNamed:@"课时.png"];
        [self.contentView addSubview:monitoringTimeImageView];
        
        [monitoringTimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lookLabel.mas_right).offset(10);
            make.bottom.mas_equalTo(iconImageView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            
        }];
        
        // 监控时间数
        UILabel *monitoringTimeLabel = [UILabel labelWithTitleString:@"(2017)" Font:KS_FONT(12) textColor: RGB(154, 154, 154)];
        self.monitoringTimeLabel = monitoringTimeLabel;
        
//monitoringTimeLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:monitoringTimeLabel];
        
        [monitoringTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(iconImageView.mas_bottom);
            make.left.mas_equalTo(monitoringTimeImageView.mas_right).offset(XT(5));
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];

        
        
        
        
    }
    return self;
}
@end
