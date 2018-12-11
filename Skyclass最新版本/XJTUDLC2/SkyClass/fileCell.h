//
//  fileCell.h
//  XJTUDLC
//
//  Created by skyclass on 14-3-31.
//
//

#import <UIKit/UIKit.h>
#import "fileForCell.h"
#import "AFDownloadRequestOperation.h"
#import "download.h"
@class fileCell;
@protocol fileCellDelegate<NSObject>
@required
-(void)fileCellPlay:(fileCell *)cell;
-(void)fileCellPlayOnline:(fileCell *)cell;
@end
@interface fileCell : UITableViewCell
@property float progressValue;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIProgressView *progress;
@property (strong, nonatomic) IBOutlet UIButton *downloadStatus;
@property (strong, nonatomic) IBOutlet UIButton *playStatus;
@property (strong, nonatomic) IBOutlet UIButton *playOnline;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong , nonatomic)NSString *courseCode;
@property (strong , nonatomic) fileForCell *myFile;
@property(strong,nonatomic)download *operation;
@property(strong,nonatomic)NSIndexPath *indexPath;
@property uint64_t total;
@property(strong ,nonatomic)id<fileCellDelegate>delegate;
- (IBAction)download:(id)sender;
- (IBAction)play:(id)sender;
- (IBAction)playOnline:(id)sender;

- (IBAction)deleteVideo:(id)sender;

-(void)initWithfileforcell:(fileForCell *)file fileCelldelegate:(id<fileCellDelegate>)delegate1 downloadDelegat:(id<downloadDelegate>) delegate2;
-(void)fileCellStatusChange;
-(void)beginDownload;
-(void)updateSelf;
@end
