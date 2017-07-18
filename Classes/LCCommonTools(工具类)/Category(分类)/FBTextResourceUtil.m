//
//  FBTextResourceUtil.m
//  FamilyBaby
//
//  Created by super on 16/7/12.
//  Copyright © 2016年 tsingda. All rights reserved.
//

#import "FBTextResourceUtil.h"

@implementation FBTextResourceUtil

+ (float)measureMutilineStringHeight:(NSString*)str andFont:(UIFont*)wordFont andWidthSetup:(float)width{
   
    if (str == nil || width <= 0) return 0;
    CGSize measureSize;
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    }else{
        measureSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
    }
    return ceil(measureSize.height);
}

// 传一个字符串和字体大小来返回一个字符串所占的宽度
+ (float)measureSinglelineStringWidth:(NSString*)str andFont:(UIFont*)wordFont{
   
    if (str == nil) return 0;
    CGSize measureSize;
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    }else{
        measureSize = [str boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
    }
    return ceil(measureSize.width);
}

+ (CGSize)measureSinglelineStringSize:(NSString*)str andFont:(UIFont*)wordFont
{
    if (str == nil) return CGSizeZero;
    CGSize measureSize;
    
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
    
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
   
    }else{
      
        measureSize = [str boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
    }
    return measureSize;
}

//+(UIImage*)imageAt:(NSString*)imgNamePath{
//    if (imgNamePath == nil || [[imgNamePath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) {
//        return nil;
//    }
//    return [UIImage imageNamed:[ImageResourceBundleName stringByAppendingPathComponent:imgNamePath]];
//}

+ (BOOL)xsdkcheckName:(NSString*)name{
    if([FBTextResourceUtil xsdkstringIsnilOrEmpty:name]){
    
        return NO;
  
    }else{
        if(name.length < 5){
            return NO;
        }
        
        if(name.length > 20){
            return NO;
        }
        
        NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z][a-zA-Z0-9_]*$"];
        if(![pred evaluateWithObject:name]){
            return [FBTextResourceUtil xsdkcheckPhone:name];
        }
    }
    return YES;
}

+ (BOOL)xsdkcheckPhone:(NSString *)userphone
{
    NSPredicate * phone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1\\d{10}"];
    if (![phone evaluateWithObject:userphone]) {
        return NO;
    }
    return YES;
}

+ (BOOL)xsdkstringIsnilOrEmpty:(NSString*)string{
    if (string == nil || [string isKindOfClass:[NSNull class]]  || [string isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}

+ (UIColor *)xsdkcolorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    //
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    //
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    //
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    //
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (BOOL)jsonFieldIsNull:(id)jsonField{
    return (jsonField == nil || [jsonField isKindOfClass:[NSNull class]]);
}

+ (int)filterIntValue:(id)value withDefaultValue:(int)defaultValue{
    if (![FBTextResourceUtil jsonFieldIsNull:value]) {
        return [value intValue];
    }else{
        return defaultValue;
    }
}

+ (NSString*)filterStringValue:(id)value withDefaultValue:(NSString*)defaultValue{
    if ([value isKindOfClass:[NSString class]] && ![FBTextResourceUtil xsdkstringIsnilOrEmpty:value]) {
        return value;
    }else{
        return defaultValue;
    }
}

@end
