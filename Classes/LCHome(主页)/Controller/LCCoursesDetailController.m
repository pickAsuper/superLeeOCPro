//
//  LCCoursesDetailController.m
//  HaoBan
//
//  Created by admin on 2017/6/28.
//  Copyright © 2017年 tsingda. All rights reserved.
//    课程详情

#import "LCCoursesDetailController.h"
#import "LCCourseModel.h"
#import "LCCourseListModel.h"
#import "LCSectionListCell.h"
#import "LCTopSectionListCell.h"
#import "LCZLiaoEntity.h"

#import "LCBrowserViewController.h"
#import "FBVideoPlayerController.h"

#import "WMPlayer.h"


@interface LCCoursesDetailController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
WMPlayerDelegate
>


@property (nonatomic,strong) UIButton * ConsumptionOrderBtn;

@property (nonatomic,strong) UIButton * coinOrderBtn;

@property (nonatomic,strong) UIButton * comeBtn;

@property (nonatomic,strong) UIScrollView * scrollerView;


@property (nonatomic,strong) UITableView * oneTableView;

@property (nonatomic,strong) UITableView * twoTableView;

@property (nonatomic,strong) UITableView * threeTableView;

@property (nonatomic, weak)UILabel * oneLabel;

@property (nonatomic, weak)UILabel * twoLabel;

@property (nonatomic, weak)UILabel * threeLabel;

// 课程详情头的model
@property (nonatomic,strong) LCCourseModel *CourseModel;

@property (nonatomic, weak) UIImageView *bgView;



@property (nonatomic, strong)NSMutableArray *coursesDetailListModelArray;

@property (nonatomic, strong)NSMutableArray *ziliaoArray;

// 第二个表的模型 和数组
//@property (nonatomic ,strong) SPCoursesDetailModel * detailModel;

@property (nonatomic, strong) UIButton *rightButton;

/** 视频播放器 */
@property (nonatomic, strong) WMPlayer  *wmPlayer;

@end

@implementation LCCoursesDetailController

- (NSMutableArray *)coursesDetailListModelArray
{
    if (!_coursesDetailListModelArray) {
        _coursesDetailListModelArray = [NSMutableArray array];
    }
    return _coursesDetailListModelArray;
    
}

- (NSMutableArray *)ziliaoArray{
    if (_ziliaoArray == nil) {
        _ziliaoArray = [NSMutableArray array];
    }
    return  _ziliaoArray;
}


- (WMPlayer *)wmPlayer
{
    if (!_wmPlayer) {
        self.wmPlayer = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 0, KS_SCREEN_WIDTH, 155.0f)];
        self.wmPlayer.delegate = self;
    }
    return _wmPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = self.model.lessonName?self.model.lessonName:self.listModel.lessonName;
    
    
    
    // 获取详情数据
    [self loadOneData];
    
    // 获取资料的数据
    [self loadZiLiaoData];
    
    [self setupUI];

    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self releaseWMPlayer];
}

- (void)dealloc {
    
    [self releaseWMPlayer];
    
}

// 获取详情的数据
- (void)loadOneData
{
   
    FB_WEB_GET_doFindLessonInfoById(@"doFindLessonInfoById", self.model.lessonId?self.model.lessonId:self.listModel.pid, [HBUserToolkit getUserID], [HBUserToolkit getUserToken], ^(id responseObject, NSError *error) {
    
        DLog(@"responseObject = %@",responseObject);
        
        DLog(@"error = %@",error);
        
        LCCourseModel *CourseModel=  [LCCourseModel mj_objectWithKeyValues:responseObject];
        self.CourseModel = CourseModel;
        
        // 设置顶部的背景图
//        [self.bgView sd_setImageWithURL:[NSURL URLWithString:!self.CourseModel.lessonImg?self.model.lessonImg:self.CourseModel.lessonImg]];
        
        [self.bgView sd_setImageWithURL:[NSURL URLWithString:self.model.lessonImg]];

        // 设置右上角按钮的文字
        NSString *selelctDateString = responseObject[@"SELECTDATE"];
        
        if ( ![selelctDateString isEqual:[NSNull null]]) {
            
            [self.rightButton setTitle:@"退课" forState:UIControlStateNormal];
            [self.rightButton setImage:[UIImage imageNamed:@"h选课icon@2x.png"] forState:UIControlStateNormal];
        }else{
            
            [self.rightButton setTitle:@"选课" forState:UIControlStateNormal];
            [self.rightButton setImage:[UIImage imageNamed:@"h未选icon@2x.png"] forState:UIControlStateNormal];
            
        }
        
       
        [self.coursesDetailListModelArray addObjectsFromArray:CourseModel.lessonHours];
        [self.oneTableView reloadData];
        
       
   });
    

}


