//
//  UIImage+HBUtil.m
//  HaoBan
//
//  Created by bing.hao on 2016/12/9.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "UIImage+HBUtil.h"

@implementation UIImage (HBUtil)

- (UIImage *)hbutil_imageWithTintColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)hbutil_dashImageWithSize:(CGSize)size color:(UIColor *)color {
    return [self hbutil_dashImageWithSize:size color:color dashWidth:2 spaceWidth:1.5];
}

+ (UIImage *)hbutil_dashImageWithSize:(CGSize)size color:(UIColor *)color dashWidth:(CGFloat)dashWidth spaceWidth:(CGFloat)spaceWidth {
    UIGraphicsBeginImageContext(size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度  1是高度
    CGFloat linePattern[] = {dashWidth, spaceWidth};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, color.CGColor);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), size.height);
    CGContextSetLineDash(line, 0, linePattern, 2);  //画虚线
    CGContextMoveToPoint(line, 0, 0);    //开始画线
    CGContextAddLineToPoint(line, size.width, 0);
    CGContextStrokePath(line);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


+(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self jpgImageSizeWithFilePath:(NSString *)imageURL];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}


+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request

{
    
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if(data.length == 8)
        
    {
        
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        
        return CGSizeMake(w, h);
        
    }
    
    return CGSizeZero;
    
}

+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request

{
    
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if(data.length == 4)
        
    {
        
        short w1 = 0, w2 = 0;
        
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        
        short w = w1 + (w2 << 8);
        
        short h1 = 0, h2 = 0;
        
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        
        short h = h1 + (h2 << 8);
        
        return CGSizeMake(w, h);
        
    }
    
    return CGSizeZero;
    
}


+ (CGSize)jpgImageSizeWithFilePath:(NSString *)filePath
{
    if (!filePath.length) {
        return CGSizeZero;
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return  CGSizeZero;
    }
    
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    NSUInteger offset = 2;
    NSUInteger length = 0;
    while (1) {
        [fileHandle seekToFileOffset:offset];
        length = 4;
        NSData *data = [fileHandle readDataOfLength:length];
        if (data.length != length) {
            break;
        }
        offset += length;
        int marker,code;
        NSUInteger newLength;
        unsigned char value1,value2,value3,value4;
        [data getBytes:&value1 range:NSMakeRange(0, 1)];
        [data getBytes:&value2 range:NSMakeRange(1, 1)];
        [data getBytes:&value3 range:NSMakeRange(2, 1)];
        [data getBytes:&value4 range:NSMakeRange(3, 1)];
        marker = value1;
        code = value2;
        newLength = (value3 << 8) + value4;
        if (marker != 0xff) {
            [fileHandle closeFile];
            return CGSizeZero;
        }
        
        if (code >= 0xc0 && code <= 0xc3) {
            length = 5;
            [fileHandle seekToFileOffset:offset];
            NSData *data =[fileHandle readDataOfLength:length];
            if (data.length != length) {
                break;
            }
            Byte *bytesArray = (Byte*)[data bytes];
            NSUInteger height = ((unsigned char)bytesArray[1] << 8) + (unsigned char)bytesArray[2];
            NSUInteger width =  ((unsigned char)bytesArray[3] << 8) + (unsigned char)bytesArray[4];
            [fileHandle closeFile];
            return CGSizeMake(width, height);
        }
        else {
            offset += newLength;
            offset -=2;
        }
    }
    [fileHandle closeFile];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (image) {
        CGSizeMake((NSInteger)image.size.width, (NSInteger)image.size.height);
    }
    return CGSizeZero;
    
}
@end
