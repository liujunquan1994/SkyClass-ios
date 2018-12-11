//
//  OMAnimUtil.m
//  meos-i
//
//  Created by shadow ren on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OMAnimUtil.h"
#import <QuartzCore/QuartzCore.h>
//#import "OMCellView.h"    //fg update

@implementation OMAnimUtil


#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
+ (void) animationKeyFramed: (CALayer *) layer 
                   delegate: (id) object
                     forKey: (NSString *) key {
    
    CAKeyframeAnimation *animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 0.5;
    animation.cumulative = YES;
    animation.repeatCount = NSIntegerMax;
    animation.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat: 0.0], 
                        [NSNumber numberWithFloat: RADIANS(-9.0)], 
                        [NSNumber numberWithFloat: 0.0],
                        [NSNumber numberWithFloat: RADIANS(9.0)],
                        [NSNumber numberWithFloat: 0.0], nil];
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.removedOnCompletion = NO;
    animation.delegate = object;
    
    [layer addAnimation:animation forKey:key];
}

+ (void)animateBasic: (CALayer *)layer
         withDeleage: (id)delegate
              forKey: (NSString *)key
{
    CABasicAnimation * anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [anim setToValue:[NSNumber numberWithFloat:RADIANS(2)]];
    [anim setFromValue:[NSNumber numberWithDouble:RADIANS(-2) ]];
    [anim setDuration:0.1];
    [anim setRepeatCount:NSUIntegerMax];
    [anim setAutoreverses:YES];
    anim.delegate = delegate;
    
    [layer addAnimation:anim forKey:key];
}


+ (void)animateRotate: (CALayer *)layer
         withDeleage: (id)delegate
              forKey: (NSString *)key
{
    CABasicAnimation * anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [anim setToValue:[NSNumber numberWithFloat:RADIANS(45)]];
    [anim setFromValue:[NSNumber numberWithDouble:RADIANS(0) ]];
    [anim setDuration:0.5];
    anim.delegate = delegate;
    [layer addAnimation:anim forKey:key];
}


+ (void)animatePostion: (CALayer *)layer
          wtihDelegate: (id)delegate
                forKey: (NSString *)key
{
    int offset = 2;
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"position"];
    [anim2 setDuration:0.1];
    [anim2 setRepeatCount:NSUIntegerMax];
    [anim2 setAutoreverses:YES];
    CGPoint curPos = layer.position;
    CGPoint toPos = CGPointMake(curPos.x+offset, curPos.y+offset);
    
    [anim2 setToValue:[NSValue valueWithCGPoint:toPos] ];
    [anim2 setFromValue:[NSValue valueWithCGPoint:curPos]];
    anim2.delegate = delegate;
    
    [layer addAnimation:anim2 forKey:key];
    
}

+ (void)animateScale: (CALayer *)layer
        withDelegate: (id)delegate
              forKey: (NSString *)key
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.3;
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)];
    [layer addAnimation:anim forKey:key];
}


+ (void)animateLongPress: (UIView *)saleView
{
    [OMAnimUtil animateScaleOut:saleView withOutFactor:1.2];
}


+ (void) animateScaleOut: (UIView *)scaleView withOutFactor: (float)outFactor
{
    [OMAnimUtil animateScaleOut:scaleView withOutFactor:outFactor withType:0];
}

+ (void) animateScaleOut: (UIView *)scaleView withOutFactor: (float)outFactor withType:(int)type
{
    [UIView beginAnimations:@"scale" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0];
    scaleView.transform = CGAffineTransformMakeScale(outFactor, outFactor);
    if(type == 0){
        scaleView.alpha = 0.7;
    }else if(type == 1) {
        scaleView.alpha = 0;
    }
    
    [UIView commitAnimations];
}


+ (void)animateRestore: (UIView *)scaleView withCenter: (CGPoint) newCenter 
{
    [UIView beginAnimations:@"scale" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0];
    scaleView.transform = CGAffineTransformIdentity;
    scaleView.alpha = 1;
    scaleView.center = newCenter;
    [UIView commitAnimations];
    
}



+ (void)animateSwitchIcon: (UIView *)scaleView 
               withCenter: (CGPoint) newCenter 
             withFoldView: (OMCellView *)foldView 
             withSrcIndex: (int)srcIndex 
          withTargetIndex: (int)targetIndex
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0];
    scaleView.transform = CGAffineTransformIdentity;
    scaleView.alpha = 1;
    scaleView.center = newCenter;
//    [foldView switchChildIcon:srcIndex toPageIndex:targetIndex];   //fg update
    [UIView commitAnimations];
}

@end