// 获取资料的数据
- (void)loadZiLiaoData
{
  
    FB_WEB_GET_APP_doFindLessonResourcesByLessonId(@"doFindLessonResourcesByLessonId", self.model.lessonId?self.model.lessonId:self.listModel.pid, 1, 100, [HBUserToolkit getUserID], [HBUserToolkit getUserID], ^(id responseObject, NSError *error) {
        
        if (error) {
            [self showToast:error.localizedDescription callback:nil];
         
            return ;
        }else{
            
            DLog(@"loadZiLiaoData - responseObject%@",responseObject);
        
            NSMutableArray *ziliaoArray = [LCZLiaoEntity mj_objectArrayWithKeyValuesArray:responseObject[@"resourceList"]];
            
            [self.ziliaoArray addObjectsFromArray:ziliaoArray];
            
            // 展示在第三个表上的  刷新第三个表
            [self.threeTableView reloadData];
        
        }
    
    });

}

- (UIButton *)navigationBarRightButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0,  80, 44)];
    [button addTarget:self action:@selector(favButtonHandler:)];
    self.rightButton = button;

    return button;
}

- (void)favButtonHandler:(UIButton *)btn
{
    NSString *methodString = @"";
    if ([NSString isNullOrEmpty: self.CourseModel.SELECTDATE]) {
        methodString = @"selectLesson";
    }else{
        methodString = @"backLesson";
    }
    
     FB_WEB_GET_selectLesson_OR_backLesson(methodString, self.model.lessonId?self.model.lessonId:self.listModel.pid, [HBUserToolkit getUserID], [HBUserToolkit getUserToken], ^(id responseObject, NSError *error) {
        
         DLog(@"responseObject = %@",responseObject);
         
         DLog(@"error = %@",error);

         
         if ([NSString isNullOrEmpty:self.CourseModel.SELECTDATE]) {
             [self.CourseModel setSELECTDATE:@"tmp"];
             [self.rightButton setTitle:@"退课" forState:UIControlStateNormal];
             [self.rightButton setImage:[UIImage imageNamed:@"h选课icon@2x.png"] forState:UIControlStateNormal];
             MBProgressHUD *hud = [MBProgressHUD showMessage:@"已选课"];
             
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [hud hideAnimated:YES];
                 
                 
             });
             
//             KS_NOTIFY_POST2(@"XuanKeLe", (self.dataItem));
             
         } else {
             [self.CourseModel setSELECTDATE:nil];
             [self.rightButton setTitle:@"选课" forState:UIControlStateNormal];
             [self.rightButton setImage:[UIImage imageNamed:@"h未选icon@2x.png"] forState:UIControlStateNormal];
             
             MBProgressHUD *hud =  [MBProgressHUD showMessage:@"已退课"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [hud hideAnimated:YES];
                 
             });
             
//             KS_NOTIFY_POST2(@"TuiKeLe", (self.dataItem));
         }
     });
}

- (void) setupUI{
    
    CGFloat borderWidthW = 0.3;
    
    CGFloat w =  KS_SCREEN_WIDTH / 3;
    CGFloat h = XT(90);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KS_SCREEN_WIDTH, 200.0f)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KS_SCREEN_WIDTH, 160.0f)];
    UIImageView *playView = [UIImageView imageViewWithName:@"iconPlayButtonView.png"];
    self.bgView = bgView;
    DLog(@"%@",self.CourseModel.lessonImg);
    
