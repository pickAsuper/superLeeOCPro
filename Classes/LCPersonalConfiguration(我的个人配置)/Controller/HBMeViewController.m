//
//  HBMeViewController.m
//  HaoBan
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "HBMeViewController.h"
#import "LCUserInfoModel.h"
#import "LCChangePasswordViewController.h"

@interface HBMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LCUserInfoModel *userDetailsInfoModel;

@end

@implementation HBMeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self reloadDataSource];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dataSource addObjectsFromArray:@[
                                           @"修改密码",@"问卷调查",@"当前版本"
                                           ]];
    self.title = @"我的";

    
    [self setupTableView];
    
}


- (void)reloadDataSource
{
    
     FB_WEB_GET_doFindMyInfoById(@"doFindMyInfoById", [HBUserToolkit getUserID], [HBUserToolkit getUserToken], ^(id responseObject, NSError *error) {
         DLog(@"%@",responseObject);
         DLog(@"%@",error);
         LCUserInfoModel *userDetailsInfoModel = [LCUserInfoModel mj_objectWithKeyValues:responseObject];
         self.userDetailsInfoModel = userDetailsInfoModel;
         
         [self.tableView reloadData];
     });
    
}

#pragma mark - 创建tableView
- (void)setupTableView
{
    //  TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KS_SCREEN_WIDTH, KS_SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = KS_C_RGBA(242, 242, 242, 1);
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
//    self.tableView.contentInset = UIEdgeInsetsMake(-32, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
        
    }else if (section == 1) {
   
        return self.dataSource.count;
    
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 200.0f;
    }
    return XT(120);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
    if (indexPath.section == 0) {
      
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"meCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"meCell"];
        }
        
        cell.backgroundColor = RGB(246, 246, 246);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *iconImageView = [UIImageView imageViewWithName:@"default.png"];

//        [iconImageView sd_setImageWithURL:[NSURL URLWithString:self.userDetailsInfoModel.userPhoto]];
        
       [iconImageView sd_setImageWithURL:[NSURL URLWithString:self.userDetailsInfoModel.userPhoto] placeholderImage:[UIImage imageNamed:@"default.png"]];
        
        [cell addSubview:iconImageView];
       
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell);
            make.centerY.equalTo(cell).offset(-30);
            make.size.mas_equalTo(CGSizeMake(90, 90));
        }];
        
        UILabel *namelb = [UILabel new];
        UILabel *lb = [UILabel new];
        UILabel *lb1 = [UILabel new];
        UILabel *lb3 = [UILabel new];
        
        UILabel *lb2 = [UILabel new];
        
        namelb.text = [NSString stringWithFormat:@"%@",self.userDetailsInfoModel.userName];
        namelb.font = KS_FONT(14);
        namelb.textAlignment = NSTextAlignmentCenter;
        
        lb.text = [NSString stringWithFormat:@"经销商代码:%@",self.userDetailsInfoModel.userTgroup];
        lb.font = KS_FONT(14);
        lb.textAlignment = NSTextAlignmentCenter;
//                lb.backgroundColor = [UIColor cyanColor];
        
        
        lb1.text = [NSString stringWithFormat:@"我的积分%@", self.userDetailsInfoModel.integral];
        lb1.font = KS_FONT(14);
        lb1.textAlignment = NSTextAlignmentRight;
        
//                lb1.backgroundColor = [UIColor purpleColor];
        
        
        lb2.text = [NSString stringWithFormat:@"我的排名%@", self.userDetailsInfoModel.ranking];
        lb2.font = KS_FONT(14);
        lb2.textAlignment = NSTextAlignmentLeft;
        
//                lb2.backgroundColor = [UIColor yellowColor];
        
        
        lb3.text = [NSString stringWithFormat:@"岗位:%@",self.userDetailsInfoModel.userStation];
        lb3.font = KS_FONT(14);
        lb3.textAlignment = NSTextAlignmentLeft;
        
//                lb3.backgroundColor = [UIColor yellowColor];
        
        [cell addSubview:lb];
        [cell addSubview:lb1];
        [cell addSubview:lb2];
        [cell addSubview:lb3];
        
        [cell addSubview:namelb];
        
        [namelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconImageView.mas_bottom).offset(10);
            //            make.right.equalTo(self.view.mas_right);
            //            make.left.equalTo(self.view.mas_left);
            make.centerX.equalTo(iconImageView.mas_centerX);
        }];
        
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(iconImageView.mas_left);
            make.top.equalTo(iconImageView.mas_bottom).offset(30);
        }];
        
        [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(iconImageView.mas_left);
            make.top.equalTo(iconImageView.mas_bottom).offset(50);
        }];
        
        
        [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.mas_right);
            make.top.equalTo(iconImageView.mas_bottom).offset(50);
        }];
        
        [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.mas_right);
            make.top.equalTo(iconImageView.mas_bottom).offset(30);
        }];

        return cell;

      } else if (indexPath.section == 1) {
         
          static NSString *LCMineCellID = @"MineCellID";
          UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LCMineCellID];
          
          
          if (cell == nil) {
              cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LCMineCellID];
             
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
          
          NSString *entry = [self.dataSource objectAtIndex:indexPath.row];
          
          UILabel *name = [cell viewWithTag:50];
          UIImageView *iv = [cell viewWithTag:40];
          
          iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"组-1-拷贝-1%d@2x.png", (int)(indexPath.row % 12 + 1)]];
          
          name.text = entry;
          
          
          if ([name.text isEqualToString:@"当前版本"]) {
              UILabel *vlb = [UILabel new];
              vlb.font = KS_FONT(12);
              vlb.text = KS_APP_VERSION;
              
              [cell addSubview:vlb];
              [vlb mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.right.equalTo(cell).offset(-20);
                  make.top.equalTo(cell);
                  make.bottom.equalTo(cell);
              }];
          }
          
          
          return cell;

    
      }else{
    
    
    
          UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultcellID"];
          if (cell == nil) {
              cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultcellID"];
               }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

          
              UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
              
              [button setTitle:@"退出" forState:UIControlStateNormal];
              [button setBackgroundColor:[UIColor redColor]];
              [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
              [button setRadius:5];
              [cell addSubview:button];
              [button mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.left.equalTo(cell).offset(20);
                  make.right.equalTo(cell).offset(-20);
                  make.top.equalTo(cell).offset(8);
                  make.bottom.equalTo(cell).offset(-8);
              }];
              [button onClickEvent:^{

                 [[HBUserToolkit shared] signOut] ;
                  DLog(@" [toolk signOut] = %@",NSHomeDirectory());
                  
                  self.tabBarController.selectedIndex = 0;
                  
              }];

          
          
           return cell;
      }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1){
        if (indexPath.row == 0) {
            
            DLog(@"修改密码");
            
            [self.navigationController pushViewController:[LCChangePasswordViewController new] animated:YES];
            
            
        }else  if (indexPath.row == 1) {
            DLog(@"问卷调查");

            
        }else{
        
        
        }
    
    
    }
    
}


@end
