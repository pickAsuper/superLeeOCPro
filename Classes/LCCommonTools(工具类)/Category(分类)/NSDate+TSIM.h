//
//  NSDate+TSIM.h
//  TSIMUI
//
//  Created by bing.hao on 16/4/18.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TSIM_NSDate_STR_FORMAT @"yyyy-MM-dd HH:mm:ss"

@interface NSDate (TSIM)

/**
 *  将字符串转换为时间对象
 *
 *  @param str 字符串
 *
 *  @return NSDate
 */
+ (NSDate *)tsim_dateWithString:(NSString *)str;

/**
 *  将字符串转换为时间对象
 *
 *  @param str    字符串
 *  @param format 格式
 *
 *  @return NSDate
 */
+ (NSDate *)tsim_dateWithString:(NSString *)str withFormat:(NSString *)format;

/**
 *  将时间转换为字符串
 *
 *  @return NSString
 */
- (NSString *)tsim_toString;

/**
 *  将时间转换为字符串
 *
 *  @param format 格式
 *
 *  @return NSString
 */
- (NSString *)tsim_toString:(NSString *)format;

/**
 *  获取当前时间的毫秒数值
 *
 *  @return int64_t
 */
+ (int64_t)tsim_now;

/**
 *  根据毫秒数值获取时间对象
 *
 *  @param ms 数值
 *
 *  @return NSDate
 */
+ (NSDate *)tsim_dateWithMillisecond:(int64_t)ms;

/**
 *  格式化日期输出
 *  当时间为当天显示:[HH]:[ss]
 *  当时间为昨天显示:昨天 [HH]:[ss]
 *  当时间为7天以内显示:星期[n]
 *  其他:[yyyy]-[MM]-[dd]
 *  @param ms 毫秒数
 *
 *  @return NSString
 */
+ (NSString *)tsim_formatLocalTimeWithSecond:(NSTimeInterval)timeInterval;
+ (NSString *)tsim_formatLocalTimeWithMillisecond:(int64_t)ms;

/**
 *  格式化日期输出
 *  当时间为当天显示:[hh]:[ss]
 *  当时间为昨天显示:昨天
 *  当时间为7天以内显示:星期[n]
 *  其他:[yyyy]-[MM]-[dd]
 *  @param date 时间对象
 *
 *  @return NSString
 */
+ (NSString *)tsim_formatLocalTimeWithDate:(NSDate *)fdate;

@end
