//
//  FBWebAPI.m
//  FamilyBaby
//
//  Created by super on 16/8/30.
//  Copyright © 2016年 super. All rights reserved.
//
//

#import "FBWebAPI.h"

/* 环境配置 */
#ifndef Configure_Environment
#define Configure_Environment 1

/*********************stg环境*********************/
#if Configure_Environment== 1
//#define kFB_BASE_URL @"http://yunying.aotimes.com/"
//#define kFB_BASE_URL @"http://www.training-faw-mazda.com/app/"

#endif

#endif

@implementation FBWebAPI

@synthesize baseURL = _baseURL;

- (NSURL *)baseURL {
    if (_baseURL == nil) {
        _baseURL = [NSURL URLWithString:kFB_BASE_URL];
    }
    return _baseURL;
}

@end

/**
 *  这是一个演示API
 *
 *  @param test1 test1 description
 *  @param test2 test2 description
 *  @param t     回调方法
 */
void FB_WEB_TEST(NSString *test1, NSNumber *test2, T t) {
    
    //接口必要参数判断是否为nil
    NSCParameterAssert(test1);
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    //接口非必要参数判断是否需要传递
    if (test2) {
        [params setObject:test2 forKey:@"test2"];
    }
    
    [[FBWebAPI shared] POST:@"/test/test" parameters:params completionHandler:t];
}


// 首页轮播图
void FB_WEB_BANNER(NSString *method,  T t) {
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    //接口非必要参数判断是否需要传递
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    
    
    [[FBWebAPI shared] POST:@"/app/index.do" parameters:params completionHandler:t];
    
}



// 首页右上角 消息
void FB_WEB_MESSAGE_DO(NSString *method,NSString *userId,NSString *tokenCode, int pageNo, int pageSize, T t)
{
    
    NSMutableDictionary *params = [NSMutableDictionary new];
   
    //接口非必要参数判断是否需要传递
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    if (userId) {
        [params setObject:userId forKey:@"userId"];
    }
    
    if (tokenCode) {
        [params setObject:tokenCode forKey:@"tokenCode"];
    }
    if (pageNo) {
        [params setObject:@(pageNo) forKey:@"pageNo"];
    }
    if (pageSize) {
        [params setObject:@(pageSize) forKey:@"pageSize"];
    }
    
    [[FBWebAPI shared] POST:@"/app/message.do" parameters:params completionHandler:t];


}

/**
  * 登录接口
  */
void FB_WEB_GET_LOGIN(NSString *method ,NSString *userName,NSString * password, T t)
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    if (userName) {
        [params setObject:userName forKey:@"userName"];
    }
    if (password) {
        [params setObject:password forKey:@"password"];
    }
    
    DLog(@"params = %@",params);
    
    [[FBWebAPI shared] GET:@"/app/login.do" parameters:params completionHandler:t];
    
}


// 获取用户信息
void FB_WEB_GET_doFindMyInfoById(NSString *method ,NSString *userId,NSString * tokenCode, T t)
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    //接口非必要参数判断是否需要传递
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    if (userId) {
        [params setObject:userId forKey:@"userId"];
    }
    
    if (tokenCode) {
        [params setObject:tokenCode forKey:@"tokenCode"];
    }
    
    
    [[FBWebAPI shared] GET:@"/app/login.do" parameters:params completionHandler:t];


}




void FB_WEB_GET_delMessage(NSString *method ,NSString *id,NSString *userId,NSString * tokenCode, T t)
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    //接口非必要参数判断是否需要传递
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    if (id) {
        [params setObject:id forKey:@"id"];
    }
    if (userId) {
        [params setObject:userId forKey:@"userId"];
    }

    
    if (tokenCode) {
        [params setObject:tokenCode forKey:@"tokenCode"];
    }
    
    
    [[FBWebAPI shared] GET:@"/app/message.do" parameters:params completionHandler:t];
    


}

// 首页数据
void FB_WEB_GET_doFindIndexInfo(NSString *method,NSString *userId,NSString * tokenCode, T t)
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    //接口非必要参数判断是否需要传递
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    if (userId) {
        [params setObject:userId forKey:@"userId"];
    }
    if (tokenCode) {
        [params setObject:tokenCode forKey:@"tokenCode"];
    }
    
    [[FBWebAPI shared] GET:@"/app/index.do" parameters:params completionHandler:t];


}

