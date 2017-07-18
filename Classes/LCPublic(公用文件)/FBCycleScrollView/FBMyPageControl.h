//
//  FBMyPageControl.h
//  FamilyBaby
//
//  Created by super on 16/7/2.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyPageControlDelegate <NSObject>

@optional

- (void)pageControlDidStopAtIndex:(NSInteger)index;

@end
@interface FBMyPageControl : UIView
{
    // 普通图
    UIImage         *_normalDotImage;
    // 高亮
    UIImage         *_highlightedDotImage;
    NSInteger       __pageNumbers;
    float           __dotsSize;
    NSInteger       __dotsGap;
}

@property (nonatomic , assign)  NSInteger pageNumbers;
@property (nonatomic , assign) id<MyPageControlDelegate> delegate;

// 创建pageCr
- (id)initWithFrame:(CGRect)frame normalImage:(UIImage *)nImage highlightedImage:(UIImage *)hImage dotsNumber:(NSInteger)pageNum sideLength:(NSInteger)size dotsGap:(NSInteger)gap;

- (void)setCurrentPage:(NSInteger)pages;

@end
