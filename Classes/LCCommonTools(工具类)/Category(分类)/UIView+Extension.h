//
//  UIView+Extension.h
//  美团MM
//
//  Created by lichao on 15/12/12.
//  Copyright © 2015年 super. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat lc_x;
@property (nonatomic, assign) CGFloat lc_y;
@property (nonatomic, assign) CGFloat lc_width;
@property (nonatomic, assign) CGFloat lc_height;
@property (nonatomic, assign) CGFloat lc_centerX;
@property (nonatomic, assign) CGFloat lc_centerY;
@property (nonatomic, assign) CGPoint lc_origin;
@property (nonatomic, assign) CGSize lc_size;

@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;


// ------  增加的方法 --------

//弹出一个类似present效果的窗口
- (void)presentView:(UIView*)view animated:(BOOL)animated complete:(void(^)()) complete;

//获取一个view上正在被present的view
- (UIView *)presentedView;

- (void)dismissPresentedView:(BOOL)animated complete:(void(^)()) complete;

//这个是被present的窗口本身的方法
//如果自己是被present出来的，消失掉
- (void)hideSelf:(BOOL)animated complete:(void(^)()) complete;


// 是否显示在了主控制器上
- (BOOL)lc_isShowingOnKeyWindow;


@end
