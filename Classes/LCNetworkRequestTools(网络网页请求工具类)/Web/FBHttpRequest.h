//
//  FBHttpRequest.h
//  FamilyBaby
//
//  Created by super on 16/8/30.
//  Copyright © 2016年 super. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <KSToolkit/KSMacros.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^FB_HTTP_REQUEST_SUCCESS)(NSURLSessionDataTask *task, id responseObject);
typedef void (^FB_HTTP_REQUEST_FAILURE)(NSURLSessionDataTask *task, NSError *error);

typedef void (^T)(id responseObject, NSError *error);

@interface FBHttpRequest : NSObject

/**
 * 会话配置对象
 */
@property (nonatomic, strong, readonly) NSURLSessionConfiguration *configuration;

/**
 *  会话管理对象
 */
@property (nonatomic, strong, readonly) AFURLSessionManager *session;

/**
 *  HOST
 */
@property (nonatomic, strong, readonly) NSURL *baseURL;

/**
 *  是否打印返回结果
 */
@property (nonatomic, assign) BOOL responseObjectLog;

/**
 *  是否打印错误日志
 */
@property (nonatomic, assign) BOOL errorLog;

/**
 *  共享实例(单例)
 *
 *  @return FBHttpRequest
 */
+ (instancetype)shared;

/**
 *  GET
 *
 *  @param URLString 相对路径
 *  @param params    请求参数
 *  @param success   完成回调方法
 *  @param failure   失败回调方法
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)params
            completionHandler:(T)completionHandler;

/**
 *  POST
 *
 *  @param URLString 相对路径
 *  @param params    请求参数
 *  @param success   完成回调方法
 *  @param failure   失败回调方法
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)params
             completionHandler:(T)completionHandler;



/**
 *  上传图片
 *
 *  @param imageArr   存放图片的数组，里面对象是 UIImage
 *  @param comletionHandler
 *
 *  @return
 */

- (NSURLSessionUploadTask *)uploadImageArray:(NSArray *)imageArr completionHander:(T)comletionHandler;



@end
