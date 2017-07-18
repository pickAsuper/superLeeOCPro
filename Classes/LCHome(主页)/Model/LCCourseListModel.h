//
//  LCCourseListModel.h
//  SuperProject
//
//  Created by admin on 2017/6/10.
//  Copyright © 2017年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCCourseListModel : NSObject
/*
 "ENTER_URL" = "http://xiaofang.aotimes.com/resource/mp4Course/a65fdfc5-6389-48a9-920d-c0cceef76d09/1.mp4";
 id = "f50c0e73-7a54-4588-a2cb-441510b310a2";
 "le_id" = "a65fdfc5-6389-48a9-920d-c0cceef76d09";
 "le_name" = 1;
 lindex = 0;
 */

@property (nonatomic, copy)NSString  *ENTER_URL;
@property (nonatomic, copy)NSString  *ID;
@property (nonatomic, copy)NSString  *le_id;
@property (nonatomic, copy)NSString  *le_name;
@property (nonatomic, copy)NSString  *lindex;


@end
