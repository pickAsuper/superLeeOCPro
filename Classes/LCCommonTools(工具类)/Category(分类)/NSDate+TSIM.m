//
//  NSDate+TSIM.m
//  TSIMUI
//
//  Created by bing.hao on 16/4/18.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "NSDate+TSIM.h"

@implementation NSDate (TSIM)

+ (NSDate *)tsim_dateWithString:(NSString *)str
{
    return [self tsim_dateWithString:str withFormat:TSIM_NSDate_STR_FORMAT];
}

+ (NSDate *)tsim_dateWithString:(NSString *)str withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:str];
}

- (NSString *)tsim_toString
{
    return [self tsim_toString:TSIM_NSDate_STR_FORMAT];
}

- (NSString *)tsim_toString:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

+ (int64_t)tsim_now {
    return (int64_t)([[NSDate date] timeIntervalSince1970] * 1000);
}

+ (NSDate *)tsim_dateWithMillisecond:(int64_t)ms {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(ms * 1.0f / 1000)];
    return date;
}

+ (NSString *)tsim_formatLocalTimeWithSecond:(NSTimeInterval)timeInterval {
    if (timeInterval <= 0) {
        return nil;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [self tsim_formatLocalTimeWithDate:date];
}

+ (NSString *)tsim_formatLocalTimeWithMillisecond:(int64_t)ms {
    if (ms <= 0) {
        return nil;
    }
    return [self tsim_formatLocalTimeWithDate:[self tsim_dateWithMillisecond:ms]];
}

+ (NSString *)tsim_formatLocalTimeWithDate:(NSDate *)fdate {
    
    NSDate *cdate = [NSDate date];
    NSString *fstr = [fdate tsim_toString:@"yyyy-MM-dd"];
    NSString *tstr = [fdate tsim_toString:@"HH:mm"];
    
    //判断是否为当天
    if ([fstr isEqualToString:[cdate tsim_toString:@"yyyy-MM-dd"]]) {
        return tstr;
    }
    //判断是否为昨天
    if ([fstr isEqualToString:[[cdate dateByAddingTimeInterval:-86400] tsim_toString:@"yyyy-MM-dd"]]) {
        return [NSString stringWithFormat:@"昨天 %@", tstr];
    }
    //判断是否为7天以内
    if ([cdate timeIntervalSinceDate:fdate] / (60 * 60 * 24) <= 7) {
        NSCalendar * calendar = [NSCalendar currentCalendar];
        NSDateComponents * comp = [calendar components:NSCalendarUnitWeekday fromDate:fdate];
        NSInteger weekday = [comp weekday] - 1;
        switch (weekday) {
            case 1:
                return [NSString stringWithFormat:@"星期一 %@", tstr];
            case 2:
                return [NSString stringWithFormat:@"星期二 %@", tstr];
            case 3:
                return [NSString stringWithFormat:@"星期三 %@", tstr];
            case 4:
                return [NSString stringWithFormat:@"星期四 %@", tstr];
            case 5:
                return [NSString stringWithFormat:@"星期五 %@", tstr];
            case 6:
                return [NSString stringWithFormat:@"星期六 %@", tstr];
            default:
                return [NSString stringWithFormat:@"星期日 %@", tstr];
        }
    }
    //其他
    return fstr;
}

@end
