//
//  OMUILabel.m
//  meos-i
//
//  Created by zhangfengguo on 12-5-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OMUILabel.h"

@implementation OMUILabel

@synthesize backTextColor=_backTextColor, backTextLineWidth=_backTextLineWidth;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, _backTextLineWidth);
    CGContextSetLineJoin(c, kCGLineJoinMiter);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = _backTextColor;
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
}


@end
