//
//  HBIMViewController.m
//  HaoBan
//
//  Created by super on 16/8/30.
//  Copyright © 2016年 super. All rights reserved.
//   课程 控制器


#import "HBIMViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

#import "LCExtracurricularCourseController.h"
#import "LCPushCourseViewController.h"
#import "LCLiveCoursesViewController.h"

@interface HBIMViewController ()<UIScrollViewDelegate>

// 分段选择器
@property (nonatomic, weak) HMSegmentedControl *segmentedControl;

//   自选课程控制器
@property (nonatomic ,strong) LCExtracurricularCourseController *extracurricularCourseController;

//   推送课程
@property (nonatomic ,strong) LCPushCourseViewController *pushCourseViewController;

//   直播课程
@property (nonatomic ,strong) LCLiveCoursesViewController *liveCoursesViewController;

/** 底部的滚动视图 */
@property (nonatomic, weak) UIScrollView *contentScrollView;

@end

@implementation HBIMViewController

- (LCExtracurricularCourseController *)extracurricularCourseController
{
    if (!_extracurricularCourseController) {
        _extracurricularCourseController = [[LCExtracurricularCourseController alloc ]init];
    }
    return  _extracurricularCourseController;
    
}

- (LCPushCourseViewController *)pushCourseViewController
{
    if (!_pushCourseViewController) {
        _pushCourseViewController = [[LCPushCourseViewController alloc ]init];
    }
    return  _pushCourseViewController;
}

- (LCLiveCoursesViewController *)liveCoursesViewController
{
    if (!_liveCoursesViewController) {
        _liveCoursesViewController = [[LCLiveCoursesViewController alloc ]init];
    }
    return  _liveCoursesViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
//    [self setupChildVc];
//    
//    [self setupUI];
//    
//    [self setupContentView];

}

#pragma mark - 添加自控制器
- (void)setupChildVc{

    [self addChildViewController:self.extracurricularCourseController];
    [self addChildViewController:self.pushCourseViewController];
    [self addChildViewController:self.liveCoursesViewController];

    DLog(@"count = %zd",self.childViewControllers.count);
    
}

#pragma mark - 设置scrollView
- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.delegate = self;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.y = 44;
    
    contentScrollView.width = self.view.width;
    contentScrollView.height = self.view.height - contentScrollView.y - self.tabBarController.tabBar.height;
    contentScrollView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    contentScrollView.backgroundColor = [UIColor whiteColor];
    contentScrollView.bounces = NO;
    [self.view addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentScrollView];
    
}


#pragma mark - 设置UI
- (void)setupUI{
    
    NSArray *items = @[@"自选课程", @"推送课程", @"直播课程"];
    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:items];
    self.segmentedControl = segmentedControl;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    segmentedControl.frame = CGRectMake(0, 0, KS_SCREEN_WIDTH, 44);
//    segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -6, 0, -12);
    segmentedControl.selectionIndicatorColor = RGB(244, 188, 48); //CHEX(0x3ed536);
    segmentedControl.selectionIndicatorHeight = XT(4);
    segmentedControl.selectionStyle =   HMSegmentedControlSelectionStyleFullWidthStripe;

    
    // CHEX(0xEDEDED) CHEX(0x333333)
//    segmentedControl.selectedTitleTextAttributes = @{ NSFontAttributeName: FN(30), NSForegroundColorAttributeName: CHEX(0x3ed536) };
    
    segmentedControl.titleTextAttributes = @{ NSFontAttributeName: FN(30), NSForegroundColorAttributeName: RGB(138, 138, 138)};
    
//    segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    
    //    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
//    DLog(@"%f",segmentedControl.)
    [self.view addSubview:segmentedControl];
    
    // 底部横线
    UIView *line = [UIView new];
    
//    line.backgroundColor = CHEXA(0x000000, 0.2);
    
    line.backgroundColor = RGB(241, 241, 241);

    [segmentedControl addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(segmentedControl).offset(PX(2));
        make.left.equalTo(segmentedControl);
        make.right.equalTo(segmentedControl);
        make.height.mas_offset(PX(2));
    }];
    
    
    CGFloat W = KS_SCREEN_WIDTH / 3;
    CGFloat marginH = 8;

    
    // 中间竖线
    UIView *Vline = [UIView new];
    
// 202 196 198  244 188 48
//    Vline.backgroundColor = CHEXA(0x000000, 0.2);
    
    Vline.backgroundColor =totalLine;

    [segmentedControl addSubview:Vline];

    [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(W);
        make.width.mas_equalTo(XT(2));
//        make.height.mas_offset(44);
        make.top.mas_equalTo(segmentedControl.mas_top).offset(marginH);
        make.bottom.mas_equalTo(segmentedControl.mas_bottom).offset(-marginH);
    }];
    
    // 中间竖线
    UIView *Dline = [UIView new];
    // 202 196 198  244 188 48
    //    Vline.backgroundColor = CHEXA(0x000000, 0.2);
    
    Dline.backgroundColor = totalLine;
    
    [segmentedControl addSubview:Dline];
    
    [Dline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(W + W);
        make.width.mas_equalTo(XT(2));
        //        make.height.mas_offset(44);
        make.top.mas_equalTo(segmentedControl.mas_top).offset(marginH);
        make.bottom.mas_equalTo(segmentedControl.mas_bottom).offset(-marginH);
    }];
    
    
    // 中间竖线
    UIView *Lline = [UIView new];
    // 202 196 198  244 188 48
    //    Vline.backgroundColor = CHEXA(0x000000, 0.2);
    Lline.backgroundColor = totalLine;
    [segmentedControl addSubview:Lline];
    [Lline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(W + W + W);
        make.width.mas_equalTo(XT(2));
        //        make.height.mas_offset(44);
        make.top.mas_equalTo(segmentedControl.mas_top).offset(marginH);
        make.bottom.mas_equalTo(segmentedControl.mas_bottom).offset(-marginH);
    }];
    
}


// 按钮点击
- (void)segmentedControlChangedValue:(id)sender {
    

    // 设置滚动视图的滚动
    CGPoint offset = self.contentScrollView.contentOffset;
    
    offset.x = self.segmentedControl.selectedSegmentIndex * self.contentScrollView.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
    
}

#pragma mark -scrollView的代理
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x /scrollView.width;
    
    // 取出自控制器
    UIViewController *vc = self.childViewControllers[index];
    
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    vc.view.height = scrollView.height;
    [scrollView addSubview:vc.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    self.segmentedControl.selectedSegmentIndex = index;

}


@end
