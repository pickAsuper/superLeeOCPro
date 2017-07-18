//
//  FBCycleScrollView.m
//  FamilyBaby
//
//  Created by super on 16/7/2.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "FBCycleScrollView.h"
#import "NSTimer+Addition.h"
#import "FBMyPageControl.h"
#import <Masonry.h>
#import <KSToolkit.h>


@interface FBCycleScrollView ()<UIScrollViewDelegate>
{
    CGFloat scrollViewStartContentOffsetX;
}
/**
 *  当前页下标
 */
@property (nonatomic , assign) NSInteger currentPageIndex;

/**
 *  总页下标
 */
@property (nonatomic , assign) NSInteger totalPageCount;

@property (nonatomic , strong) NSMutableArray *contentViews;

/**
 *  定时器
 */
@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;

/**
 *  分页控件
 */
@property (nonatomic , strong) FBMyPageControl *pageControl;


@end

@implementation FBCycleScrollView

- (FBMyPageControl *)pageControl
{
    // 少于或者等于一页的话，没有必要显示pageControl
    if (self.totalPageCount > 1) {
        if (!_pageControl) {
            NSInteger totalPageCounts = self.totalPageCount;
            CGFloat dotGapWidth = 8.0;
            UIImage *normalDotImage = [[UIImage imageNamed:@"轮播图切@2x.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImage *highlightDotImage = [[UIImage imageNamed:@"轮播图切换（当前）.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            CGFloat pageControlWidth = totalPageCounts * XT(25);
            
            CGFloat pageX = self.width / 2 - pageControlWidth / 2;
           
            CGRect pageControlFrame = CGRectMake( pageX , 0.88 * CGRectGetHeight(self.scrollView.frame), pageControlWidth , normalDotImage.size.height);
            
            _pageControl = [[FBMyPageControl alloc] initWithFrame:pageControlFrame normalImage:normalDotImage highlightedImage:highlightDotImage dotsNumber:totalPageCounts sideLength:dotGapWidth dotsGap:dotGapWidth];
            _pageControl.hidden = NO;
        }
    }
    return _pageControl;
}

#pragma mark - 设置个数
- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    self.totalPageCount = totalPagesCount();
    if (self.totalPageCount > 0) {
        if (self.totalPageCount > 1) {
            self.scrollView.scrollEnabled = YES;
            self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
            [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
        } else {
            self.scrollView.scrollEnabled = NO;
        }
        [self configContentViews];
        [self addSubview:self.pageControl];
    }
}

- (void)setFetchContentViewAtIndex:(UIView *(^)(NSInteger index))fetchContentViewAtIndex
{
    _fetchContentViewAtIndex = fetchContentViewAtIndex;
    // 加入第一页
    [self configContentViews];
}

- (void)setCurrentPageIndex:(NSInteger)currentPageIndex
{
    _currentPageIndex = currentPageIndex;
    [self.pageControl setCurrentPage:_currentPageIndex];
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration) target:self selector:@selector(animationTimerDidFired:) userInfo:nil repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingNone;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
    }
    return self;
}

#pragma mark - 私有函数

- (void)configContentViews
{
    /**
     *  向每个 scrollView.subviews 发送一个 removeFromSuperview 方法
     */
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
  
    NSInteger counter = 0;
   
    for (UIView *contentView in self.contentViews) {
        // 打开交互
        contentView.userInteractionEnabled = YES;
        
        UILongPressGestureRecognizer *longTapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapGestureAction:)];
        [contentView addGestureRecognizer:longTapGesture];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
  
    if (self.totalPageCount > 1) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    }
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        id set = (self.totalPageCount == 1)?[NSSet setWithObjects:@(previousPageIndex),@(_currentPageIndex),@(rearPageIndex), nil]:@[@(previousPageIndex),@(_currentPageIndex),@(rearPageIndex)];
      
        for (NSNumber *tempNumber in set) {
            NSInteger tempIndex = [tempNumber integerValue];
            if ([self isValidArrayIndex:tempIndex]) {
                [self.contentViews addObject:self.fetchContentViewAtIndex(tempIndex)];
            }
        }
    }
}

- (BOOL)isValidArrayIndex:(NSInteger)index
{
    if (index >= 0 && index <= self.totalPageCount - 1) {
        return YES;
    } else {
        return NO;
    }
}
/**
 *  当前页/最后一页
 */
- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    scrollViewStartContentOffsetX = scrollView.contentOffset.x;
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (self.totalPageCount == 2) {

        // 如果偏移的页数小于scrollView开始偏移的x
        if (scrollViewStartContentOffsetX < contentOffsetX) {
          
            UIView *tempView = (UIView *)[self.contentViews lastObject];
            tempView.frame = (CGRect){{2 * CGRectGetWidth(scrollView.frame),0},tempView.frame.size};
      
           
        } else if (scrollViewStartContentOffsetX > contentOffsetX) {
         // 如果偏移的页数大于scrollView开始偏移的x
            
            UIView *tempView = (UIView *)[self.contentViews firstObject];
            tempView.frame = (CGRect){{0,0},tempView.frame.size};
        }
    }
    
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
     
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
    
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}


#pragma mark - 长按响应事件

- (void)longTapGestureAction:(UILongPressGestureRecognizer *)tapGesture
{
    if (tapGesture.state == UIGestureRecognizerStateBegan) {
        DLog(@"UIGestureRecognizerStateBegan");
        [self.animationTimer pauseTimer];
    }
    if (tapGesture.state == UIGestureRecognizerStateEnded) {
        [self.animationTimer resumeTimer];
        DLog(@"UIGestureRecognizerStateEnded");
    }
}

#pragma mark - animationTimerDidFired

- (void)animationTimerDidFired:(NSTimer *)timer
{
    int n = self.scrollView.contentOffset.x/self.scrollView.width;
    CGPoint newOffset = CGPointMake(self.scrollView.width*n + CGRectGetWidth(self.scrollView.frame), 0);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}



@end
