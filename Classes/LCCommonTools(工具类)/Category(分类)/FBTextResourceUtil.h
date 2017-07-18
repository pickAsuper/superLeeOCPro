//
//  FBTextResourceUtil.h
//  FamilyBaby
//
//  Created by super on 16/7/12.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FBTextResourceUtil : NSObject

/**
 *  获取字符串宽
 */
+ (CGSize)measureSinglelineStringSize:(NSString*)str andFont:(UIFont*)wordFont;

/**
 *  获取字符串宽 // 传一个字符串和字体大小来返回一个字符串所占的宽度
 */
+ (float)measureSinglelineStringWidth:(NSString*)str andFont:(UIFont*)wordFont;

/**
 *  获取字符串高 // 传一个字符串和字体大小来返回一个字符串所占的高度
 */
+ (float)measureMutilineStringHeight:(NSString*)str andFont:(UIFont*)wordFont andWidthSetup:(float)width;

+ (UIImage*)imageAt:(NSString*)imgNamePath;

+ (BOOL)xsdkcheckName:(NSString*)name;

+ (BOOL)xsdkcheckPhone:(NSString *)userphone;

+ (UIColor *)xsdkcolorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (BOOL)xsdkstringIsnilOrEmpty:(NSString*)string;

+ (BOOL)jsonFieldIsNull:(id)jsonField;

+ (int)filterIntValue:(id)value withDefaultValue:(int)defaultValue;

+ (NSString*)filterStringValue:(id)value withDefaultValue:(NSString*)defaultValue;

@end
