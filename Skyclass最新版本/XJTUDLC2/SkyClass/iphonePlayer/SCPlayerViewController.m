//
//  SCPlayerViewController.m
//  SkyClass
//
//  Created by skyclass on 1/20/16.
//  Copyright © 2016 skyclass. All rights reserved.
//

#import "SCPlayerViewController.h"

@interface SCPlayerViewController ()

@end

@implementation SCPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotifications];
    
    //self.view.transform =  CGAffineTransformConcat(self.view.transform, CGAffineTransformMakeRotation(M_PI_2));
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.moviePlayer stop];
    
    
   
}

- (void)addNotifications{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(playerStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(playerFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
}

- (void)playerStateChange:(NSNotification *)notification{
    switch(self.moviePlayer.playbackState){
        case MPMoviePlaybackStatePlaying:
                     break;
        case MPMoviePlaybackStatePaused:
                       break;
        case MPMoviePlaybackStateStopped:
                       break;
        default:
                       break;
    }
}

- (void)playerFinished:(NSNotification *)notification{
   }

@end
