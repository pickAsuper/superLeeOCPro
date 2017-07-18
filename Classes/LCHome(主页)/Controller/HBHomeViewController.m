//
//  HBHomeViewController.m
//  HaoBan
//
//  Created by super on 16/8/30.
//  Copyright © 2016年 super. All rights reserved.
//

#import "HBHomeViewController.h"
// 加载H5的控制器
#import "LCBrowserViewController.h"
// 轮播图View
#import "FBCycleScrollView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
// 轮播图模型
#import "LCBannerModel.h"

// 九宫格按钮
#import "FBVerticalButton.h"
#import "LCHomeListTableViewCell.h"


#import "HBLoginViewController.h"
#import "LCLessonListModel.h"

// 课程详情
#import "LCCoursesDetailController.h"


// 课程中心
#import "LCCourseCenterViewController.h"


@interface HBHomeViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;


/**
 *  图片分页控件
 */
@property (nonatomic,strong) FBCycleScrollView *bannerView;

// 轮播图广告
@property (nonatomic, strong) NSMutableArray *shuffleImageArray;

@property (nonatomic, strong) NSMutableArray *lessonListModelArray;

@property (nonatomic, weak) UIView *tx;


@end

@implementation HBHomeViewController

// scrollView的高度
static CGFloat const scrollViewH = 170;

// 九宫格按钮的高度
static CGFloat const bottonsH = 80 ;

// 顶部topHeader的高度
static CGFloat const topHeaderViewH = scrollViewH + bottonsH ;


- (NSMutableArray *)shuffleImageArray {
    if (_shuffleImageArray == nil) {
        _shuffleImageArray = [NSMutableArray new];
    }
    return _shuffleImageArray;
}

- (NSMutableArray *)lessonListModelArray {
    if (_lessonListModelArray == nil) {
        _lessonListModelArray = [NSMutableArray new];
    }
    return _lessonListModelArray;
}

- (UIButton *)navigationBarRightButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = KS_IMAGE(@"11syxx.png");
    //    image = [image imageZoomWithSize:CGSizeMake(image.size.width / 4, image.size.height / 4)];
    [button setImage:image forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 33, 33)];
    UIView *tx = [[UIView alloc] initWithFrame:CGRectMake(28, 10, 6, 6)];
    tx.backgroundColor = [UIColor redColor];
    tx.radius = 6.0f;
    
    [button addSubview:tx];
    self.tx = tx;
    self.tx.hidden = YES;
    return button;



}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

// 在这里强制登录
    HBUserToolkit *toolk  = [HBUserToolkit shared];
    [toolk getUserInfo];
    
    if (toolk.isLogin == NO) {
        [self presentViewController:[HBLoginViewController new] animated:NO completion:nil];
    }
    

    

}

- (void)navigationBarRightButtonHandler:(id)sender {
    [self pushWithName:@"LCMessageViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadShuffleImageData];
    
    [self loadData];

    [self setupTableView];
    
    DLog(@"getUserID = %@",[HBUserToolkit getUserID]);
    
    DLog(@"NSHomeDirectory = %@",NSHomeDirectory());
    
}





#pragma mark - 获取轮播的图片
- (void)reloadShuffleImageData {

    FB_WEB_BANNER(@"doFindIndexInfo", ^(id responseObject, NSError *error) {
     
        DLog(@"AD responseObject = %@",responseObject);
        
        
        NSMutableArray *bannerArray =  [LCBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"indexNoticeList"]];
        
        [self.shuffleImageArray addObjectsFromArray:bannerArray];
        [self.tableView reloadData];
        
    });
    
}



#pragma mark - 创建顶部的view

