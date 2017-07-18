//
//  FBWebAPI.h
//  FamilyBaby
//
//  Created by super on 16/8/30.
//  Copyright © 2016年 super. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "FBHttpRequest.h"

@interface FBWebAPI : FBHttpRequest

@end
#pragma mark -

#pragma mark 测试方法
#pragma mark -
/**
 *  这是一个演示API
 *  方方法名称全部为大写,以FB_WEB为前缀,单词之间使用_分割
 *  @param test1 test1 description
 *  @param test2 test2 description
 *  @param t     回调方法
 */
void FB_WEB_TEST(NSString *test1, NSNumber *test2, T t);

/**
 *  首页——》轮播图
 */
void FB_WEB_BANNER(NSString *method,  T t);



// 获取消息列表
//void FB_WEB_MESSAGE_DO(NSString *method,NSString *userId,NSString *tokenCode,  T t);
void FB_WEB_MESSAGE_DO(NSString *method,NSString *userId,NSString *tokenCode, int pageNo, int pageSize, T t);

// 登录接口
void FB_WEB_GET_LOGIN(NSString *method ,NSString *userName,NSString * password, T t);


// 获取用户信息
void FB_WEB_GET_doFindMyInfoById(NSString *method ,NSString *userId,NSString * tokenCode, T t);

// 删除消息列表
void FB_WEB_GET_delMessage(NSString *method ,NSString *id,NSString *userId,NSString * tokenCode, T t);


// 首页数据
void FB_WEB_GET_doFindIndexInfo(NSString *method,NSString *userId,NSString * tokenCode, T t);


// 详情里面的数据
void FB_WEB_GET_doFindLessonInfoById(NSString *method,NSString *lessonId,NSString *userId,NSString * tokenCode, T t);


// 详情里面的右上角(选课 退课按钮)数据
void FB_WEB_GET_selectLesson_OR_backLesson(NSString *method,NSString *lessonId,NSString *userId,NSString * tokenCode, T t);

// 课程详情里面 的请求
void FB_WEB_GET_APP_doFindLessonResourcesByLessonId(NSString *method ,NSString *lessonId,int pageNo ,int pageSize,NSString * userId,NSString * tokenCode, T t);

// 课程中心接口 第一个接口 不传id
void FB_WEB_GET_APP_getKnowledgeList(NSString *method ,NSString * userId,NSString * tokenCode, T t);

// 课程中心接口 第二个接口 传id
void FB_WEB_GET_APP_ID_getKnowledgeList(NSString *method ,NSString * id,NSString * userId,NSString * tokenCode, T t);

//// 课程中心接口 第三个接口 传knowledgeId
void FB_WEB_GET_APP_LESSON_DO(NSString *method ,NSString *knowledgeId,int  pageNo,int  pageSize, T t);


//修改密码
void FB_WEB_GET_APP_doUpdatePassword(NSString *method ,NSString *regname,NSString *orgPassword,NSString *newPassword,NSString * userId,NSString * tokenCode, T t);








