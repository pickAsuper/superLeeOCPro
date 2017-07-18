//
//  NSMutableDictionary+KS.m
//  KSToolkit
//
//  Created by bing.hao on 14/11/27.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import "NSMutableDictionary+KS.h"

@implementation NSMutableDictionary (KS)


- (void)add:(id)key objectValue:(id)obj
{
    if (key) {
        if (obj) {
            [self setObject:obj forKey:key];
        } else {
            [self setObject:[NSNull null] forKey:key];
        }
    }
}

- (void)add:(NSString *)key stringValue:(NSString *)val
{
    if (key) {
        [self add:key objectValue:val];
    }
}

- (void)add:(NSString *)key intValue:(NSInteger)val
{
    if (key) {
        [self add:key objectValue:[NSNumber numberWithInteger:val]];
    }
}

- (void)add:(NSString *)key doubleValue:(double)val
{
    if (key) {
        [self add:key objectValue:[NSNumber numberWithDouble:val]];
    }
}

- (void)add:(NSString *)key floatValue:(float)val
{
    if (key) {
       [self add:key objectValue:[NSNumber numberWithFloat:val]];
    }
}

- (void)add:(NSString *)key int64Value:(int64_t)val
{
    if (key) {
        [self add:key objectValue:[NSNumber numberWithLongLong:val]];
    }
}

@end
