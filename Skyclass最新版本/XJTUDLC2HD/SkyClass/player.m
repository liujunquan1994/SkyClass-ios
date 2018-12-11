//
//  player.m
//  XJTUDLC
//
//  Created by skyclass on 14-4-3.
//
//

#import "player.h"

@implementation player
@synthesize movieplayer=_movieplayer;
@synthesize file=_file;
@synthesize courseID=_courseID;
-(void)play{
    NSURL *url=[[NSURL alloc]initWithString:_file.filePath];
    _movieplayer = [ [ MPMoviePlayerController alloc]initWithContentURL:url];
    [self playerinit];
    UIWindow *backgroundWindow = [[UIApplication sharedApplication] keyWindow];
    [_movieplayer.view setFrame:backgroundWindow.frame];
    [backgroundWindow addSubview:_movieplayer.view];
    [_movieplayer prepareToPlay];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playMovieFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieplayer];//注册通知：Finish
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayDone:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:self.movieplayer];//注册通知：Done

    
    //获取播放时间
    
    NSString *time = [self gettime];
    NSLog(@"Open time is %@",time);

    [_movieplayer play];

}
-(void)playMovieFinished:(NSNotification*)theNotification
{
    
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieplayer];
    

    NSLog(@"Finish");
    NSString *finish_time = [self gettime];
    NSLog(@"Finish time is %@",finish_time);
}

-(void)moviePlayDone:(NSNotification*)theNotification
{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerDidExitFullscreenNotification object:self.movieplayer];
    
    NSString *time = [self gettime];
    NSLog(@"Done time is %@",time);
    
}
-(NSString *)gettime{
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    return morelocationString;
    
}
-(void)playerinit{

  _movieplayer.controlStyle=MPMovieControlStyleFullscreen;
   _movieplayer.shouldAutoplay=NO;
   _movieplayer.movieSourceType=MPMovieSourceTypeFile;
  _movieplayer.view.transform = CGAffineTransformConcat(_movieplayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
    
}
@end
