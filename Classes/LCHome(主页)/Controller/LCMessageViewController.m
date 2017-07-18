//
//  LCMessageViewController.m
//  HaoBan
//
//  Created by admin on 2017/6/28.
//  Copyright © 2017年 tsingda. All rights reserved.
//

#import "LCMessageViewController.h"
#import "LCMessageListModel.h"
#import "LCMessageViewCell.h"

@interface LCMessageViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate
>

@property (nonatomic, strong)NSMutableArray *msgArray;


@end

@implementation LCMessageViewController

- (NSMutableArray *)msgArray {
    if (_msgArray== nil) {
        _msgArray = [NSMutableArray new];
    }
    return _msgArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"消息";
    
    [self loadData];
    // 创建tableView
    [self setupTableView];
    

}


- (void)loadData
{
    
    
    FB_WEB_MESSAGE_DO(@"getMessageList", [HBUserToolkit getUserID], [HBUserToolkit getUserToken],1,100, ^(id responseObject, NSError *error) {
        
        DLog(@"responseObject = %@",responseObject);
        
        
        if (error) {
            DLog(@"error = %@",error);

            [self showToast:error.localizedDescription callback:nil];
            
            
        }else{
        
            NSMutableArray *msgArray =  [LCMessageListModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [self.msgArray addObjectsFromArray:msgArray];
            DLog(@"%@",msgArray);
            
            [self.tableView reloadData];
        
        }
    });

    



}

#pragma mark - 创建tableView
- (void)setupTableView
{
    //  发现的TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KS_SCREEN_WIDTH, KSSCREENH - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kBackgroundLightGrayColor;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
//    self.tableView.footer       = [[KSDefaultFootRefreshView alloc] initWithDelegate:self];
//    self.tableView.header       = [[KSDefaultHeadRefreshView alloc]initWithDelegate:self];
    [self.tableView registerClass:[LCMessageViewCell class] forCellReuseIdentifier:@"LCMessageViewControllerID"];
    [self.view addSubview:self.tableView];
    
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.msgArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
       LCMessageViewCell *cell = [LCMessageViewCell cellWithTableView:tableView];
    

        LCMessageListModel *msgModel =  self.msgArray[indexPath.row];
    
         cell.name.text = msgModel.name;
         cell.date.text = msgModel.beginTime;
    
        return cell;
        
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        LCMessageListModel *msgModel =  self.msgArray[indexPath.row];
        
        [self.hud showAnimated:YES];
        
        // 删除消息列表里的
        FB_WEB_GET_delMessage(@"delMessage", msgModel.ID, [HBUserToolkit getUserID], [HBUserToolkit getUserToken], ^(id responseObject, NSError *error) {
            
            [self.hud hideAnimated:YES];
            [self.msgArray removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        
        });

    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
