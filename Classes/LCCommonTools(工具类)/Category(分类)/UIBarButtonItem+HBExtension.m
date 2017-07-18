//
//  UIBarButtonItem+HBExtension.m
//  HaoBan
//
//  Created by super on 2016/11/19.
//  Copyright © 2016年 tsingda. All rights reserved.
//


#import "UIBarButtonItem+HBExtension.h"

@implementation UIBarButtonItem (HBExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(0, 0, XT(40), XT(40))];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithImageAnother:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(0, 0, XT(57), XT(44))];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(0, 0, XT(175), XT(40))];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    return [[self alloc] initWithCustomView:button];

}

@end
