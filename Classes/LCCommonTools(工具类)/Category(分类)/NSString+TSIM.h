//
//  NSString+TSIM.h
//  TSIMKit
//
//  Created by bing.hao on 16/6/17.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <KSToolkit/NSString+KS.h>
/**
 * @brief 获取拼音首字母
 */
char tsim_pfl(unsigned short hanzi);

@interface NSString (TSIM)

/**
 * @brief 获取文字的首字母
 */
+ (NSString *)tsim_getInitialByString:(NSString *)str;

@end
