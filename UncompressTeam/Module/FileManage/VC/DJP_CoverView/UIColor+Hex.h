//
//  UIColor+Hex.h
//  PrettyPatPlayerPlayer
//
//  Created by xingcanzhu on 2018/6/1.
//  Copyright © 2018年 wache. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 Creates a Color from a Hex number.
 Alpha default is 1.0f.
 @param hexValue   Hex number that like 0xFF0000
 @return   Color
 */
+ (instancetype)colorWithHex:(NSInteger)hexValue;

/**
 Creates a Color from a Hex number
 @param hexValue   Hex number that like 0xFF0000
 @param    alpha    float number
 @return   Color
 */
+ (instancetype)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString;
@end
