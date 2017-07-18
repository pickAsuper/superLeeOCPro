//
//  UIImage+HBUtil.h
//  HaoBan
//
//  Created by bing.hao on 2016/12/9.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HBUtil)

- (UIImage *)hbutil_imageWithTintColor:(UIColor *)color;

+ (UIImage *)hbutil_dashImageWithSize:(CGSize)size color:(UIColor *)color;

+ (UIImage *)hbutil_dashImageWithSize:(CGSize)size
                                color:(UIColor *)color
                            dashWidth:(CGFloat)dashWidth
                           spaceWidth:(CGFloat)spaceWidth;

+(CGSize)getImageSizeWithURL:(id)imageURL;

+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request;


+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request;

+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request;
@end
