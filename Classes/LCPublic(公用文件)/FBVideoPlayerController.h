//
//  FBVideoPlayerController.h
//  FamilyBaby
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "HBBaseViewController.h"
#import "WMPlayer.h"

@interface FBVideoPlayerController : HBBaseViewController

//@property (nonatomic ,strong)FBWonderfulVideoListModel * videoListModel;
/**
 *  视频路径
 */
@property (nonatomic ,copy)NSString * VideoPath;

@property (nonatomic ,assign) BOOL isFullScreen;


@end
