//
//  HLSPlayer.h
//  SkyClass
//
//  Created by skyclass on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class LiveList;
@interface HLSPlayer : UIViewController
{
    NSTimer *timer;
}
@property(nonatomic,retain)LiveList *hlsMsg;
@property (weak, nonatomic) IBOutlet UILabel *classname;
@property (weak, nonatomic) IBOutlet UILabel *teachername;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property(nonatomic,retain)MPMoviePlayerController *myPlayer;

- (IBAction)playerTeacher:(id)sender;
- (IBAction)playerScreen:(id)sender;
-(void)showDetail;
-(void)playerinit:(NSURL *)url;
-(void)removeMovieViewFromViewHierarchy;
-(void)displayError:(NSError *)theError;
- (void) moviePlayBackDidFinish:(NSNotification*)notification;
-(void)installMovieNotificationObservers;
@end
