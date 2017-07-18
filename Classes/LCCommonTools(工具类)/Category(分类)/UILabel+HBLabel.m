//
//  UILabel+HBLabel.m
//  HaoBan
//
//  Created by super on 2016/11/19.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "UILabel+HBLabel.h"

@implementation UILabel (HBLabel)
+ (UILabel *)labelWithTitleString:(NSString *)titleString Font:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc]init];
    label.text = titleString;
    label.font = font;
    label.textColor = textColor;
    [label sizeToFit];
    return label;
    
}


+ (UILabel *)labelWithTitleString:(NSString *)titleString Font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc]init];
    label.text = titleString;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    [label sizeToFit];

    return label;

}

- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    CGSize retSize          = [self.text boundingRectWithSize:size
                                                      options:\
                               NSStringDrawingTruncatesLastVisibleLine |
                               NSStringDrawingUsesLineFragmentOrigin |
                               NSStringDrawingUsesFontLeading
                                                   attributes:attribute
                                                      context:nil].size;
    
    return retSize;
}

@end
