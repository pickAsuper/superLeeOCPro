//
//  HBAvatarView.m
//  HaoBan
//
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "HBAvatarView.h"

@interface HBAvatarView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *defaultAvatarImage;

@end

@implementation HBAvatarView

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UIImage *)defaultAvatarImage {
    if (_defaultAvatarImage == nil) {
        _defaultAvatarImage = [UIImage imageNamed:@"AvatarDefaultImage@2x.jpg"];
    }
    return _defaultAvatarImage;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setURLString:(NSString *)URLString {
    _URLString = URLString;
    if (URLString == nil) {
        [self.imageView setImage:self.defaultAvatarImage];
    } else {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_URLString]
                          placeholderImage:self.defaultAvatarImage
                                 completed:nil];
    }
}

@end
