//
//  LCChangePasswordViewController.m
//  HaoBan
//
//  Created by admin on 2017/6/30.
//  Copyright © 2017年 tsingda. All rights reserved.
//   修改密码


#import "LCChangePasswordViewController.h"

@interface LCChangePasswordViewController ()

// 账号Label
@property (nonatomic, strong) UILabel *renameLB;
// 旧密码Label
@property (nonatomic, strong) UILabel *oldLB;
// 新  密  码Label
@property (nonatomic, strong) UILabel *pwdLB;

// 重复密码
@property (nonatomic, strong) UILabel *retryLB;

// 账号输入框
@property (nonatomic, strong) UITextField *renameTF;
// 旧密码输入框
@property (nonatomic, strong) UITextField *oldTF;
// 新密码输入框输入框
@property (nonatomic, strong) UITextField *pwdTF;

// 重复密码输入框
@property (nonatomic, strong) UITextField *retryTF;


@property (nonatomic, strong) UIButton *button;


@end

@implementation LCChangePasswordViewController


- (UILabel *)renameLB {
    if (_renameLB == nil) {
        _renameLB = [UILabel new];
        _renameLB.textColor = RGB(169, 169, 169);
        _renameLB.font = KS_FONT(16);
        _renameLB.text = @"账        号 :";
    }
    return _renameLB;
}

- (UILabel *)oldLB {
    if (_oldLB == nil) {
        _oldLB = [UILabel new];
        _oldLB.textColor = RGB(169, 169, 169);
        _oldLB.font = KS_FONT(16);
        _oldLB.text = @"旧  密  码 :";
    }
    return _oldLB;
}

- (UILabel *)retryLB {
    if (_retryLB == nil) {
        _retryLB = [UILabel new];
        _retryLB.textColor = RGB(169, 169, 169);
        _retryLB.font = KS_FONT(16);
        _retryLB.text = @"重复密码 :";
    }
    return _retryLB;
}

- (UILabel *)pwdLB {
    if (_pwdLB == nil) {
        _pwdLB = [UILabel new];
        _pwdLB.textColor = RGB(169, 169, 169);
        _pwdLB.font = KS_FONT(16);
        _pwdLB.text = @"新  密  码 :";
    }
    return _pwdLB;
}

- (UITextField *)renameTF {
    if (_renameTF == nil) {
        _renameTF = [UITextField new];
        //        _renameTF.secureTextEntry = YES;
        _renameTF.leftViewMode = UITextFieldViewModeAlways;
        _renameTF.borderWidth = 1;
        _renameTF.borderColor = RGB(229, 229, 229);
        _renameTF.radius = 5;
        _renameTF.leftView = [UIView new];
        _renameTF.leftView.width = 5;
    }
    return _renameTF;
}

- (UITextField *)oldTF {
    if (_oldTF == nil) {
        _oldTF = [UITextField new];
        _oldTF.secureTextEntry = YES;
        _oldTF.leftViewMode = UITextFieldViewModeAlways;
        _oldTF.borderWidth = 1;
        _oldTF.borderColor = RGB(229, 229, 229);
        _oldTF.radius = 5;
        _oldTF.leftView = [UIView new];
        _oldTF.leftView.width = 5;
    }
    return _oldTF;
}

- (UITextField *)pwdTF {
    if (_pwdTF == nil) {
        _pwdTF = [UITextField new];
        _pwdTF.secureTextEntry = YES;
        _pwdTF.leftViewMode = UITextFieldViewModeAlways;
        _pwdTF.borderWidth = 1;
        _pwdTF.borderColor = RGB(229, 229, 229);
        _pwdTF.radius = 5;
        _pwdTF.leftView = [UIView new];
        _pwdTF.leftView.width = 5;
    }
    return _pwdTF;
}

- (UITextField *)retryTF {
    if (_retryTF == nil) {
        _retryTF = [UITextField new];
        _retryTF.secureTextEntry = YES;
        _retryTF.leftViewMode = UITextFieldViewModeAlways;
        _retryTF.borderWidth = 1;
        _retryTF.borderColor = RGB(229, 229, 229);
        _retryTF.radius = 5;
        _retryTF.leftView = [UIView new];
        _retryTF.leftView.width = 5;
    }
    return _retryTF;
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //        [_button setBackgroundImage:KS_IMAGE(@"btn_signin.png") forState:UIControlStateNormal];
        [_button setBackgroundColor:RGB(253, 147, 55)];
        [_button setTitle:@"提交" forState:UIControlStateNormal];
        [_button.titleLabel setFont:KS_FONT_B(16)];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(submiButtonHandler:)];
    }
    return _button;
}

