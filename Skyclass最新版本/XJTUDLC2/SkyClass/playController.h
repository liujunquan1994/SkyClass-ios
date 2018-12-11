//
//  playController.h
//  skyclass
//
//  Created by skyclass on 15/4/27.
//
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "fileForCell.h"
#import "logMes.h"
#import "collectionTableData.h"
#import "ZXCoreData.h"
#import "getJsonData.h"
#import "fileCell.h"
#import "logMes.h"
#import <MediaPlayer/MediaPlayer.h>
#import <Foundation/Foundation.h>
#import "download.h"
@interface playController : UIViewController
{
    NSMutableArray *dataArray;
    getJsonData *getData;
    getJsonData *updateData;
    ZXCoreData *helper;
}

@property(strong,nonatomic)MPMoviePlayerViewController *movieplayer;//播放器
@property(strong,nonatomic)NSString *courseID;
@property(strong,nonatomic)fileForCell *file;
@property(nonatomic,copy)logMes *log;
@property(nonatomic,copy)NSString *beginTime;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *startPauseTime;
@property(nonatomic)NSTimeInterval startSeekingTime;
@property(nonatomic,copy)NSString *stopPauseTime;
@property(nonatomic)NSTimeInterval stopSeekingTime;

-(void)play:(NSString *)urlStr;
-(void)playOnline:(NSString *)urlStr;
@end
