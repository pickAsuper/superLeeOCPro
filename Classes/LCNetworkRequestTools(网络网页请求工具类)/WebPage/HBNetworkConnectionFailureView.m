//
//  HBNetworkConnectionFailureView.m
//  HaoBan
//
//  Created by super on 2017/4/18.
//  Copyright © 2016年 super. All rights reserved.
//

#import "HBNetworkConnectionFailureView.h"

@interface HBNetworkConnectionFailureView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;

@end

@implementation HBNetworkConnectionFailureView

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView imageViewWithName:@"4消息列表页_无消息提示_03.png"];
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.text = @"找不到网络\n错误代码404\n别紧张页面刷新试一试";
        _label.textColor = CHEX(0x666666);
        _label.font = FN(32);
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitleColor:CHEX(0x666666) forState:UIControlStateNormal];
        [_button setTitle:@"刷新" forState:UIControlStateNormal];
        [_button.titleLabel setFont:FN(24)];
        [_button setBorderColor:CHEX(0x666666)];
        [_button setBorderWidth:SINGLE_LINE_WIDTH];
        [_button setRadius:5];
        [_button addTarget:self action:@selector(buttonClickHandler:)];
    }
    return _button;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self myInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self myInit];
    }
    return self;
}

- (void)myInit {
    
    [self addSubview:self.imageView];
    [self addSubview:self.label];
    [self addSubview:self.button];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(PX(310), PX(230)));
        make.top.equalTo(self).offset(PX(180));
        make.centerX.equalTo(self);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView);
        make.top.equalTo(self.imageView.mas_bottom).offset(PX(58));
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(PX(140));
        make.centerX.equalTo(self.imageView);
        make.top.equalTo(self.label.mas_bottom).offset(PX(44));
        make.height.mas_equalTo(PX(48));
    }];
}

- (void)buttonClickHandler:(id)sender {
    if ([self.delegate respondsToSelector:@selector(HBNetworkConnectionFailureViewDidClickRefresh)]) {
        [self.delegate HBNetworkConnectionFailureViewDidClickRefresh];
    }
}

@end
