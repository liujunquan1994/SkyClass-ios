//
//  player.h
//  XJTUDLC
//
//  Created by skyclass on 14-4-3.
//
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "fileForCell.h"
@interface player : NSObject

@property(strong,nonatomic)MPMoviePlayerController *movieplayer;//播放器
@property(strong,nonatomic)NSString *courseID;
@property(strong,nonatomic)fileForCell *file;
-(void)play;
@end
