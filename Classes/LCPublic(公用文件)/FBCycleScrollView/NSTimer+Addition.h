//
//  NSTimer+Addition.h
//  FamilyBaby
//
//  Created by super on 16/7/2.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)
// 暂停定时器
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
