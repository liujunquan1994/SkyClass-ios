//
//  UIImage+imageByApplyingAlpha.h
//  LearningBar
//
//  Created by fenguo on 13-9-10.
//  Copyright (c) 2013年 open. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (imageByApplyingAlpha)

/* 按照参数alpha 的值，更改图片的透明度。 */
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;

/* 剪切图片为圆角，参数size 是剪切后的尺寸，参数corner 是圆角的半径。 */
-(UIImage *)image2RoundedWithSize:(CGRect)size withCorner:(float)corner;

@end
