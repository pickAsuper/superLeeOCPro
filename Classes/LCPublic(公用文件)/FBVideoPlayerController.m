//
//  FBVideoPlayerController.m
//  FamilyBaby
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "FBVideoPlayerController.h"
//#import "FBWonderfulVideoListModel.h"
#import "WMPlayer.h"

//#import <MediaPlayer/MediaPlayer.h>

@interface FBVideoPlayerController ()<WMPlayerDelegate>


@property (nonatomic ,strong)  NSMutableArray *videoDataSource;
@property (nonatomic ,strong)  NSIndexPath *currentIndexPath;

@property (nonatomic ,copy)  NSString * VideoUrlStr;

//@property (nonatomic ,strong) FBWonderfulVideoListModel *videoModel ;

@property (nonatomic ,strong)  WMPlayer *wmPlayer;


//@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;


@end

@implementation FBVideoPlayerController

//- (MPMoviePlayerController *)moviePlayer
//{
//    if (!_moviePlayer) {
//        
//        NSURL * moviewUrl = [NSURL URLWithString:_VideoUrlStr];
//        NSURL *urlStra = [[NSBundle mainBundle]URLForResource:@"promo_full.mp4" withExtension:nil];
//
//        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:moviewUrl];
//        _moviePlayer.view.frame = self.view.bounds;
//        _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        _moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
//        [self.view addSubview:_moviePlayer.view];
//    }
//    return _moviePlayer;
//}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    [self setupVideoPlayer];

}

- (void)setupVideoPlayer
{
    
    if ([self.VideoPath hasSuffix:@".flv"]) {
//       [self showToast:@"不支持此格式的播放" callback:^{
//           [self dismissViewControllerAnimated:YES completion:nil];
//       }];
       return;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    _wmPlayer = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, KS_SCREEN_WIDTH, (KS_SCREEN_WIDTH)*(0.75))];
    _wmPlayer.delegate = self;

    _wmPlayer.URLString = self.VideoPath;
    
    _wmPlayer.fullScreenBtn.hidden = YES;
    _wmPlayer.titleLabel.text = self.title;
    _wmPlayer.closeBtn.hidden = NO;
    [self.view addSubview:_wmPlayer];
    [_wmPlayer play];
    
    [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    if (_wmPlayer==nil||_wmPlayer.superview==nil){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
         //   DLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
        //    DLog(@"第0个旋转方向---电池栏在上");
            if (_wmPlayer.isFullscreen) {
                // [self toNormal];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
         //   DLog(@"第2个旋转方向---电池栏在左");
            _wmPlayer.isFullscreen = YES;
            [self setNeedsStatusBarAppearanceUpdate];
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
          //  DLog(@"第1个旋转方向---电池栏在右");
            _wmPlayer.isFullscreen = YES;
            [self setNeedsStatusBarAppearanceUpdate];
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        default:
            break;
    }
}

- (void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation
{
    
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [_wmPlayer removeFromSuperview];
    _wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        _wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        _wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    _wmPlayer.frame = CGRectMake(0, 0, KS_SCREEN_WIDTH, KS_SCREEN_HEIGHT);
    _wmPlayer.playerLayer.frame =  CGRectMake(0,0, KS_SCREEN_HEIGHT,KS_SCREEN_WIDTH);
    
    [_wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(KS_SCREEN_WIDTH-40);
        make.width.mas_equalTo(KS_SCREEN_HEIGHT);
    }];
    [_wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(_wmPlayer).with.offset(0);
        make.width.mas_equalTo(KS_SCREEN_HEIGHT);
    }];
    [_wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_wmPlayer.topView).with.offset(5);
        make.height.mas_equalTo(30);
        make.top.equalTo(_wmPlayer.topView).with.offset(5);
        make.width.mas_equalTo(30);
    }];
    [_wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_wmPlayer.topView).with.offset(45);
        make.right.equalTo(_wmPlayer.topView).with.offset(-45);
        make.center.equalTo(_wmPlayer.topView);
        make.top.equalTo(_wmPlayer.topView).with.offset(0);
        
    }];
    [_wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KS_SCREEN_HEIGHT);
        make.center.mas_equalTo(CGPointMake(KS_SCREEN_WIDTH/2-36, -(KS_SCREEN_WIDTH/2)+36));
        make.height.equalTo(@30);
    }];
    [_wmPlayer.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(KS_SCREEN_WIDTH/2-37, -(KS_SCREEN_WIDTH/2-37)));
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:_wmPlayer];
    _wmPlayer.fullScreenBtn.selected = YES;
    [_wmPlayer bringSubviewToFront:_wmPlayer.bottomView];
    
}

///播放器事件
//点击播放暂停按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn
{
    
    
    
}
//点击关闭按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//单击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap
{
    
    
}
//双击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap
{
    
    
    
}

///播放状态
//播放失败的代理方法
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state
{
    
    
    
}
//准备播放的代理方法
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state
{
    
    
    
}
//播放完毕的代理方法
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer
{
    
    
    
    
}
//点击全屏按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn
{
    if (fullScreenBtn.isSelected) {
        //全屏显示
        _wmPlayer.isFullscreen = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
     
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - 释放
- (void)dealloc
{
    [self releaseWMPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)releaseWMPlayer
{
    [_wmPlayer.player.currentItem cancelPendingSeeks];
    [_wmPlayer.player.currentItem.asset cancelLoading];
    [_wmPlayer pause];
    [_wmPlayer removeFromSuperview];
    [_wmPlayer.playerLayer removeFromSuperlayer];
    [_wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    _wmPlayer.player = nil;
    _wmPlayer.currentItem = nil;
    // 释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [_wmPlayer.autoDismissTimer invalidate];
    _wmPlayer.autoDismissTimer = nil;
    
    
    _wmPlayer.playOrPauseBtn = nil;
    _wmPlayer.playerLayer = nil;
    _wmPlayer = nil;
}



@end
