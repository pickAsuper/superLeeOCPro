//
//  FBVerticalButton.m
//  FamilyBaby
//
//  Created by super on 16/6/15.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "FBVerticalButton.h"
#import <UIImageView+WebCache.h>
#import <KSToolkit.h>
#import <Masonry.h>
@implementation FBVerticalButton

- (void)setup
{
    
// //   self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];

}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];

    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    KS_WS(weakSelf);

    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(50);
        make.center.mas_equalTo(weakSelf.center);
        
    }];

    
}
@end
