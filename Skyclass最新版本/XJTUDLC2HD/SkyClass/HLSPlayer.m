//
//  HLSPlayer.m
//  SkyClass
//
//  Created by skyclass on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HLSPlayer.h"
#import "LiveList.h"
@interface HLSPlayer ()

@end

@implementation HLSPlayer
@synthesize hlsMsg=_hlsMsg;
@synthesize classname = _classname;
@synthesize teachername = _teachername;
@synthesize time = _time;
@synthesize myPlayer=_myPlayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showDetail];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setClassname:nil];
    [self setTeachername:nil];
    [self setTime:nil];
    [self setClassname:nil];
    [self setTeachername:nil];
    [self setTime:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)playerTeacher:(id)sender {
    NSLog(@"HLSurl %@",[self getTeacherURL]);
    
    if (_myPlayer) {
        [_myPlayer setContentURL:[self getTeacherURL]];
    }
    else {
        NSLog(@"init palyer");
        [self playerinit:[self getTeacherURL]];
        
    }
    NSLog(@"begin to play");
    
    UIWindow *backgroundWindow = [[UIApplication sharedApplication] keyWindow];
    [_myPlayer.view setFrame:backgroundWindow.frame];
    [backgroundWindow addSubview:_myPlayer.view];
    [_myPlayer prepareToPlay];    
    [_myPlayer play];
    timer= [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(check_state) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (IBAction)playerScreen:(id)sender {
    NSLog(@"HLSurl %@",[self getScreenURL]);
    
    if (_myPlayer) {
        [_myPlayer setContentURL:[self getScreenURL]];
    }
    else {
        NSLog(@"init palyer");
        [self playerinit:[self getScreenURL]];
        
    }
    NSLog(@"begin to play");
    UIWindow *backgroundWindow = [[UIApplication sharedApplication] keyWindow];
    [_myPlayer.view setFrame:backgroundWindow.frame];
    [backgroundWindow addSubview:_myPlayer.view];
    [_myPlayer prepareToPlay];    
    [_myPlayer play];
    timer= [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(check_state) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    
}
-(void)check_state{
    if ([_myPlayer loadState]==MPMovieLoadStateUnknown) {
        
        [self removeMovieViewFromViewHierarchy];
        [self deletePlayerAndNotificationObservers];
        NSError *error=[[NSError alloc]initWithDomain:@"加载超时" code:0 userInfo:nil];
        [self displayError:error];
    }
}
-(void)showDetail{

    self.title=self.hlsMsg.classname;
    self.classname.text=self.hlsMsg.classname;
    self.teachername.text=self.hlsMsg.teachername;
    self.time.text=self.hlsMsg.time;
}
-(NSURL*)getScreenURL
{
    NSArray *myarray=[self.hlsMsg.screenpath componentsSeparatedByString:@"?adbe-live-event="];
    return [NSURL URLWithString:[[NSString alloc]initWithFormat:@"http://%@:8134/hls-live/livepkgr/_definst_/%@/%@.m3u8",_hlsMsg.serverpath,[myarray objectAtIndex:1],[myarray objectAtIndex:0]]];
}
-(NSURL*)getTeacherURL
{
    NSArray *myarray=[self.hlsMsg.videopath componentsSeparatedByString:@"?adbe-live-event="];
    
    return [NSURL URLWithString:[[NSString alloc]initWithFormat:@"http://%@:8134/hls-live/livepkgr/_definst_/%@/%@.m3u8",_hlsMsg.serverpath,[myarray objectAtIndex:1],[myarray objectAtIndex:0]]];
}
-(void)playerinit:(NSURL *)url{
    _myPlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
    _myPlayer.controlStyle=MPMovieControlStyleFullscreen;
    _myPlayer.shouldAutoplay=NO;
    _myPlayer.movieSourceType=MPMovieSourceTypeStreaming;
    [self installMovieNotificationObservers];
    _myPlayer.view.transform = CGAffineTransformConcat(_myPlayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
    
}
-(void)removeMovieViewFromViewHierarchy
{
    MPMoviePlayerController *player = _myPlayer;
    
	[player.view removeFromSuperview];
}

-(void)installMovieNotificationObservers
{
    MPMoviePlayerController *player = _myPlayer;
    
	[[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(loadStateDidChange:) 
                                                 name:MPMoviePlayerLoadStateDidChangeNotification 
                                               object:player];
    
	[[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(moviePlayBackDidFinish:) 
                                                 name:MPMoviePlayerPlaybackDidFinishNotification 
                                               object:player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(mediaIsPreparedToPlayDidChange:) 
                                                 name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification 
                                               object:player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(moviePlayBackStateDidChange:) 
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification 
                                               object:player];        
    
}
-(void)removeMovieNotificationHandlers
{    
    MPMoviePlayerController *player = _myPlayer;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:player];    
}
-(void)deletePlayerAndNotificationObservers
{
    [self removeMovieNotificationHandlers];
    _myPlayer=nil;
}
- (void) moviePlayBackStateDidChange:(NSNotification*)notification
{
	MPMoviePlayerController *player = notification.object;
    
	/* Playback is currently stopped. */
	if (player.playbackState == MPMoviePlaybackStateStopped) 
	{
        NSLog(@"PlayBackState stopped");
	}
	/*  Playback is currently under way. */
	else if (player.playbackState == MPMoviePlaybackStatePlaying) 
	{
        NSLog(@"PlayBackState playing");
        
	}
	/* Playback is currently paused. */
	else if (player.playbackState == MPMoviePlaybackStatePaused) 
	{
        NSLog(@"PlayBackState paused");
	}
	/* Playback is temporarily interrupted, perhaps because the buffer 
	 ran out of content. */
	else if (player.playbackState == MPMoviePlaybackStateInterrupted) 
	{
        NSLog(@"PlayBackState interrupted");
	}
}
- (void) mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
	// Add an overlay view on top of the movie view
    NSLog(@"mediaIsPreparedToPlayDidChange");
}
- (void)loadStateDidChange:(NSNotification *)notification 
{   
	MPMoviePlayerController *player = notification.object;
	MPMovieLoadState loadState = player.loadState;	
    
	/* The load state is not known at this time. */
	if (loadState & MPMovieLoadStateUnknown)
	{
        NSLog(@"loadstate:unkown");
	}
	
	/* The buffer has enough data that playback can begin, but it 
	 may run out of data before playback finishes. */
	if (loadState & MPMovieLoadStatePlayable)
	{
        NSLog(@"loadstate:playable");
        [timer invalidate];
        
	}
	
	/* Enough data has been buffered for playback to continue uninterrupted. */
	if (loadState & MPMovieLoadStatePlaythroughOK)
	{
        NSLog(@"loadstate:playthrough ok");
        
    }
	
	/* The buffering of data has stalled. */
	if (loadState & MPMovieLoadStateStalled)
	{
        NSLog(@"loadstate:stalled");
	}
}
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    NSLog(@"moviePlayBackDidFinish");
    NSNumber *reason = [[notification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey]; 
	switch ([reason integerValue]) 
	{
            /* The end of the movie was reached. */
		case MPMovieFinishReasonPlaybackEnded:
            /*
             Add your code here to handle MPMovieFinishReasonPlaybackEnded.
             */
            [self removeMovieViewFromViewHierarchy];
            
            [self deletePlayerAndNotificationObservers];
            
			break;
            
            /* An error was encountered during playback. */
		case MPMovieFinishReasonPlaybackError:
            NSLog(@"An error was encountered during playback");
            [self performSelectorOnMainThread:@selector(displayError:) withObject:[[notification userInfo] objectForKey:@"error"] 
                                waitUntilDone:NO];
            [self removeMovieViewFromViewHierarchy];
            [self deletePlayerAndNotificationObservers];
            
			break;
            
            /* The user stopped playback. */
		case MPMovieFinishReasonUserExited:
            [self removeMovieViewFromViewHierarchy];
            [self deletePlayerAndNotificationObservers];
			break;
            
		default:
            
			break;
	}
    [timer invalidate];
    [self removeMovieViewFromViewHierarchy];
    [self deletePlayerAndNotificationObservers];
}
-(void)displayError:(NSError *)theError
{
	if (theError)
	{
		UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error"
                              message: [theError localizedDescription]
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
		[alert show];
	}
}

@end
