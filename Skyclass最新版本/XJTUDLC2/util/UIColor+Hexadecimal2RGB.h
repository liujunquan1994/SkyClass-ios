//
//  UIColor+Hexadecimal2RGB.h
//  LearningBar
//
//  Created by fenguo on 13-9-5.
//  Copyright (c) 2013年 open. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hexadecimal2RGB)

+ (UIColor *)colorWithHex:(UInt32)col withAlpha:(float)alpha;
+ (UIColor *)colorWithHexString:(NSString *)str withAlpha:(float)alpha;

@end