// 课程详情里面的数据
void FB_WEB_GET_doFindLessonInfoById(NSString *method,NSString *lessonId,NSString *userId,NSString * tokenCode, T t)
{

    NSMutableDictionary *params = [NSMutableDictionary new];
    
    //接口非必要参数判断是否需要传递
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    if (lessonId) {
        [params setObject:lessonId forKey:@"lessonId"];
    }
    if (userId) {
        [params setObject:userId forKey:@"userId"];
    }
    if (tokenCode) {
        [params setObject:tokenCode forKey:@"tokenCode"];
    }
    
    [[FBWebAPI shared] GET:@"/app/lesson.do" parameters:params completionHandler:t];


}


// 详情里面的右上角(选课 退课按钮)数据
void FB_WEB_GET_selectLesson_OR_backLesson(NSString *method,NSString *lessonId,NSString *userId,NSString * tokenCode, T t)
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    //接口非必要参数判断是否需要传递
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    if (lessonId) {
        [params setObject:lessonId forKey:@"lessonId"];
    }
    if (userId) {
        [params setObject:userId forKey:@"userId"];
    }
    if (tokenCode) {
        [params setObject:tokenCode forKey:@"tokenCode"];
    }
    
    [[FBWebAPI shared] GET:@"/app/lesson.do" parameters:params completionHandler:t];


}

// 课程详情里面 文档
void FB_WEB_GET_APP_doFindLessonResourcesByLessonId(NSString *method ,NSString *lessonId,int pageNo ,int pageSize,NSString * userId,NSString * tokenCode, T t)
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    if (lessonId) {
        [params setObject:lessonId forKey:@"lessonId"];
    }
    if (pageNo) {
        [params setObject:@(pageNo) forKey:@"pageNo"];
    }
    
    if (pageSize) {
        [params setObject:@(pageSize) forKey:@"pageSize"];
    }
    
    if (userId) {
        [params setObject:userId forKey:@"userId"];
    }
    if (tokenCode) {
        [params setObject:tokenCode forKey:@"tokenCode"];
    }
    
    [[FBWebAPI shared] GET:@"/app/lesson.do" parameters:params completionHandler:t];
    
}


// 课程中心接口 第一个接口 不传id
void FB_WEB_GET_APP_getKnowledgeList(NSString *method ,NSString * userId,NSString * tokenCode, T t)
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    
    if (userId) {
        [params setObject:userId forKey:@"userId"];
    }
    if (tokenCode) {
        [params setObject:tokenCode forKey:@"tokenCode"];
    }
    
    [[FBWebAPI shared] GET:@"/app/exam.do" parameters:params completionHandler:t];


}

// 课程中心接口 第一个接口 传id
void FB_WEB_GET_APP_ID_getKnowledgeList(NSString *method ,NSString * id,NSString * userId,NSString * tokenCode, T t)
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    if (id) {
        [params setObject:id forKey:@"id"];
    }
    if (userId) {
        [params setObject:userId forKey:@"userId"];
    }
    if (tokenCode) {
        [params setObject:tokenCode forKey:@"tokenCode"];
    }
    
    [[FBWebAPI shared] GET:@"/app/exam.do" parameters:params completionHandler:t];
    
    
}


void FB_WEB_GET_APP_LESSON_DO(NSString *method ,NSString *knowledgeId,int  pageNo,int  pageSize, T t)
{
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    if (knowledgeId) {
        [params setObject:knowledgeId forKey:@"knowledgeId"];
    }
    if (pageNo) {
        [params setObject:@(pageNo) forKey:@"pageNo"];
    }
    if (pageSize) {
        [params setObject:@(pageSize) forKey:@"pageSize"];
    }
    
    DLog(@"params = %@",params);
    
    [[FBWebAPI shared] GET:@"/app/lesson.do" parameters:params completionHandler:t];
    
    
}


//修改密码
void FB_WEB_GET_APP_doUpdatePassword(NSString *method ,NSString *regname,NSString *orgPassword,NSString *newPassword,NSString * userId,NSString * tokenCode, T t)
{

    NSMutableDictionary *params = [NSMutableDictionary new];
    if (method) {
        [params setObject:method forKey:@"method"];
    }
    if (regname) {
        [params setObject:regname forKey:@"regname"];
    }
    if (orgPassword) {
        [params setObject:orgPassword forKey:@"orgPassword"];
    }
    if (newPassword) {
        [params setObject:newPassword forKey:@"newPassword"];
    }
    
    if (userId) {
        [params setObject:userId forKey:@"userId"];
    }
    if (tokenCode) {
        [params setObject:tokenCode forKey:@"tokenCode"];
    }

    DLog(@"params = %@",params);
    
    [[FBWebAPI shared] POST:@"/app/login.do" parameters:params completionHandler:t];


}







