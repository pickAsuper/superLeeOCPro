//
//  LCMessageViewCell.m
//  HaoBan
//
//  Created by admin on 2017/6/28.
//  Copyright © 2017年 tsingda. All rights reserved.
//

#import "LCMessageViewCell.h"

@implementation LCMessageViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *LCMessageViewControllerID = @"LCMessageViewControllerID";
    
    
    LCMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LCMessageViewControllerID];
    if (!cell) {
        cell = [[LCMessageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LCMessageViewControllerID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;


}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.name = [UILabel new];
        self.name.tag = 90;
        self.name.font = KS_FONT(14);
        
        [[self contentView] addSubview:self.name];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo([self contentView]).offset(10);
            make.top.equalTo([self contentView]).offset(10);
            make.right.equalTo([self contentView]).offset(-10);
            make.bottom.equalTo([self contentView]).offset(-25);
        }];
        
        self.date = [UILabel new];
        self.date.tag = 91;
        self.date.font = KS_FONT(14);
        self.date.textAlignment = NSTextAlignmentRight;
        [[self contentView] addSubview:self.date];
        [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo([self contentView]).offset(0);
            make.right.equalTo([self contentView]).offset(-10);
            make.height.mas_equalTo(@25);
            make.left.equalTo([self contentView]).offset(10);
        }];
    }
    return self;
}


@end
