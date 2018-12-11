//
//  collectionTableViewController.h
    //  XJTUDLC
//
//  Created by skyclass on 14-3-21.
//
//

#import <UIKit/UIKit.h>
#import "collectionTableData.h"
#import "ZXCoreData.h"
#import "getJsonData.h"
#import "fileCell.h"
#import "logMes.h"
#import <MediaPlayer/MediaPlayer.h>
#import <Foundation/Foundation.h>
#import "download.h"
#import "SCPlayerViewController.h"

@interface collectionTableViewController : UITableViewController<downloadDelegate,fileCellDelegate,UIDocumentInteractionControllerDelegate>
{
    NSMutableArray *dataArray;
    getJsonData *getData;
    getJsonData *updateData;
    ZXCoreData *helper;
}
//@property(strong,nonatomic)MPMoviePlayerController *movieplayer;//播放器
@property(strong,nonatomic)SCPlayerViewController *movieplayer;
@property(nonatomic,copy)NSString *courseCode;
@property(nonatomic,copy)NSString *courseID;
@property(nonatomic,copy)NSString *courseName;
@property(nonatomic,copy)NSString *courseIDToSend;
@property(nonatomic,copy)logMes *log;
@property(nonatomic,copy)NSString *beginTime;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *startPauseTime;
@property(nonatomic)NSTimeInterval startSeekingTime;
@property(nonatomic,copy)NSString *stopPauseTime;
@property(nonatomic)NSTimeInterval stopSeekingTime;
@property(nonatomic,assign)BOOL isVideoView;
- (IBAction)videoView:(id)sender;
- (IBAction)dataView:(id)sender;
-(void)playOnline:(NSString *)urlStr;
@end
