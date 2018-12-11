//
//  hlsPlayerViewController.m
//  XJTUDLC
//
//  Created by skyclass on 14-3-27.
//
//

#import "hlsPlayerViewController.h"
#import "LiveList.h"
#import "Reachability.h"
#import "KRVideoPlayerController.h"

@interface hlsPlayerViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) KRVideoPlayerController *videoController;
@end

@implementation hlsPlayerViewController
@synthesize hlsMsg=_hlsMsg;
@synthesize classname = _classname;
@synthesize teachername = _teachername;
@synthesize time = _time;
//@synthesize myPlayer=_myPlayer;
@synthesize movieplayer= _movieplayer;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showDetail];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playerTeacher:(id)sender {
    
    //通过时间来判断是否开课
    
    if ([self.hlsMsg.time isEqualToString:@"0000-00-00 00:00:00"]) {
        NSLog(@"no class");
        //self.teacherButton.selected = NO;
        [self alert_noClass];
        
    }else if([self checkNetwork:[self getTeacherString]])
    {
        NSLog(@"have class");
        NSLog(@"HLSurl %@",[self getTeacherURL]);
        if ([self getTeacherURL]) {
            [self playVideoWithURL:[self getTeacherURL]];
            /*
            //获得URL
            _movieplayer=[[MPMoviePlayerViewController alloc]initWithContentURL:[self getTeacherURL]];
            
            //改变播放器方向
            _movieplayer.view.transform = CGAffineTransformConcat(_movieplayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
            _movieplayer.moviePlayer.shouldAutoplay = YES;
            //显示播放页面
            [self presentMoviePlayerViewControllerAnimated:_movieplayer];
            [self installMovieNotificationObservers];
            
            timer  = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(check_state) userInfo:nil repeats:NO];
            [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];*/
            
        }
        else{
            [self alert_error];
        }
        
    }
    
}

- (IBAction)playerScreen:(id)sender {
    
    //判断是否开课
    if ([self.hlsMsg.time isEqualToString:@"0000-00-00 00:00:00"]) {
        NSLog(@"no class");
        
        //self.teacherButton.selected = NO;
        [self alert_noClass];
        
    }else if([self checkNetwork:[self getTeacherString]])
        
    {
        NSLog(@"HLSurl %@",[self getScreenURL]);
        if ([self getScreenURL]) {
            [self playVideoWithURL:[self getScreenURL]];
            /*
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
             */
            /*
            _movieplayer=[[MPMoviePlayerViewController alloc]initWithContentURL:[self getScreenURL]];
            _movieplayer.view.transform = CGAffineTransformConcat(_movieplayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
            [self presentMoviePlayerViewControllerAnimated:_movieplayer];
            [self installMovieNotificationObservers];
            
            timer= [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(check_state) userInfo:nil repeats:NO];
            [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
             */
            
        }
        else{
            [self alert_error];
        }
    }
    
    
}

//检查网络状况


-(BOOL)checkNetwork:(NSString *)url{
    Reachability *reachable=[Reachability reachabilityWithHostName:@"www.xjtudlc.com"];
    switch ([reachable currentReachabilityStatus]) {
        case NotReachable:
        {
            NSLog(@"无网络");
            NSError *error=[[NSError alloc]initWithDomain:@"无网络" code:0 userInfo:nil];
            [self displayError:error];
            return NO;
        }
            break;
        case ReachableViaWWAN:
            
            return YES;
            
            break;
        case ReachableViaWiFi:
            
            return YES;
            break;
            
        default:
            return YES;
            break;
    }
    
}


-(void)check_state{
    if ([_movieplayer.moviePlayer loadState] == MPMovieLoadStateUnknown) {
        
        [self removeMovieViewFromViewHierarchy];
        [self deletePlayerAndNotificationObservers];
        NSError *error=[[NSError alloc]initWithDomain:@"加载超时" code:1 userInfo:nil];
        [self displayError:error];
    }
}
-(void)showDetail{
    
    self.title=self.hlsMsg.classname;
    self.classname.text=self.hlsMsg.classname;
    self.teachername.text=self.hlsMsg.teachername;
    self.time.text=self.hlsMsg.time;
    NSLog(@"time:%@",self.hlsMsg.time);
}

-(NSString*)getScreenString
{
    return [[NSString alloc]initWithFormat:@"http://%@:8134/hls-live/%@/_definst_/%@/%@.m3u8",_hlsMsg.serverpath,_hlsMsg.location,_hlsMsg.screenpath,_hlsMsg.screenpath];
}
-(NSURL*)getScreenURL
{
    return [NSURL URLWithString:[self getScreenString]];
}
-(NSURL*)getTeacherURL
{
    return [NSURL URLWithString:[self getTeacherString]];
    
    
    
}

-(NSString*)getTeacherString
{
    return [[NSString alloc]initWithFormat:@"http://%@:8134/hls-live/%@/_definst_/%@/%@.m3u8",_hlsMsg.serverpath,_hlsMsg.location,_hlsMsg.videopath,_hlsMsg.videopath];
    
    
    
}
-(void)removeMovieViewFromViewHierarchy
{
    //    MPMoviePlayerController *player = _movieplayer.moviePlayer;
    //
    //	[player.view removeFromSuperview];
    _movieplayer=nil;
    [self dismissMoviePlayerViewControllerAnimated];
}
//注册通知
-(void)installMovieNotificationObservers
{
    MPMoviePlayerController *player = _movieplayer.moviePlayer;
    
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

//移除通知
-(void)removeMovieNotificationHandlers
{
    MPMoviePlayerController *player = _movieplayer.moviePlayer;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:player];
}
-(void)deletePlayerAndNotificationObservers
{
    [self removeMovieNotificationHandlers];
    _movieplayer=nil;
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

//网络加载状态改变
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
                              delegate: self
                              cancelButtonTitle:@"继续加载"
                              otherButtonTitles:@"取消", nil];
        [alert show];
    }
}

-(void)alert_error{
    
    UIAlertView *alert_error= [[UIAlertView alloc] initWithTitle:@"不支持的直播" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert_error show];
}
-(void)alert_noClass{
    
    UIAlertView *alert_error= [[UIAlertView alloc] initWithTitle:@"没有直播课程" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert_error show];
}


-(void)playVideoWithURL:(NSURL *)url{
    
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}


@end
