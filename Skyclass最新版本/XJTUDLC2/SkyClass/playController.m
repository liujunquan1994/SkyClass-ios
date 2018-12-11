//
//  playController.m
//  skyclass
//
//  Created by skyclass on 15/4/27.
//
//

#import "playController.h"


@implementation playController

@synthesize state= _state;
@synthesize startPauseTime =_startPauseTime;
@synthesize startSeekingTime=_startSeekingTime;
@synthesize stopPauseTime =_stopPauseTime;
@synthesize stopSeekingTime=_stopSeekingTime;
NSString * playing=@"playing";
NSString * paused = @"paused";
NSString * seeking= @"seeking";
CGFloat kMovieViewOffsetX = 20.0;
CGFloat kMovieViewOffsetY = 20.0;
long int  pauseTime=0;
long int  seekingTime=0;

-(void)play:(NSString *)urlStr{
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    NSLog(@"play urlstr %@",url);
    _movieplayer=[[MPMoviePlayerViewController alloc]initWithContentURL:url];
    //_movieplayer.controlStyle=MPMovieControlStyleFullscreen;
    //_movieplayer.shouldAutoplay=NO;
    //[_movieplayer setScalingMode:MPMovieScalingModeNone];
    //[_movieplayer setFullscreen:YES];
    [self presentMoviePlayerViewControllerAnimated:_movieplayer];
    /*  _movieplayer.view.transform = CGAffineTransformConcat(_movieplayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
     
     //CGRect aFrame = backgroundWindow.frame;
     //aFrame = CGRectMake(0, 0, aFrame.size.height, aFrame.size.width);
     //  _movieplayer.controlStyle = MPMovieControlStyleNone;
     // _movieplayer.view.frame = aFrame;
     
     CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
     [_movieplayer.view setTransform:transform];
     [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
     */
    
    //_movieplayer.view.transform = CGAffineTransformConcat(_movieplayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
    
   // UIWindow *backgroundWindow = [[UIApplication sharedApplication] keyWindow];
    //[_movieplayer.view setFrame:backgroundWindow.frame];
    //NSLog(@"frame:%f,%f,%f,%f",_movieplayer.view.frame.origin.x,_movieplayer.view.frame.origin.y,_movieplayer.view.frame.size.height,_movieplayer.view.frame.size.width);
    //[backgroundWindow addSubview:_movieplayer.view];
    
    _state =@"playing";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playMovieFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieplayer];//注册通知：Finish
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayDone:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:self.movieplayer];//注册通知：Done
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:self.movieplayer];//注册通知：state
    
    
    //获取播放时间
    
    NSString *time = [self gettime];
    _beginTime=time;
    _log.time=time;
    _log.operationID=@"1";
    [getData insertLog:_log];
    
    //NSLog(@"play url:%@",_movieplayer.contentURL);
    NSLog(@"Open time is %@",time);
    //[_movieplayer play];//开始播放
    
}
-(void)playOnline:(NSString *)urlStr{
    NSURL *url=[NSURL URLWithString:urlStr];
    NSLog(@"play urlstr %@",url);
    _movieplayer = [ [ MPMoviePlayerViewController alloc]initWithContentURL:url];
   // _movieplayer.controlStyle=MPMovieControlStyleFullscreen;
    
    //_movieplayer.shouldAutoplay=NO;
    //_movieplayer.scalingMode =MPMovieScalingModeFill;
    //_movieplayer.scalingMode = MPMovieScalingModeAspectFit;
    _movieplayer.view.transform =  (_movieplayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
    /* Inset the movie frame in the parent view frame. */
    //CGRect frame ;
    //frame.origin.x = round((self.view.frame.size.width - frame.size.width) / 2.0);
    //frame.origin.y = round((self.view.frame.size.height - frame.size.height) / 2.0);
    
    
    UIWindow *backgroundWindow = [[UIApplication sharedApplication] keyWindow];
    // backgroundWindow.frame=frame;
    [_movieplayer.view setFrame:backgroundWindow.frame];
    [backgroundWindow addSubview:_movieplayer.view];
    _state =@"playing";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playMovieFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieplayer];//注册通知：Finish
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayDone:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:self.movieplayer];//注册通知：Done
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:self.movieplayer];//注册通知：state
    
    
    //获取播放时间
    
    NSString *time = [self gettime];
    _beginTime=time;
    _log.time=time;
    _log.operationID=@"1";
    [getData insertLog:_log];
    
  //  NSLog(@"play url:%@",_movieplayer.contentURL);
    NSLog(@"Open time is %@",time);
    
    //[_movieplayer play];//开始播放
    
}
-(void)playMovieFinished:(NSNotification*)theNotification
{
    [self removeMovieNotificationHandlers];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieplayer];
    NSLog(@"Finish");
    NSString *finish_time = [self gettime];
    _log.time=finish_time;
    _log.operationID=@"2";
    long int tempTime;
    tempTime= [_log.len intValue];
    _log.len=[self timeInterval:finish_time data2:_beginTime];
    tempTime= [_log.len intValue];
    NSLog(@"tempTime = %ld",tempTime);
    pauseTime =tempTime -pauseTime ;
    _log.len = [NSString stringWithFormat:@"%ld",pauseTime];
    NSLog(@"_log.len = %@",_log.len);
    pauseTime=0;
    if ([_log.len intValue]>0) {
        [getData insertLog:_log];
    }
    
    [_movieplayer.view removeFromSuperview];
    NSLog(@"Finish time is %@ len is %@",finish_time,_log.len);
}