//    [bgView sd_setImageWithURL:[NSURL URLWithString:self.CourseModel.lessonImg]];
    
    // 设置顶部的背景图
    [bgView sd_setImageWithURL:[NSURL URLWithString:self.model.lessonImg]];
    
    [bgView onClickEvent:^{
        
        if ([self.CourseModel.kjType integerValue] == 10) {
           
            LCBrowserViewController *pageVC  = [[LCBrowserViewController alloc] init];
            pageVC.URL = [NSURL URLWithString:self.CourseModel.onlineLessonUrl];
            [self.navigationController pushViewController:pageVC animated:YES];
            
            return ;
        }
        
        
        if ([self.CourseModel.kjType isEqualToString:@"4"]) {
            
            LCBrowserViewController *pageVC  = [[LCBrowserViewController alloc] init];
            LCCourseListModel *listModel = self.coursesDetailListModelArray[1];
            pageVC.URL = [NSURL URLWithString:listModel.ENTER_URL];
            [self.navigationController pushViewController:pageVC animated:YES];
            
            
        }else{
            
            // 先删除之前的播放器和播放内容 不然会崩溃
            
//            [self releaseWMPlayer];
            self.wmPlayer.backgroundColor = [UIColor whiteColor];
            self.wmPlayer.URLString       =  self.CourseModel.lessonVideoUrl;
            
            self.wmPlayer.topView.hidden = YES;
//            self.wmPlayer.closeBtn.hidden = YES;

            [self.wmPlayer play];
            [view addSubview:self.wmPlayer];
            
//            [self.wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(view.mas_top);
//                make.left.mas_equalTo(view.mas_left);
//                make.right.mas_equalTo(view.mas_right);
//                make.bottom.mas_equalTo(view.mas_bottom);
//            }];
//            
            
            
        }

        
        
    }];
    
    playView.width = 80;
    playView.height = 80;
    playView.center = CGPointMake(KS_SCREEN_WIDTH / 2, 60);
    [view addSubview:bgView];
    [view addSubview:playView];
    [self.view addSubview:view];
    
    // 先步好第一个 和第三个 按钮 在布置的第二个按钮 (做适配)
    
    // 第一个按钮
    self.coinOrderBtn = [UIButton new];
    self.coinOrderBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.coinOrderBtn.layer.borderWidth = borderWidthW;
    [self.coinOrderBtn setTitle:@"详情" forState:UIControlStateNormal];
    [self.coinOrderBtn setTitleColor:CHEX(0x333333) forState:UIControlStateNormal];
    self.coinOrderBtn.titleLabel.font = KS_FONT(XT(30));
    [self.coinOrderBtn addTarget:self action:@selector(oneCoinOrderBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    self.coinOrderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.coinOrderBtn.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.coinOrderBtn];
    [self.coinOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left);
        make.width.mas_equalTo(w);
        make.bottom.equalTo(view.mas_bottom);
        make.height.equalTo(@(h));
    }];
    
    // 第三个按钮
    self.ConsumptionOrderBtn = [UIButton new];
    self.ConsumptionOrderBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.ConsumptionOrderBtn.layer.borderWidth = borderWidthW;
    [self.ConsumptionOrderBtn setTitle:@"资料" forState:UIControlStateNormal];
    [self.ConsumptionOrderBtn setTitleColor:CHEX(0x333333) forState:UIControlStateNormal];
    self.ConsumptionOrderBtn.titleLabel.font = KS_FONT(XT(30));
    self.ConsumptionOrderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.ConsumptionOrderBtn addTarget:self action:@selector(ConsumptionOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.ConsumptionOrderBtn.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:self.ConsumptionOrderBtn];
    
    [self.ConsumptionOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(w);
        make.right.equalTo(view.mas_right);
        make.bottom.equalTo(view.mas_bottom);
        make.height.equalTo(@(h));
    }];
    
    
    // 中间的按钮
    self.comeBtn = [UIButton new];
    self.comeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.comeBtn.layer.borderWidth = borderWidthW;
    [self.comeBtn setTitle:@"考试" forState:UIControlStateNormal];
    [self.comeBtn setTitleColor:CHEX(0x333333) forState:UIControlStateNormal];
    self.comeBtn.titleLabel.font = KS_FONT(XT(30));
    [self.comeBtn addTarget:self action:@selector(twoBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    self.comeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.comeBtn.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.comeBtn];
    [self.comeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coinOrderBtn.mas_right);
        make.right.equalTo(self.ConsumptionOrderBtn.mas_left);
        make.bottom.equalTo(view.mas_bottom);
        make.height.equalTo(@(h));
    }];
    
    // 下标指示器(三个)
    UILabel * oneLabel = [UILabel new];
    self.oneLabel = oneLabel;
    oneLabel.backgroundColor = SelectionIndicatorColor;
    [view addSubview:oneLabel];
    
    [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coinOrderBtn.mas_left);
        make.width.equalTo(self.coinOrderBtn.mas_width);
        make.bottom.equalTo(self.coinOrderBtn.mas_bottom);
        make.height.equalTo(@(XT(5)));
    }];
    
    
    UILabel * twoLabel = [UILabel new];
    self.twoLabel = twoLabel;
    twoLabel.backgroundColor = SelectionIndicatorColor;
    [view addSubview:twoLabel];
    
    [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.comeBtn.mas_left);
        make.width.equalTo(self.comeBtn.mas_width);
        make.bottom.equalTo(self.comeBtn.mas_bottom);
        make.height.equalTo(@(XT(5)));
    }];
    
    UILabel * threeLabel = [UILabel new];
    self.threeLabel = threeLabel;
    threeLabel.backgroundColor = SelectionIndicatorColor;
    [view addSubview:threeLabel];
    
    [threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ConsumptionOrderBtn.mas_left);
        make.width.equalTo(self.ConsumptionOrderBtn.mas_width);
        make.bottom.equalTo(self.ConsumptionOrderBtn.mas_bottom);
        make.height.equalTo(@(XT(5)));
    }];
    
    self.twoLabel.hidden = YES;
    self.threeLabel.hidden = YES;
    
    self.scrollerView = [UIScrollView new];
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.delegate = self;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.delegate = self;
    self.scrollerView.bounces = NO;
    
    self.scrollerView.alwaysBounceHorizontal = NO;
    self.scrollerView.scrollEnabled = NO;
    
    [self.scrollerView setContentSize:CGSizeMake(KS_SCREEN_WIDTH * 3, 0)];
    [self.view addSubview:self.scrollerView];
    
    
    [self.scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(view.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    // 第一个 tableView
    
    self.oneTableView  = [UITableView new];
//self.oneTableView.backgroundColor = [UIColor yellowColor];
    self.oneTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.oneTableView.dataSource = self;
    self.oneTableView.delegate = self;
    self.oneTableView.frame = CGRectMake(0, 0, KS_SCREEN_WIDTH, KS_SCREEN_HEIGHT- 200 - self.navigationController.navigationBar.height - 20);
    //    self.oneTableView.header = [[HBHeaderRefreshView alloc] initWithDelegate:self];
    //    self.oneTableView.footer = [[HBFooterRefreshView alloc] initWithDelegate:self];
    self.oneTableView.separatorInset = UIEdgeInsetsZero;
    [self.scrollerView addSubview:self.oneTableView];
    //    [self.oneTableView registerClass:[HBOrderTableViewCell class] forCellReuseIdentifier:@"consumptionCell"];
    
      // 第二个 tableView
    self.twoTableView = [UITableView new];
//self.twoTableView.backgroundColor = [UIColor redColor];

    self.twoTableView.frame = CGRectMake(KS_SCREEN_WIDTH, 0, KS_SCREEN_WIDTH, KS_SCREEN_HEIGHT - 200 - self.navigationController.navigationBar.height - 20);
    self.twoTableView.separatorInset = UIEdgeInsetsZero;
    self.twoTableView.dataSource = self;
    self.twoTableView.delegate = self;
    //    self.twoTableView.header = [[HBHeaderRefreshView alloc] initWithDelegate:self];
    //    self.twoTableView.footer = [[HBFooterRefreshView alloc] initWithDelegate:self];
    [self.scrollerView addSubview:self.twoTableView];
    //    [self.twoTableView registerClass:[HBOrderTableViewCell class] forCellReuseIdentifier:@"consumptionCell"];
    
        // 第二个 tableView
    self.threeTableView = [UITableView new];
//self.threeTableView.backgroundColor = [UIColor cyanColor];

    self.threeTableView.frame = CGRectMake(KS_SCREEN_WIDTH+KS_SCREEN_WIDTH, 0, KS_SCREEN_WIDTH, KS_SCREEN_HEIGHT - 200 - self.navigationController.navigationBar.height - 20);
    self.threeTableView.separatorInset = UIEdgeInsetsZero;
    self.threeTableView.dataSource = self;
    self.threeTableView.delegate = self;
    //    self.twoTableView.header = [[HBHeaderRefreshView alloc] initWithDelegate:self];
    //    self.twoTableView.footer = [[HBFooterRefreshView alloc] initWithDelegate:self];
    [self.scrollerView addSubview:self.threeTableView];
    //    [self.twoTableView registerClass:[HBOrderTableViewCell class] forCellReuseIdentifier:@"consumptionC
    
    
    
}

#pragma mark - 点击第一个按
-(void)oneCoinOrderBtnclick:(UIButton *)sender {
    
    [self.scrollerView setContentOffset:CGPointMake(0, 0) animated:NO];
    self.oneLabel.hidden = NO;
    self.twoLabel.hidden = YES;
    self.threeLabel.hidden = YES;
    
}
// 点击第三个按
- (void)ConsumptionOrderBtnClick:(UIButton *) sender {
    
    [self.scrollerView setContentOffset:CGPointMake(KS_SCREEN_WIDTH + KS_SCREEN_WIDTH, 0) animated:NO];
    self.oneLabel.hidden = YES;
    self.twoLabel.hidden = YES;
    self.threeLabel.hidden = NO;
    
}

// 点击第二个按钮 push 考试界面
- (void)twoBtnclick:(UIButton *) sender {
    
    
//    [self.scrollerView setContentOffset:CGPointMake(KS_SCREEN_WIDTH, 0) animated:NO];
//    self.oneLabel.hidden = YES;
//    self.twoLabel.hidden = NO;
//    self.threeLabel.hidden = YES;

    
    
}




#pragma mark - 创建tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if ([tableView isEqual:self.oneTableView])
    {
        return 2;
    }else if ([tableView isEqual:self.threeTableView])
    {
        return 1;
    }
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.oneTableView]) {
        if (section == 0) {
            return 1;
        }else{
             return self.coursesDetailListModelArray.count;
        }
    }else if([tableView isEqual:self.twoTableView]){
        
        return 11;
        
    }else{
        
        return self.ziliaoArray.count;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:self.oneTableView])
    {
        if (indexPath.section == 0) {
            return 60 + BottomViewH;
        }else{
            return XT(120);
        }
    }
    return XT(120);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:self.oneTableView]) {
        
        if (indexPath.section == 0) {
            
            LCTopSectionListCell *cell = [LCTopSectionListCell cellWithTableView:tableView];
            
            cell.classCategoryLabel.text = [NSString stringWithFormat:@"课程分类:%@",self.CourseModel.knowledgeName];
            cell.classIntegralLabel.text = [NSString stringWithFormat:@"课程积分:%@",self.CourseModel.lessonScore];
            cell.progressLabel.text = [NSString stringWithFormat:@"进度:%@%%",self.CourseModel.STUDYPLAN];
            cell.testIntegralLabel.text = [NSString stringWithFormat:@"考试成绩:%@",self.CourseModel.achievement];
            
            // 课程简介内容
            cell.courseStringLabel.text = self.CourseModel.lessonSummary;

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;


        }else{
            
            // 章节的cell 后来新加的
            LCSectionListCell *cell  = [LCSectionListCell cellWithTableView:tableView];
            
            cell.orderLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row + 1];
            
            LCCourseListModel *coursesDetailModel = self.coursesDetailListModelArray[indexPath.row];
            
            cell.titleLabel.text = coursesDetailModel.le_name;
        
             return cell;
        }

    }else if([tableView isEqual:self.twoTableView]){
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
        }
        
        //        cell.textLabel.text = [[ self.ziliaoArray objectAtIndex:indexPath.row] resourceName];
        cell.textLabel.font = KS_FONT(14);
        cell.textLabel.textColor = KS_C_HEX(0x999999, 1);//RGB(15, 163, 214);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        
        return cell;

     }else{
      
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2"];
         if (cell == nil) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
         }
         
         cell.textLabel.text = [[ self.ziliaoArray objectAtIndex:indexPath.row] resourceName];
         cell.textLabel.font = KS_FONT(14);
         cell.textLabel.textColor = KS_C_HEX(0x999999, 1);//RGB(15, 163, 214);
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         
         return cell;
    
    }


}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([tableView isEqual:self.oneTableView]) {
        

        //        LCCourseListModel *listModel =  self.coursesDetailListModelArray[indexPath.row];

        LCCourseListModel *detailListModel =  self.CourseModel.lessonHours[indexPath.row];
        
        if ([self.CourseModel.kjType isEqualToString:@"4"]) {
            
            LCBrowserViewController *webViewVC = [[LCBrowserViewController alloc] init];
            webViewVC.URL = [NSURL URLWithString:detailListModel.ENTER_URL];
            [self.navigationController pushViewController:webViewVC animated:YES];
            
        }else{
            
            FBVideoPlayerController *playVC= [FBVideoPlayerController new];
            playVC.VideoPath = detailListModel.ENTER_URL;
            [self presentViewController:playVC animated:NO completion:nil];
        }

        
    }else if([tableView isEqual:self.twoTableView]){
        
        
        
        
    }else{
       
        KS_ALERT_AFTER(@"请到电脑端进行下载查看", 1.0f);
      
        LCZLiaoEntity *ziliaoModel = self.ziliaoArray[indexPath.row];
        DLog(@"id = %@",ziliaoModel.id);
        DLog(@"%@",ziliaoModel.resourceName);
        DLog(@"%@",ziliaoModel.resourceurl);

        
    
    }



}