- (UIView *)createTopHeaderView
{
    
    // 顶部的View
    UIView *topHeaderView = [[UIView alloc] init];
    topHeaderView.backgroundColor = [UIColor clearColor];
    
    
    topHeaderView.frame   = CGRectMake(0, 0, KS_SCREEN_WIDTH, topHeaderViewH);
    
    // 创建图片轮播器
    _bannerView = [[FBCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, topHeaderView.width, scrollViewH) animationDuration:2];
    _bannerView.scrollView.scrollsToTop = NO;
    [topHeaderView addSubview:_bannerView];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
        for (int i = 0 ; i < _shuffleImageArray.count; i++) {
    
            // 获取模型
            LCBannerModel *model = _shuffleImageArray[i];
    
            // 添加图片
            UIImageView *pictureView = [[UIImageView alloc] init];
//            self.pictureView = pictureView;
            pictureView.contentMode = UIViewContentModeScaleAspectFill;
            pictureView.clipsToBounds = YES;
            [pictureView sd_setImageWithURL:[NSURL URLWithString:model.noticeTitleImg] placeholderImage:[UIImage imageNamed:@"image0.png"]];
    
            pictureView.frame = CGRectMake((KS_SCREEN_WIDTH * i) + KS_SCREEN_WIDTH, 0, KS_SCREEN_WIDTH, scrollViewH);
    
            [result addObject:pictureView];
    
            KS_WS(weakSelf);
    
            // 图片轮播的对应的分页控制器个数
            _bannerView.totalPagesCount = ^NSInteger(void){
                return weakSelf.shuffleImageArray.count;
    
            };
    
            // 图片轮播的对应的图片
            _bannerView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
                if(pageIndex >= result.count) return result[result.count -1];
                return result[pageIndex];
            };
    
    
    
            // 图片轮播的点击方法
            _bannerView.TapActionBlock = ^(NSInteger pageIndex){
    
                LCBannerModel *model = weakSelf.shuffleImageArray[pageIndex];
                LCBrowserViewController *webPageVc = [[LCBrowserViewController alloc] init];
               
                NSString *url = [NSString stringWithFormat:@"%@/index.do?method=doFindNoticeInformationById&noticeId=%@",kFB_BASE_URL, model.ID];
                webPageVc.URL = [NSURL URLWithString: url];
                [weakSelf.navigationController pushViewController:webPageVc animated:YES];
    
            };
    
        }
    
    
        // 计算四个按钮布局
        CGFloat bottomViewH = bottonsH;
    
        DLog(@"bottomViewH %f",bottomViewH);
        UIView *bottomView = [[UIView alloc]init];
        bottomView.frame = CGRectMake(0, scrollViewH, KS_SCREEN_WIDTH, bottomViewH);
        bottomView.backgroundColor = kBackgroundLightGrayColor;
        [topHeaderView addSubview:bottomView];
    
        NSArray *imageArray = @[
                                @"推送课程.png",@"统一考试.png",@"课程中心.png",@"调查问卷.png",
//                                @"推送课程.png",@"统一考试.png",@"课程中心.png",@"调查问卷.png"
                                ];
    
        // 添加按钮
        int maxCols = 4;
        CGFloat margin = XT(2);
        CGFloat actionBtnW = (topHeaderView.width - margin) / 4  ;
        CGFloat actionBtnH = bottomViewH;
    
        for (int i = 0 ; i < imageArray.count ;i++) {
            FBVerticalButton *actionButton = [[FBVerticalButton alloc]init];

            int row = i / maxCols;
            int col = i % maxCols;
            CGFloat btnX = margin + col * (actionBtnW + margin) - margin;
            CGFloat btnY = margin + row * (actionBtnH + margin) - margin;
    
            actionButton.backgroundColor = [UIColor whiteColor];
            [actionButton setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [actionButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            [actionButton addTarget:self action:@selector(actionBtnClcik:)];
            actionButton.tag = 100 + i;
            actionButton.frame = CGRectMake(btnX, btnY, actionBtnW, actionBtnH);
            [bottomView addSubview:actionButton];
    
        }
    
    
    return topHeaderView;
}

#pragma mark - 8个按钮的点击
- (void)actionBtnClcik:(UIButton *)btn{

    if (btn.tag == 100) {
        // 选中课程
        self.tabBarController.selectedIndex = 1;

    }else if (btn.tag == 101) {
        // 选中考试
        self.tabBarController.selectedIndex = 2;

    }else if (btn.tag == 102) {
       
        // 课程中心
        [self.navigationController pushViewController:[LCCourseCenterViewController new] animated:YES];
        
    }else if (btn.tag == 103) {
        
        
    }



}

- (void)loadData{

    FB_WEB_GET_doFindIndexInfo(@"doFindIndexInfo", [HBUserToolkit getUserID], [HBUserToolkit getUserToken], ^(id responseObject, NSError *error) {
    
        DLog(@"responseObject = %@",responseObject);
        
        DLog(@"error = %@",error);
 
        NSMutableArray *lessonListModelArray =  [LCLessonListModel mj_objectArrayWithKeyValuesArray:responseObject[@"indexLessonList"]];
        
     
        [self.lessonListModelArray addObjectsFromArray:lessonListModelArray];
        
        [self.tableView reloadData];
        
        
    });
}

#pragma mark - 上拉
- (void)loadNewData{
    
    NSLog(@"adsss");
    
    
}

#pragma mark - 下拉
- (void)loadMoreData{
  
    NSLog(@"哈哈哈哈哈");
    



}




#pragma mark - 创建tableView
- (void)setupTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSSCREENW, KSSCREENH - 64 - 49) style:UITableViewStylePlain];
    
    //  发现的TableView
    self.tableView.backgroundColor = kBackgroundLightGrayColor;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.tableView.mj_footer    = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header    = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.tableView registerClass:[LCHomeListTableViewCell class] forCellReuseIdentifier:@"LCHomeListTableViewCellID"];
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  2;
}

#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return self.lessonListModelArray.count;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return topHeaderViewH;
    }else{
       return 170.0f/2 + 15;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalCellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normalCellID"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // 为了防止cell的重用 有就不用再创建了
            NSInteger tag = 121;
            UIView *topView = [cell viewWithTag:tag];
            if (topView == nil) {
                topView = [self createTopHeaderView];
                [cell.contentView addSubview:topView];
                
            }
           return cell;

    }else{
        

        LCHomeListTableViewCell *cell = [LCHomeListTableViewCell cellWithTabelView:tableView];
        LCLessonListModel *model = self.lessonListModelArray[indexPath.row];
      
        // 图片
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.lessonImg] placeholderImage:[UIImage imageNamed:@"image3.png"]];
        
        // 标题
        cell.textStringLabel.text = model.lessonName;
        
        cell.timeLabel.hidden = YES;
        
        // 浏览数量
        cell.lookLabel.text = [NSString stringWithFormat:@"(%@)",model.browseamount];
        
        cell.monitoringTimeLabel.text = [NSString stringWithFormat:@"(%@)",model.lessonCost];
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    LCLessonListModel *model = self.lessonListModelArray[indexPath.row];
    
    LCCoursesDetailController *detailVC = [LCCoursesDetailController new];
     detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}

@end
