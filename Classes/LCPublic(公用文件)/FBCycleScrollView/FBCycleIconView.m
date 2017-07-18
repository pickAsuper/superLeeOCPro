//
//  FBCycleIconView.m
//  FamilyBaby
//
//  Created by super on 16/9/6.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "FBCycleIconView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <KSToolkit/UIView+KS.h>
#import <KSToolkit/KSMacros.h>
#import <Masonry/Masonry.h>
#import <SDWebImageManager.h>

@interface FBCycleIconView()

/**
 *   视图
 */
@property (nonatomic, strong) UIImageView *imageView;

/**
 *  默认用户头像
 */
@property (nonatomic, strong) UIImage *defaultCellImage;

@end

@implementation FBCycleIconView

- (UIImage *)defaultCellImage {
    if (_defaultCellImage == nil) {
        _defaultCellImage = [UIImage imageNamed:@"发现苹果新闻图.png"];
    }
    return _defaultCellImage;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, KS_SCREEN_WIDTH,!self.cycleFloat?XT(340):self.cycleFloat);
        self.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
            
            
        }];
    }
    return self;
}

- (void)setURLString:(NSString *)URLString {
    _URLString = URLString;
    if (URLString == nil) {
        [self.imageView setImage:self.defaultCellImage];
    } else {
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_URLString]
                          placeholderImage:self.defaultCellImage
                                 completed:nil];
        
        CGSize size = [self adapterSizeImageSize:self.imageView.image.size compareSize:CGSizeMake(KS_SCREEN_WIDTH ,!self.cycleFloat?XT(340):self.cycleFloat)];
        CGRect frame = self.imageView.frame;
        frame.size = size;
        self.imageView.frame = frame;
        [self setNeedsLayout];
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //    CGSize size = [self adapterSizeImageSize:self.imageView.image.size compareSize:CGSizeMake(KS_SCREEN_WIDTH , XT(210))];
    //    CGRect frame = self.imageView.frame;
    //    frame.size = size;
    //    self.imageView.frame = frame;
    //
    
}

- (CGSize)adapterSizeImageSize:(CGSize)is compareSize:(CGSize)cs
{
    // 宽度 = 屏幕宽度
    CGFloat w = cs.width;
    // 高度 = 屏幕宽度 / 相片的宽度 *  相片的高度
    CGFloat h = cs.width / is.width * is.height;
    
    // 如果 传进来的高度小于 算出来的 h 高度 就用: 宽度做处理
    if (h < cs.height) {
        w = cs.height / h * w;
        h = cs.height;
    }
    return CGSizeMake(w, h);
}




@end
