//
//  HBNetworkConnectionFailureView.h
//  HaoBan
//
//  Created by super on 2017/4/18.
//  Copyright © 2016年 super. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@protocol HBNetworkConnectionFailureViewDelegate <NSObject>

@optional
- (void)HBNetworkConnectionFailureViewDidClickRefresh;

@end

@interface HBNetworkConnectionFailureView : UIView

@property (nonatomic, weak) id<HBNetworkConnectionFailureViewDelegate> delegate;

@end
