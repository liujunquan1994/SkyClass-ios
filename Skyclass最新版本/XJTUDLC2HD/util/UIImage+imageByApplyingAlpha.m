//
//  UIImage+imageByApplyingAlpha.m
//  LearningBar
//
//  Created by fenguo on 13-9-10.
//  Copyright (c) 2013年 open. All rights reserved.
//

#import "UIImage+imageByApplyingAlpha.h"

@implementation UIImage (imageByApplyingAlpha)

- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(UIImage *)image2RoundedWithSize:(CGRect)rect withCorner:(float)corner
{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:corner] addClip];
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
