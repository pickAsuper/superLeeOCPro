//
//  HBLocalUserToolkit.h
//  HaoBan
//
//  Created by bing.hao on 2016/11/8.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCUserInfoModel.h"


#define HBUserToolkitSignInNotification @"HBUserToolkitSignInNotification"
#define HBUserToolkitSignOutNotification @"HBUserToolkitSignOutNotification"

/**
 本地登录用户操作工具
 */
@interface HBUserToolkit : NSObject


/**
 当前用户信息
 */
@property (nonatomic, strong, readonly) id current;
@property (nonatomic, assign, readonly) BOOL isLogin;

@property (nonatomic, copy)NSString  *tokenCode;
@property (nonatomic, copy)NSString  *userId;


@property (nonatomic, strong)LCUserInfoModel *userDetailsInfoModel;


+ (instancetype)shared;

/**
 用户登录
 */
- (void)signIn:(id)userInfo;

/**
 退出登录
 */
- (void)signOut;


/** 
 保存用户数据
 */
- (void)saveChangeWithUserInfo:(id)userInfo;


/**
 保存用户信息
 */
- (void)getUserInfo;



- (void)saveUserInfoTokenCode:(NSString *)tokenCode;
- (void)saveUserInfoUserId:(NSString *)userId;

+ (NSString *)getUserID;
+ (NSString *)getUserToken;

@end
