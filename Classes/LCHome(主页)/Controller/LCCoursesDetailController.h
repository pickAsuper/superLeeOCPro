//
//  LCCoursesDetailController.h
//  HaoBan
//
//  Created by admin on 2017/6/28.
//  Copyright © 2017年 tsingda. All rights reserved.
//    课程详情

#import "HBBaseViewController.h"
#import "LCLessonListModel.h"
#import "SPAllOpenLessonsList.h"

@interface LCCoursesDetailController : HBBaseViewController

// 从首页获取的模型
@property (nonatomic, strong)LCLessonListModel *model;

// 从课程中心传过来的模型
@property (nonatomic, strong) SPAllOpenLessonsList *listModel;


@end
