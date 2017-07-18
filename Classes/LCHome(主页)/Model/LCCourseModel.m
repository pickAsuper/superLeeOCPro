//
//  LCCourseModel.m
//  SuperProject
//
//  Created by admin on 2017/6/10.
//  Copyright © 2017年 Bing. All rights reserved.
//

#import "LCCourseModel.h"

@implementation LCCourseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
    
}


+ (NSDictionary *)mj_objectClassInArray
{
    return  @{
              @"lessonHours": [LCCourseListModel class]
              };
}

@end
