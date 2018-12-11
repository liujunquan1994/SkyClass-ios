//
//  OMAnimUtil.h
//  meos-i
//
//  Created by shadow ren on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OMCellView;

@interface OMAnimUtil : NSObject

+ (void) animationKeyFramed: (CALayer *) layer 
                   delegate: (id) object
                     forKey: (NSString *) key;

+ (void)animateBasic: (CALayer *)layer
         withDeleage: (id)delegate
              forKey: (NSString *)key;

+ (void)animateRotate: (CALayer *)layer
          withDeleage: (id)delegate
               forKey: (NSString *)key;

+ (void)animatePostion: (CALayer *)layer
          wtihDelegate: (id)delegate
                forKey: (NSString *)key;

+ (void)animateScale: (CALayer *)layer
        withDelegate: (id)delegate
              forKey: (NSString *)key;

+ (void)animateLongPress: (UIView *)saleView;
+ (void)animateRestore: (UIView *)scaleView withCenter: (CGPoint) newCenter;

+ (void)animateSwitchIcon: (UIView *)scaleView 
               withCenter: (CGPoint) newCenter 
             withFoldView: (OMCellView *)foldView 
             withSrcIndex: (int)srcIndex 
          withTargetIndex: (int)targetIndex;

+ (void)animateScaleOut: (UIView *)scaleView withOutFactor: (float)outFactor;
+ (void)animateScaleOut: (UIView *)scaleView withOutFactor: (float)outFactor withType: (int)type;
@end