//播放完毕的代理方法
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer
{
    [self releaseWMPlayer];
    
//    NSDictionary *params = @{
//                             @"method" : @"getLessonFinishPoint",
//                             @"lessonId" : [self.dataItem pid] ? [self.dataItem pid] : self.pid };
//    [__REQUEST(@"/app/lesson.do", params) post:^(id res, NSError *error) {
//        
//    }];
    
    
}

- (void)releaseWMPlayer
{
    [self.wmPlayer.player.currentItem cancelPendingSeeks];
    [self.wmPlayer.player.currentItem.asset cancelLoading];
    [self.wmPlayer pause];
    [self.wmPlayer removeFromSuperview];
    [self.wmPlayer.playerLayer removeFromSuperlayer];
    [self.wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    self.wmPlayer.player = nil;
    self.wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [self.wmPlayer.autoDismissTimer invalidate];
    self.wmPlayer.autoDismissTimer = nil;
    
    
    self.wmPlayer.playOrPauseBtn = nil;
    self.wmPlayer.playerLayer = nil;
    self.wmPlayer = nil; // 清空一下当前的播放器
}


// 这个功能关闭了 禁止左右滑动
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//
//    if ([scrollView isEqual:self.oneTableView] ||
//        [scrollView isEqual:self.twoTableView] ||
//        [scrollView isEqual:self.threeTableView])    {return;}
//
//    NSInteger index = scrollView.contentOffset.x / scrollView.width;
//
//    if (index == 0 ) {
//        self.oneLabel.hidden = NO;
//        self.twoLabel.hidden = YES;
//        self.threeLabel.hidden = YES;
//
//    }else if(index == 1){
//        self.oneLabel.hidden = YES;
//        self.twoLabel.hidden = NO;
//        self.threeLabel.hidden = YES;
//    }else if(index == 2){
//
//        self.oneLabel.hidden = YES;
//        self.twoLabel.hidden = YES;
//        self.threeLabel.hidden = NO;
//
//    }else{}
//}

@end
