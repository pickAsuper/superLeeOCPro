//
//  UILabel+HBLabel.h
//  HaoBan
//
//  Created by super on 2016/11/19.
//  Copyright © 2016年 tsingda. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface UILabel (HBLabel)

+ (UILabel *)labelWithTitleString:(NSString *)titleString Font:(UIFont *)font textColor:(UIColor *)textColor;

+ (UILabel *)labelWithTitleString:(NSString *)titleString Font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;


- (CGSize)boundingRectWithSize:(CGSize)size;

@end
