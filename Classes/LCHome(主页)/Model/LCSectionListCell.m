//
//  LCSectionListCell.m
//  HaoBan
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 tsingda. All rights reserved.
//

#import "LCSectionListCell.h"

@interface LCSectionListCell()

/** 底部边线 */
@property (nonatomic, weak) UILabel *bottomLine;

@end
@implementation LCSectionListCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *LCSectionListCellID = @"LCSectionListCellID";
    LCSectionListCell *cell = [tableView dequeueReusableCellWithIdentifier:LCSectionListCellID];
    
    if (!cell) {
        cell = [[LCSectionListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LCSectionListCellID];
    }
    
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *orderLabel      = [[UILabel alloc] init];
        
        orderLabel.textColor = KS_C_RGBA(108, 108, 108, 1.0f);
        orderLabel.textAlignment = NSTextAlignmentCenter;
        orderLabel.font          = KS_FONT(XT(24));
        self.orderLabel          = orderLabel;
        [self.contentView addSubview:orderLabel];
        
        UIImageView *playMarks = [[UIImageView alloc] init];
        playMarks.image = [UIImage imageNamed:@"play@2x.png"];
        self.playMarks         = playMarks;
        [self.contentView addSubview:playMarks];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = KS_C_RGBA(108, 108, 108, 1.0f);
        titleLabel.font     = KS_FONT(XT(26));
        self.titleLabel     = titleLabel;
        [self.contentView addSubview:titleLabel];
        
        
        UILabel *bottomLine        = [[UILabel alloc] init];
        self.bottomLine            = bottomLine;
        bottomLine.backgroundColor = KS_C_HEX(0xd7d7d7, 1.0f);
        [self.contentView addSubview:bottomLine];
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.orderLabel.frame = CGRectMake(XT(49), self.height / 2 -  XT(15), XT(40), XT(30));
    
    self.playMarks.frame = CGRectMake(CGRectGetMaxX(self.orderLabel.frame) + XT(20), self.height / 2 - XT(19), XT(38), XT(38));
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.playMarks.frame) + XT(40), self.height / 2 - XT(19), self.width - XT(25 + 36 + 20) - XT(49 + 40 + 20 + 28 + 40), XT(38));
    
    self.bottomLine.frame = CGRectMake(CGRectGetMaxX(self.orderLabel.frame) + XT(20), self.height-1, self.width - XT(90), XT(2));
}


@end
