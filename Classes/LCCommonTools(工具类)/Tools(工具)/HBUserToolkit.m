//
//  HBLocalUserToolkit.m
//  HaoBan
//
//  Created by bing.hao on 2016/11/8.
//   © 2016年 tsingda. All rights reserved.
//

#import "HBUserToolkit.h"

@implementation HBUserToolkit

@synthesize isLogin;

+ (instancetype)shared {
    static id __staticObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __staticObject = [[self alloc] init];
    });
    return __staticObject;
}

- (LCUserInfoModel *)userDetailsInfoModel
{
    if (!_userDetailsInfoModel) {
        _userDetailsInfoModel = [[LCUserInfoModel alloc]init];
    }
    return _userDetailsInfoModel;
    
}


- (void)signIn:(id)userInfo {
    isLogin = YES;
    
    if (userInfo) {
        [self saveChangeWithUserInfo:userInfo];
    }
}

- (void)signOut {
   
    [self clearUserInfoData];

}

- (void)saveChangeWithUserInfo:(id)userInfo {
//    [userInfo mj_JSONData];

    // 加密
    isLogin = YES;
    LCUserInfoModel *userInfoModel = (LCUserInfoModel *)userInfo;
    DLog(@"userName22222 = %@",userInfoModel.userName);
    
    // 在这里保存到偏好设置
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:userInfoModel.userName forKey:@"userName"];
    [def setObject:userInfoModel.userTgroup forKey:@"userTgroup"];
    [def setObject:userInfoModel.userStation forKey:@"userStation"];
    [def setObject:userInfoModel.userPhoto forKey:@"userPhoto"];
    [def setObject:userInfoModel.ranking forKey:@"ranking"];
    [def setObject:userInfoModel.integral forKey:@"integral"];

        
    [def setBool:self.isLogin forKey:@"isLogin"];
    [def synchronize];

}



- (void)clearUserInfoData{
    self.userDetailsInfoModel = nil;
    isLogin = NO;
    
    NSUserDefaults *def   = [NSUserDefaults standardUserDefaults];
    [def setObject:NULL forKey:@"userName"];
    [def setObject:NULL forKey:@"userTgroup"];
    [def setObject:NULL forKey:@"userStation"];
    [def setObject:NULL forKey:@"userPhoto"];
    [def setObject:NULL forKey:@"ranking"];
    [def setObject:NULL forKey:@"integral"];

    [def setObject:NULL forKey:@"tokenCode"];
    [def setObject:NULL forKey:@"userId"];
    
    
    [def setBool:NO     forKey:@"isLogin"];
    [def synchronize];
}


/**
 保存用户信息
 */
- (void)getUserInfo
{
    NSUserDefaults *def   = [NSUserDefaults standardUserDefaults];

    self.userDetailsInfoModel.userName = [def objectForKey:@"userName"];
    self.userDetailsInfoModel.userTgroup = [def objectForKey:@"userTgroup"];
    self.userDetailsInfoModel.userStation = [def objectForKey:@"userStation"];
    self.userDetailsInfoModel.userPhoto = [def objectForKey:@"userPhoto"];
    self.userDetailsInfoModel.ranking = [def objectForKey:@"ranking"];
    self.userDetailsInfoModel.integral = [def objectForKey:@"integral"];

    self.tokenCode = [def objectForKey:@"tokenCode"];
    self.userId = [def objectForKey:@"userId"];

    isLogin = [def boolForKey:@"isLogin"];
    [def synchronize];

}
- (void)saveUserInfoTokenCode:(NSString *)tokenCode
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:tokenCode  forKey:@"tokenCode"];
    [def synchronize];

}
- (void)saveUserInfoUserId:(NSString *)userId
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:userId  forKey:@"userId"];
    [def synchronize];

}

+ (NSString *)getUserID
{
    HBUserToolkit *toolk = TOOLK;
    [toolk getUserInfo];
    return toolk.userId;
}

+ (NSString *)getUserToken
{
    HBUserToolkit *toolk = TOOLK;
    [toolk getUserInfo];
    return toolk.tokenCode;
}
@end
