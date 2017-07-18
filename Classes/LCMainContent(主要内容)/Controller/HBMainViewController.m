//
//  HBMainViewController.m
//  HaoBan
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "HBMainViewController.h"
#import "HBHomeViewController.h"
#import "HBIMViewController.h"
#import "HBDiscoveryViewController.h"
#import "HBMeViewController.h"
#import "LCTestViewController.h"
#import "LCCourseViewController.h"

@interface HBMainViewController ()

@property (nonatomic, strong) UITabBarController *tabBarVC;
@property (nonatomic, strong) UINavigationController *loginVC;

@end

@implementation HBMainViewController

- (UITabBarController *)tabBarVC {
    if (_tabBarVC == nil) {
        id home = [self createTabBarSubViewControllerItem:[HBHomeViewController class] :@"首页" :@"tb_1-2" :@"tb_1"];
        id im = [self createTabBarSubViewControllerItem:[LCCourseViewController class] :@"课程" :@"tb_2-2" :@"tb_2"];
        id discovery = [self createTabBarSubViewControllerItem:[LCTestViewController class] :@"考试" :@"tb_3-2" :@"tb_3"];
        id me = [self createTabBarSubViewControllerItem:[HBMeViewController class] :@"我的" :@"tb_5-2" :@"tb_5"];
        _tabBarVC = [UITabBarController new];
        _tabBarVC.viewControllers = @[ home, im , discovery, me];
        _tabBarVC.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor blackColor] size:CGSizeMake(1, 1)];

    }
    return _tabBarVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    
    [self addChildWithVC:self.tabBarVC];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 创建TabBar的子项

 @param cls         类名
 @param title       显示标题
 @param normalImage 正常显示图标
 @param selectImage 选中显示图标

 @return 对象
 */
- (UINavigationController *)createTabBarSubViewControllerItem:(Class)cls
                                                             :(NSString *)title
                                                             :(NSString *)normalImage
                                                             :(NSString *)selectImage {
    UIViewController *vc = [cls new];
    vc.tabBarItem.title = title;
    vc.title = title;
    vc.hidesBottomBarWhenPushed = NO;
    
    NSDictionary * ta1 = @{ NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSDictionary * ta2 = @{ NSForegroundColorAttributeName :  RGBA(15, 108, 178, 1)};
    
    [vc.tabBarItem setTitleTextAttributes:ta2 forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:ta1 forState:UIControlStateNormal];
    
    if (normalImage) {
        vc.tabBarItem.image = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if (selectImage) {
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    return nav;
}

@end
