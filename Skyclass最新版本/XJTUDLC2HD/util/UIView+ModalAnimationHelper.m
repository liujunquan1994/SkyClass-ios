//
//  UIView+ModalAnimationHelper.m
//  meos-i
//
//  Created by shadow ren on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+ModalAnimationHelper.h"


@interface UIViewDelegate : NSObject
{
	CFRunLoopRef currentLoop;
}
@end

@implementation UIViewDelegate
-(id) initWithRunLoop: (CFRunLoopRef)runLoop 
{
	if (self = [super init]) currentLoop = runLoop;
	return self;
}

-(void) animationFinished: (id) sender
{
	CFRunLoopStop(currentLoop);
}
@end

@implementation UIView (ModalAnimationHelper)
+ (void) commitModalAnimations
{
	CFRunLoopRef currentLoop = CFRunLoopGetCurrent();
	
	UIViewDelegate *uivdelegate = [[UIViewDelegate alloc] initWithRunLoop:currentLoop];
	[UIView setAnimationDelegate:uivdelegate];
	[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
	[UIView commitAnimations];
	CFRunLoopRun();
	[uivdelegate release];
}

+(void) stopModalAnimations
{
    CFRunLoopRef currentLoop = CFRunLoopGetCurrent();
    CFRunLoopStop(currentLoop);
}
@end
