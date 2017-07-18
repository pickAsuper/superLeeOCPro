//
//  SPAllOpenLessonsList.h
//  SuperProject
//
//  Created by admin on 2017/5/2.
//  Copyright © 2017年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAllOpenLessonsList : NSObject

@property (nonatomic ,assign) int browseamount;
@property (nonatomic ,copy)  NSString *createdate;
@property (nonatomic ,copy)  NSString *pid;
@property (nonatomic ,copy)  NSString *lessonCode;

@property (nonatomic ,assign)  int  lessonHour;

@property (nonatomic ,copy)  NSString *lessonImg;

@property (nonatomic ,copy)  NSString *lessonName;

@end

/*
 browseamount = 115;
 createdate = "2017-05-02 15:42:56";
 id = "08defc11-7624-4ae8-9024-72c78de8966d";
 lessonCode = "mp4\U591a\U7ae0\U8282\U6d4b\U8bd5";
 lessonHour = 5;
 lessonImg = "http://www.training-faw-mazda.com/app/resource/lessonImg/defaultLessonImg.png";
 lessonName = "mp4\U591a\U7ae0\U8282\U6d4b\U8bd5";
 */
