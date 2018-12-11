//
//  UIColor+Hexadecimal2RGB.m
//  LearningBar
//
//  Created by fenguo on 13-9-5.
//  Copyright (c) 2013年 open. All rights reserved.
//

#import "UIColor+Hexadecimal2RGB.h"

@implementation UIColor (Hexadecimal2RGB)

// takes @"#123456"
+ (UIColor *)colorWithHexString:(NSString *)str withAlpha:(float)alpha {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [UIColor colorWithHex:x withAlpha:alpha];
}

// takes 0x123456
+ (UIColor *)colorWithHex:(UInt32)col withAlpha:(float)alpha {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:alpha];
}

@end
