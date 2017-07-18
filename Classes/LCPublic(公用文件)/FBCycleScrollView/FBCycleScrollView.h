//
//  FBCycleScrollView.h
//  FamilyBaby
//
//  Created by super on 16/7/2.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBCycleScrollView : UIView
@property (nonatomic , strong) UIScrollView *scrollView;
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

/*
 * 数据源：获取总的page个数，如果少于2个，不自动滚动
 */
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);

/*
 * 数据源：获取第pageIndex个位置的contentView
 */
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);

/*
 * 当点击的时候，执行的block
 */
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);
@end
