//
//  LCBrowserViewController.h
//  HaoBan
//
//  Created by admin on 2017/5/25.
//  Copyright © 2017年 tsingda. All rights reserved.
//

#import "HBBaseViewController.h"

@interface LCBrowserViewController : HBBaseViewController
/**
 要访问的URL地址
 */
@property (nonatomic, strong) NSURL *URL;

/**
 初始化方法
 
 @param URL 要访问的URL地址
 
 @return instancetype
 */
- (instancetype)initWithURL:(NSURL *)URL;

/**
 创建实例对象
 
 @param URL 要访问的URL地址
 
 @return instancetype
 */
+ (instancetype)createInstanceWithURL:(NSURL *)URL;


@end