-(void)setupUI
{

    [self.view addSubview:self.renameLB];
    [self.view addSubview:self.oldLB];
    [self.view addSubview:self.pwdLB];
    [self.view addSubview:self.retryLB];
    [self.view addSubview:self.renameTF];
    [self.view addSubview:self.oldTF];
    [self.view addSubview:self.pwdTF];
    [self.view addSubview:self.retryTF];
    [self.view addSubview:self.button];
    
    KS_WS(ws);
    
    [self.renameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).offset(30);
        make.left.equalTo(ws.view).offset(25);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.renameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view).offset(-25);
        make.left.equalTo(ws.renameLB.mas_right);
        make.centerY.equalTo(ws.renameLB);
        make.height.mas_equalTo(@44);
    }];
    [self.oldLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view).offset(25);
        make.top.equalTo(self.renameTF.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.oldTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view).offset(-25);
        make.left.equalTo(ws.oldLB.mas_right);
        make.centerY.equalTo(ws.oldLB);
        make.height.mas_equalTo(@44);
    }];
    [self.pwdLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view).offset(25);
        make.top.equalTo(self.oldTF.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view).offset(-25);
        make.left.equalTo(ws.pwdLB.mas_right);
        make.centerY.equalTo(ws.pwdLB);
        make.height.mas_equalTo(@44);
        
    }];
    [self.retryLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view).offset(25);
        make.top.equalTo(self.pwdTF.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.retryTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view).offset(-25);
        make.left.equalTo(ws.retryLB.mas_right);
        make.centerY.equalTo(ws.retryLB);
        make.height.mas_equalTo(@44);
        
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.retryTF.mas_bottom).offset(30);
        make.left.equalTo(ws.view).offset(20);
        make.right.equalTo(ws.view).offset(-20);
        make.height.mas_equalTo(@44);
    }];



}





- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"修改密码";
    
    [self setupUI];
    

}

- (void)submiButtonHandler:(id)sender {

    if ([NSString isNullOrEmpty:self.renameTF.text]) {
        KS_ALERT_AFTER(@"用户名不能为空", 1.0f);
        return;
    }
    if ([NSString isNullOrEmpty:self.oldTF.text] || [NSString isNullOrEmpty:self.pwdTF.text]) {
//        KS_ALERT_AFTER(LSTR(@"s30"), 1.0f);
                KS_ALERT_AFTER(@"密码不能为空", 1.0f);

        
    }
    if (self.pwdTF.text.length < 6) {
//        KS_ALERT_AFTER(LSTR(@"s31"), 1.0f);
    
        KS_ALERT_AFTER(@"新密码须为6-16位", 1.0f);

        
        return;
    }
    if ([self.pwdTF.text isEqualToString:self.oldTF.text]) {
//        KS_ALERT_AFTER(LSTR(@"s32"), 1.0f);  //
        
        KS_ALERT_AFTER(@"新密码不可以与旧密码一致", 1.0f);
        return;
    }
    if (![self.retryTF.text isEqualToString:self.pwdTF.text]) {
//        KS_ALERT_AFTER(LSTR(@"s33"), 1.0f);

        KS_ALERT_AFTER(@"重复密码与新密码不一致", 1.0f);

        return;
    }
    
    FB_WEB_GET_APP_doUpdatePassword(@"doUpdatePassword", self.renameTF.text, self.oldTF.text, self.pwdTF.text,[HBUserToolkit getUserID],[HBUserToolkit getUserToken], ^(id responseObject, NSError *error) {
    
        DLog(@"error 2323 = %@",error);
        
        
        if ([[responseObject getStringValue:@"status"] isEqualToString:@"success"]) {
//            self.hud.labelText = @"修改完成";
            
            [MBProgressHUD showSuccess:@"修改完成"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
            
        } else {
            KS_ALERT_AFTER([responseObject getStringValue:@"msg"], 1.0f);
        }
        
        
    });
    

}


@end