-(void)moviePlayDone:(NSNotification*)theNotification
{  // [self removeMovieNotificationHandlers];
    
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerDidExitFullscreenNotification object:_movieplayer];
    NSString *time = [self gettime];
    _log.time=time;
    _log.operationID=@"2";
    
    long int tempTime;
    tempTime= [_log.len intValue];
    _log.len=[self timeInterval:time data2:_beginTime];
    tempTime= [_log.len intValue];
    pauseTime =tempTime -pauseTime ;
    //_log.len = [NSString stringWithFormat:@"%f",pauseTime];
    _log.len = [NSString stringWithFormat:@"%ld",pauseTime];
    
    NSLog(@"_log.len = %@",_log.len);
    pauseTime=0;
    if ([_log.len intValue]>0) {
        [getData insertLog:_log];
    }
    NSLog(@"Done time is %@ len is %@",time,_log.len);
    
    
}
-(void)removeMovieNotificationHandlers
{
    MPMoviePlayerController *player = [self movieplayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:_movieplayer];
}

- (void) moviePlayBackStateDidChange:(NSNotification*)notification
{
    MPMoviePlayerController *player = notification.object;
    
    /* Playback is currently stopped. */
    if (player.playbackState == MPMoviePlaybackStateStopped)
    {
        
    }/*  Playback is currently under way. */
    else if (player.playbackState == MPMoviePlaybackStatePlaying)
    {
        // NSLog(@"playing");
        if ([_state isEqualToString:seeking]) {
            _stopSeekingTime = [player currentPlaybackTime];
            _log.operationID=@"4";
            seekingTime =_stopSeekingTime - _startSeekingTime;
            _log.len = [NSString stringWithFormat:@"%ld",seekingTime];
            
            // _log.len= [NSString stringWithFormat:  @"%f",_stopSeekingTime - _startSeekingTime ];
            //_log.time = [NSString stringWithFormat: @"%f",_startSeekingTime];
            NSLog(@"_log.time=%@",_log.time);
            [getData insertLog:_log];
            NSLog(@"seeking   _log.operationID =%@ _log.len = %@,_startSeekingTime=%f _stopSeekingTime=%f",_log.operationID,_log.len,_startSeekingTime,_stopSeekingTime);
        }
        else if ([_state isEqualToString:paused])
        {
            _stopPauseTime = [self gettime];
            _log.operationID =@"3";
            _log.len = [self timeInterval:_stopPauseTime data2:_startPauseTime];
            _log.time = _startPauseTime;
            pauseTime = pauseTime +[_log.len  floatValue];
            [getData insertLog:_log];
            NSLog(@" pauseTime = %ld",pauseTime);
            NSLog(@" paused  _log.operationID =%@ _log.len = %@_startPauseTime=%@ _stopPausedTime =%@",_log.operationID,_log.len,_startPauseTime,_stopPauseTime);
            
        }
        _state =playing;
        
    }
    /* Playback is currently paused. */
    else if (player.playbackState == MPMoviePlaybackStatePaused)
    {
        //  NSLog(@"paused");
        if([_state isEqualToString: playing])
            
        {
            _startPauseTime =[self gettime];
            NSLog(@"_startPauseTime =%@",_startPauseTime);
        }
        else if([_state isEqualToString:seeking])
        {
            _stopSeekingTime = [player currentPlaybackTime];
            _log.operationID=@"4";
            seekingTime =_stopSeekingTime - _startSeekingTime;
            _log.len = [NSString stringWithFormat:@"%ld",seekingTime];
            // _log.len= [NSString stringWithFormat:  @"%f",_stopSeekingTime - _startSeekingTime ];
            //   _log.time = [NSString stringWithFormat: @"%f",_startSeekingTime];
            NSLog(@"_log.time=%@",_log.time);
            [getData insertLog:_log];
            NSLog(@"seeking   _log.operationID =%@ _log.len = %@_startSeekingTime=%f",_log.operationID,_log.len,_startSeekingTime);
            
            
        }
        _state =paused;
    }
    /* Playback is temporarily interrupted, perhaps because the buffer
     ran out of content. */
    else if (player.playbackState == MPMoviePlaybackStateInterrupted)
    {
    }
    else if (player.playbackState == MPMoviePlaybackStateSeekingBackward)
    {
        NSLog(@"SeekingBackward");
        _startSeekingTime =[player currentPlaybackTime];
        _log.time = [self gettime];
        NSLog(@"_startSeekingTime = %f",_startSeekingTime);
        _state = seeking;
        
        
    }
    else if (player.playbackState == MPMoviePlaybackStateSeekingForward)
    {
        NSLog(@"SeekingForward");
        if ([_state isEqualToString:paused])
        {
            _startSeekingTime =[player currentPlaybackTime];
            _log.time = [self gettime];
            NSLog(@"_startSeekingTime = %f",_startSeekingTime);
        }
        else
        {
            NSLog(@"error");
            
        }
        _state = seeking;
        
        
    }
}


-(NSString *)gettime{
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    return morelocationString;
    
}
-(NSString *)timeInterval:(NSString *)data1 data2:(NSString *)data2{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *data_1=[dateformatter dateFromString:data1];
    NSDate *data_2=[dateformatter dateFromString:data2];
    NSTimeInterval time=[data_1 timeIntervalSinceDate:data_2];
    NSString *timeStr=[[NSString alloc]initWithFormat:@"%d",(int)time];
    return timeStr;
    
}

-(void)alert{
    UIAlertView *alert_success= [[UIAlertView alloc] initWithTitle:@"课程正在建设" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert_success show];
}

@end
