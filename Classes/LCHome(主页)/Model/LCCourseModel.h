//
//  LCCourseModel.h
//  SuperProject
//
//  Created by admin on 2017/6/10.
//  Copyright © 2017年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCourseListModel.h"

@interface LCCourseModel : NSObject

@property (nonatomic, copy)NSString  *SELECTDATE;

@property (nonatomic, copy)NSString  *status;
@property (nonatomic, copy)NSString  *lessonSummary;
@property (nonatomic, copy)NSString  *code;
@property (nonatomic, copy)NSString  *lessonVideoUrl;
@property (nonatomic, copy)NSString  *lessonImg;
@property (nonatomic, copy)NSString  *achievement;
@property (nonatomic, copy)NSString  *knowledgeName;
@property (nonatomic, copy)NSString  *onlineLessonUrl;
@property (nonatomic, copy)NSString  *completeStatus;
@property (nonatomic, copy)NSString  *REGNAME;
@property (nonatomic, copy)NSString  *lessonScore;
@property (nonatomic, copy)NSString  *STUDENT_TOKEN;
@property (nonatomic, copy)NSString  *ID;
@property (nonatomic, copy)NSString  *lessonName;
@property (nonatomic, copy)NSString  *lessonHour;
@property (nonatomic, copy)NSString  *vodid;
@property (nonatomic, copy)NSString  *lessonVideoName;
@property (nonatomic, copy)NSString  *STUDENT_JOIN_URL;
@property (nonatomic, copy)NSString  *STUDYPLAN;

@property (nonatomic, copy)NSString  *kjType;
@property (nonatomic, copy)NSString  *lessonSCORMUrl;
@property (nonatomic, copy)NSString  *password;
@property (nonatomic, copy)NSString  *msg;
@property (nonatomic, copy)NSArray  *lessonHours;

/*
 SELECTDATE = "<null>";
	status = "success";
	lessonSummary = "第二章";
	code = "00002";
	lessonVideoUrl = "http://xiaofang.aotimes.com/resource/mp4Course/a65fdfc5-6389-48a9-920d-c0cceef76d09/1.mp4";
	lessonImg = "http://xiaofang.aotimes.com/resource/lessonImg/067e0b4a-8691-4a89-84ab-7ed2cc6ba2b7.png";
	achievement = "1";
	knowledgeName = "燃烧与火灾基础知识";
	onlineLessonUrl = "?nickname=liangyue&token=";
	completeStatus = "0";
	REGNAME = "liangyue";
	lessonScore = "1";
	STUDENT_TOKEN = "";
	id = "a65fdfc5-6389-48a9-920d-c0cceef76d09";
	lessonName = "第二章";
	lessonHour = "5";
	vodid = "<null>";
	lessonVideoName = "";
	STUDENT_JOIN_URL = "";
	kjType = "6";
	lessonSCORMUrl = "http://xiaofang.aotimes.com:8115/NMDLApp/lesson.do?method=scormPlayer&userId=f5aa0338-e6a0-4c82-a079-eb7d07e0370d&lessonId=a65fdfc5-6389-48a9-920d-c0cceef76d09";
	password = "<null>";
	msg = "查询成功!";

	lessonHours = "(
         {
         "ENTER_URL" = "http://xiaofang.aotimes.com/resource/mp4Course/a65fdfc5-6389-48a9-920d-c0cceef76d09/1.mp4";
         id = "f50c0e73-7a54-4588-a2cb-441510b310a2";
         "le_id" = "a65fdfc5-6389-48a9-920d-c0cceef76d09";
         
         "le_name" = 1;
         lindex = 0;
         }
 )";

 
 */
@end
