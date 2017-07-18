//
//  HBLoginViewController.m
//  HaoBan
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "HBLoginViewController.h"
#import "LCUserInfoModel.h"
#import "HBUserToolkit.h"

@interface HBLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *bgImageView;

// logo图标
@property (nonatomic, weak) UIImageView *iconView;


@property (nonatomic, strong) UITextField * actTextField;
@property (nonatomic, strong) UITextField * pwdTextField;

// 登录按钮
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, weak)UIScrollView *phoneLoginScrollView;

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic,strong) LCUserInfoModel *userDetailsInfoModel;

@end

@implementation HBLoginViewController


// 背景大图
- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
    }
    return _bgImageView;
}


- (UITextField *)actTextField {
    if (_actTextField == nil) {
        UIImage *image = KS_IMAGE(@"111icon1@2x.png");
        //        image = [image imageZoomWithSize:CGSizeMake(image.size.width / 4, image.size.height / 4)];
        UIView * v = [UIView new];
        v.frame = CGRectMake(0, 0, 50, 44);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.y = 12.5f;
        imageView.x = 12.5f;
        imageView.width = 16;
        imageView.height = 16;
        [v addSubview:imageView];
        
        _actTextField = [UITextField new];
        _actTextField.font          = KS_FONT(16);
        _actTextField.placeholder   = @"账号";
        _actTextField.textColor     = RGB(131, 250, 239);
        _actTextField.returnKeyType = UIReturnKeyDone;
        _actTextField.leftView      = v;
        _actTextField.leftViewMode  = UITextFieldViewModeAlways;
        _actTextField.delegate      = self;
        _actTextField.tag           = 101;
        _actTextField.borderWidth   = 1;
        _actTextField.radius        = 22;
        _actTextField.borderColor   = [UIColor lightGrayColor];
    }
    return _actTextField;
}

- (UITextField *)pwdTextField {
    if (_pwdTextField == nil) {
        UIImage *image = KS_IMAGE(@"111icon2@2x.png");
        //        image = [image imageZoomWithSize:CGSizeMake(image.size.width / 4, image.size.height / 4)];
        UIView * v = [UIView new];
        v.frame = CGRectMake(0, 0, 50, 44);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.y = 12.5f;
        imageView.x = 12.5f;
        imageView.width = 18;
        imageView.height = 18;
        [v addSubview:imageView];
        _pwdTextField = [UITextField new];
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.font          = KS_FONT(16);
        _pwdTextField.placeholder   = @"密码";
        _pwdTextField.textColor     = RGB(131, 250, 239);
        _pwdTextField.returnKeyType = UIReturnKeyDone;
        _pwdTextField.leftView      = v;
        _pwdTextField.leftViewMode  = UITextFieldViewModeAlways;
        _pwdTextField.delegate      = self;
        _pwdTextField.tag           = 101;
        _pwdTextField.borderWidth   = 1;
        _pwdTextField.radius        = 22;
        _pwdTextField.borderColor   = [UIColor lightGrayColor];
    }
    return _pwdTextField;
}

// 登录按钮
- (UIButton *)submitButton {
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setBackgroundImage:[UIImage imageNamed:@"111登录@2x.png"] forState:UIControlStateNormal];
        //        [_submitButton setTitle:@"登  录" forState:UIControlStateNormal];
        [_submitButton setTitleColor:RGB(98, 188, 181) forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(signInButtonHandler:)];
    }
    return _submitButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [KS_NOTIFY addObserver:self selector:@selector(keyboardWillShowHandler:) name:UIKeyboardWillShowNotification object:nil];
    [KS_NOTIFY addObserver:self selector:@selector(keyboardWillHideHandler:) name:UIKeyboardWillHideNotification object:nil];
    
}


#pragma mark  -  设置子控件
- (void)setupView
{
   
    KS_WS(ws);
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    //创建scrollView
    UIScrollView *phoneLoginScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:phoneLoginScrollView];
    self.phoneLoginScrollView = phoneLoginScrollView;
    [phoneLoginScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTap:)];
