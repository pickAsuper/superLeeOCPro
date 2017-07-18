//
//  LCBrowserViewController.m
//  HaoBan
//
//  Created by admin on 2017/5/25.
//  Copyright © 2017年 tsingda. All rights reserved.
//

#import "LCBrowserViewController.h"
#import <WebKit/WebKit.h>
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
#import <AFNetworking/UIWebView+AFNetworking.h>

// 网络加载失败显示的控制器
#import "HBNetworkConnectionFailureView.h"

#import <CoreLocation/CoreLocation.h>
#define kWebViewTimeOut 60.0f


@interface LCBrowserViewController ()<
WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler,
HBNetworkConnectionFailureViewDelegate,
CLLocationManagerDelegate>

@property (nonatomic, strong) WKWebView *webView;

// 加载进度条
@property (nonatomic, strong) NJKWebViewProgressView *progressView;

@property (nonatomic, strong) HBNetworkConnectionFailureView *ncfView;


@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;   //返回按钮
@property (nonatomic, strong) UIBarButtonItem *closeBarButtonItem;  //关闭按钮
@property (nonatomic, strong) UIBarButtonItem *moreBarButtonItem;   //右侧按钮


@property (nonatomic, strong) CLLocationManager *locationManager;


/**
 返回按钮点击事件
 */
- (void)kswv_backBarButtonItemHandler;

/**
 关闭按钮点击事件
 */
- (void)kswv_closeBarButtonItemHandler;


/**
 更多按钮点击事件
 */
- (void)kswv_moreBarButtonItemHandler;


@end

@implementation LCBrowserViewController

#pragma mark - Get
- (HBNetworkConnectionFailureView *)ncfView {
    if (!_ncfView) {
        _ncfView = [HBNetworkConnectionFailureView new];
        _ncfView.delegate = self;
    }
    return _ncfView;
}

- (NJKWebViewProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[NJKWebViewProgressView alloc] init];
        _progressView.progressBarView.backgroundColor = CHEX(0x3ed536);
    }
    return _progressView;
}


- (WKWebView *)webView {
    if (!_webView) {
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        //        configuration.applicationNameForUserAgent = @"HaoBan 1.0";
        configuration.userContentController = userContentController;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
        //        WKUserContentController *userContentController = self.webView.configuration.userContentController;
           }
    return _webView;
}

- (UIBarButtonItem *)backBarButtonItem {
    if (_backBarButtonItem == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"fanhui@2x.png"];
        //        image = [image kswv_imageWithTintColor:[UIColor blueColor]];
        [button setImage:image forState:UIControlStateNormal];
        //        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [button setFrame:CGRectMake(0, 0, 22, 44)];
        
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _backBarButtonItem;
}

- (void)backButtonHandler:(id)sender {
    [self kswv_backBarButtonItemHandler];
}




- (UIBarButtonItem *)closeBarButtonItem {
    if (_closeBarButtonItem == nil) {
        _closeBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(kswv_closeBarButtonItemHandler)];
        _closeBarButtonItem.tintColor = [UIColor whiteColor];
    }
    return _closeBarButtonItem;
}

- (UIBarButtonItem *)moreBarButtonItem {
    
    if (_moreBarButtonItem == nil) {
        //        _moreBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
        //                                                            target:self
        //                                                            action:@selector(kswv_moreBarButtonItemHandler)];
        _moreBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享_01.png"] style:UIBarButtonItemStylePlain target:self action:@selector(kswv_moreBarButtonItemHandler)];
        _moreBarButtonItem.tintColor = [UIColor whiteColor];
    }
    return _moreBarButtonItem;
}
/**
 更多按钮点击事件
 */
- (void)kswv_moreBarButtonItemHandler {


}


/**
 返回按钮点击事件
 */
- (void)kswv_backBarButtonItemHandler {
    if (self.backBarButtonItem == nil) {
        return;
    }
//    if ([self.basePath isEqualToString:self.webView.URL.path]) {
//        return [self kswv_closeBarButtonItemHandler];
//    }
    //判断是否有上一层H5页面
    if ([self.webView canGoBack]) {
        //如果有则返回
        [self.webView goBack];
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮
        self.navigationItem.leftBarButtonItems = @[self.backBarButtonItem, self.closeBarButtonItem];
    } else {
        [self kswv_closeBarButtonItemHandler];
    }
}

/**
 关闭按钮点击事件
 */
- (void)kswv_closeBarButtonItemHandler {
    [self.navigationController popViewControllerAnimated:YES];
}


- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        // 设置电池供电状态最高精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1000.0f;
    }
    return _locationManager;
}


- (instancetype)initWithURL:(NSURL *)URL {
    self = [super init];
    if (self) {
        self.URL = URL;
    }
    return self;
}

#pragma mark - Init
+ (instancetype)createInstanceWithURL:(NSURL *)URL {
    return [[LCBrowserViewController alloc] initWithURL:URL];
}

- (NSURLRequest *)createURLRequest {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kWebViewTimeOut];
    return request;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];
   
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    [self.webView loadRequest:[self createURLRequest]];
    
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        float progress = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        if (progress >= self.progressView.progress) {
            [self.progressView setProgress:progress animated:YES];
        } else {
            [self.progressView setProgress:progress animated:NO];
        }
    }
}

- (void)updateFrameOfProgressView {
    CGFloat progressBarHeight = 2.0f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView.frame = barFrame;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSLog(@"%@", navigationResponse.response);
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//准备加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
//    self.showSharedMenus = YES;
    self.navigationItem.rightBarButtonItem = nil;
    
    //显示加载状态
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if (self.navigationController && self.progressView.superview != self.navigationController.navigationBar) {
        [self updateFrameOfProgressView];
        [self.navigationController.navigationBar addSubview:self.progressView];
    }
    //重置加载进度
    [self.progressView setProgress:0];
    [self.progressView setProgress:0.05f animated:YES];
}


//开始加载
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    //KVO监听加载进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}



//完成加载
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
//    self.webView.scrollView.header.state = KSRefreshViewStateDefault;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.title = webView.title;
    @try {
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    } @catch (NSException * exception) {
        
    }
    
    NSString *script = @"try { tsingda.event.emit('TsingdaJSBridgeEventOnReady'); } catch(e) {}";
    [self.webView evaluateJavaScript:script completionHandler:^(id _Nullable res, NSError * _Nullable error) {
        
    }];
    //    [self.webView evaluateJavaScript:@"document.getElementsByTagName('html')[0].innerHTML"
    //                   completionHandler:^(id res, NSError *error) {
    //        NSLog(@"%@", res);
    //    }];
}



- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.title = webView.title;
    @try {
        [self.progressView setProgress:0];
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    } @catch (NSException *exception) {
        
    }
    [self.view addSubview:self.ncfView];
    [self.ncfView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

// 加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.title = webView.title;
    @try {
        [self.progressView setProgress:0];
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    } @catch (NSException *exception) {
        
    }
    [self.view addSubview:self.ncfView];
    [self.ncfView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}



#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:NULL];
        completionHandler();
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:NULL];
        completionHandler(NO);
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:NULL];
        completionHandler(YES);
    }];
    [alert addAction:okCancel];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)dealloc {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.progressView removeFromSuperview];
    [self setProgressView:nil];
    @try {
        [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    } @catch (NSException *exception) {
    }
    [_webView stopLoading];
    [_webView removeFromSuperview];
    _webView = nil;
}







@end
