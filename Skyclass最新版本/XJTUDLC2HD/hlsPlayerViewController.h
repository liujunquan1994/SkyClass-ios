//
//  hlsPlayerViewController.h
//  XJTUDLC
//
//  Created by skyclass on 14-3-27.
//
//
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class LiveList;
@interface hlsPlayerViewController : UITableViewController
{
    NSTimer *timer;
}
@property(nonatomic,retain)LiveList *hlsMsg;
@property (weak, nonatomic) IBOutlet UILabel *classname;
@property (weak, nonatomic) IBOutlet UILabel *teachername;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property(strong,nonatomic)MPMoviePlayerViewController *movieplayer;

- (IBAction)playerTeacher:(id)sender;
- (IBAction)playerScreen:(id)sender;
-(void)showDetail;
-(void)playerinit:(NSURL *)url;
-(void)removeMovieViewFromViewHierarchy;
-(void)displayError:(NSError *)theError;
- (void) moviePlayBackDidFinish:(NSNotification*)notification;
-(void)installMovieNotificationObservers;
@end
