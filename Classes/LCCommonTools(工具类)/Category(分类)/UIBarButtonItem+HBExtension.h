//
//  UIBarButtonItem+HBExtension.h
//  HaoBan
//
//  Created by super on 2016/11/19.
//  Copyright © 2016年 tsingda. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HBExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
+ (instancetype)itemWithImageAnother:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action;


@end
