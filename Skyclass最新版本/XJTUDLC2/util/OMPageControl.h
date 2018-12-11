//
//  OMPageControl.h
//  meos-i
//
//  Created by shadow ren on 12-4-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMPageControl : UIPageControl {
    UIImage* mImageNormal;
    UIImage* mImageCurrent;
    int imageIndex;
}

@property (nonatomic, readwrite, retain) UIImage *imageNormal;
@property (nonatomic, readwrite, retain) UIImage *imageCurrent;

@end
