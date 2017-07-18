//
//  LCCourseCenterViewController.m
//  HaoBan
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 tsingda. All rights reserved.
//   课程中心

#import "LCCourseCenterViewController.h"
//#import "LCTwoCourseCenterViewController.h"



@interface LCCourseCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LCCourseCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"课程中心";
  
    [self reloadKnowledgeDataSource];
    
    
    [self setupTableView];
    
    
}

- (void)reloadKnowledgeDataSource {

    FB_WEB_GET_APP_getKnowledgeList(@"getKnowledgeList", [HBUserToolkit getUserID], [HBUserToolkit getUserToken], ^(id responseObject, NSError *error) {
        DLog(@"responseObject = %@",responseObject);
        
        DLog(@"error = %@",error);
        
        if (error) {
            [self showToast:error.localizedDescription callback:nil];
            return ;
        }else{
            if ([responseObject objectForKey:@"list"]) {
                [self.dataSource addObjectsFromArray:responseObject[@"list"]];
                [self.tableView reloadData];
            }
        }
    });
    

}

#pragma mark - 创建tableView
- (void)setupTableView
{
    //  TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KS_SCREEN_WIDTH, KS_SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = KS_C_RGBA(242, 242, 242, 1);
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.tableView.contentInset = UIEdgeInsetsMake(-32, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return XT(120);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MineSetCellID = @"MineSetCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MineSetCellID];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MineSetCellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat sp = 0;
        
        cell.frame = CGRectMake(0, 0, KS_SCREEN_WIDTH, 60.0f);
        
        UIView *bg = [UIView new];
        bg.frame = CGRectMake(sp, 0, KS_SCREEN_WIDTH - sp *2, 60.0f);
        bg.backgroundColor = [UIColor whiteColor];
        
        [cell addSubview:bg];
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(sp + 10, 15, 30, 30)];
        
        iv.tag = 40;
        
        [cell addSubview:iv];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(sp + 50, 5, 200, 50.0f)];
        name.tag = 50;
        name.textAlignment = NSTextAlignmentLeft;
        name.font = KS_FONT(14);
        
        [cell addSubview:name];
    }
    
    UIView *top = [cell viewWithTag:21];
    
    if (indexPath.row == 0) {
        top.hidden = NO;
    } else {
        top.hidden = YES;
    }
    
    NSDictionary *entry = [self.dataSource objectAtIndex:indexPath.row];
    
    UILabel *name = [cell viewWithTag:50];
    UIImageView *iv = [cell viewWithTag:40];
    
//    iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", (int)(indexPath.row % 12 + 1)]];
    name.text = [entry objectForKey:@"name"];
    
    iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"组-1-拷贝-1%d@2x.png", (int)(indexPath.row % 12 + 1)]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *entry = [self.dataSource objectAtIndex:indexPath.row];

//    LCTwoCourseCenterViewController *twoClassVC = [LCTwoCourseCenterViewController new];
//    twoClassVC.entry = entry;
//    [self.navigationController pushViewController:twoClassVC animated:YES];
    
    
    
}


@end