//    [phoneLoginScrollView addGestureRecognizer:tap];
    
    // 背景view
    UIView *bgView = [[UIView alloc] init];
    self.bgView = bgView;
    bgView.backgroundColor = RGB(246, 246, 246);
    [phoneLoginScrollView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    iconView.image = [UIImage imageNamed:@"11矢量智能对象@2x.png"];
    [bgView addSubview:iconView];
    
    [bgView addSubview:self.actTextField];
    [bgView addSubview:self.pwdTextField];
    [bgView addSubview:self.submitButton];
    
    
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_top).offset(XT(169));
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.width.mas_equalTo(XT(206));
        make.height.mas_equalTo(XT(240));
    }];
    
    
    [self.actTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.mas_equalTo(KSFrameValue(240.0f));
        make.left.equalTo(bgView).offset(20);
        make.right.equalTo(bgView).offset(-20);
        //        make.width.mas_equalTo(248);
        make.height.mas_equalTo(44.0f);
    }];
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(self.actTextField.mas_bottom).offset(15);
        make.left.equalTo(bgView).offset(20);
        make.right.equalTo(bgView).offset(-20);
        make.height.mas_equalTo(44.0f);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(15);
        //        make.size.mas_equalTo(CGSizeMake(248, 52.4));
        make.left.equalTo(bgView).offset(20);
        make.right.equalTo(bgView).offset(-20);
        make.height.mas_equalTo(45);
        
        make.centerX.equalTo(bgView);
    }];
    



}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置子控件
    [self setupView];
    
    
}

- (void)signInButtonHandler:(id)sender
{
    [self.view endEditing:YES];
    
    if ([NSString isNullOrEmpty:self.actTextField.text] || [NSString isNullOrEmpty: self.pwdTextField.text]) {
        KS_ALERT_1(@"用户名与密码不能为空");
        return;
    }
    
    [self.hud showAnimated:YES];
    
    
    FB_WEB_GET_LOGIN(@"doLogin", self.actTextField.text, self.pwdTextField.text, ^(id res, NSError *error) {
        NSLog(@"%@", res);
        
        if (error) {
            
            [self.hud hideAnimated:YES];
            if (error) {
                
                DLog(@"error = %@",error);
                
                
                KS_ALERT_1(error.description);
            } else {
                KS_ALERT_1([res getStringValue:@"msg"]);
            }
        } else {
           
            [self.hud hideAnimated:YES];

            DLog(@"%@",res);
            
          

            // 获取用户信息
            FB_WEB_GET_doFindMyInfoById(@"doFindMyInfoById", res[@"userId"], res[@"tokenCode"], ^(id responseObject, NSError *error) {
            
                DLog(@"responseObject= %@",responseObject);

                DLog(@"error = %@",error);
                
                if ([responseObject[@"status"]isEqualToString:@"fail"]) {
                    [[HBUserToolkit shared]signOut];
                    [self  showToast:responseObject[@"msg"] callback:nil];
                    
                    return ;
                }
                
               LCUserInfoModel *userDetailsInfoModel = [LCUserInfoModel mj_objectWithKeyValues:responseObject];
               self.userDetailsInfoModel = userDetailsInfoModel;
               DLog(@"userInfoModel= %@",userDetailsInfoModel.userName);
 
                [[HBUserToolkit shared]saveUserInfoUserId:res[@"userId"]];//保存userId
                [[HBUserToolkit shared]saveUserInfoTokenCode:res[@"tokenCode"]];//保存tokenCode
                
                // 保存到偏好设置里面
                [[HBUserToolkit shared]signIn:userDetailsInfoModel];//保存信息
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            });
            

        }
        
        
    });
    
}




- (void)scrollViewTap:(UITapGestureRecognizer *)tap{
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}
/**
 *  点击屏幕退出键盘
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/**
 *  键盘的显示 \ 隐藏
 */
- (void)keyboardWillShowHandler:(NSNotification *)notification
{
    NSDictionary * userInfo = notification.userInfo;
    CGRect frameEndUserInfo = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat cure = [userInfo[UIKeyboardAnimationCurveUserInfoKey] floatValue];
    CGFloat ty = frameEndUserInfo.origin.y-frameEndUserInfo.origin.y+70;
    
    if (self.bgView.y != ty) {
        [UIView animateWithDuration:duration animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:cure];
            self.bgView.y = -ty;
        }];
    }
}

- (void)keyboardWillHideHandler:(NSNotification *)notification
{
    
    NSDictionary * userInfo = notification.userInfo;
    CGRect frameEndUserInfo = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat cure = [userInfo[UIKeyboardAnimationCurveUserInfoKey] floatValue];
    CGFloat ty = frameEndUserInfo.origin.y - frameEndUserInfo.origin.y;
    
    if (self.bgView.y != ty) {
        [UIView animateWithDuration:duration animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:cure];
            
            self.bgView.y = -ty;
            // self.frame = toFrame;
        }];
    }
}

- (void)dealloc
{
    [self.view endEditing:YES];
    [self.actTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
    
    [KS_NOTIFY removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [KS_NOTIFY removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
// 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
