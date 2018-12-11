//
//  fileCell.m
//  XJTUDLC
//
//  Created by skyclass on 14-3-31.
//
//

#import "fileCell.h"
#import "fileForCell.h"
#import "ZXCoreData.h"
#import "getJsonData.h"
#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]
#define MUSICFile1 [DocumentsDirectory stringByAppendingPathComponent:_myFile.courseCode]
#define MUSICFile [MUSICFile1 stringByAppendingPathComponent:_myFile.fileName]
@implementation fileCell
@synthesize operation=_operation;
@synthesize courseCode = _courseCode;
@synthesize myFile=_myFile;
@synthesize name=_name;
@synthesize progress=_progress;
@synthesize downloadStatus=_downloadStatus;
@synthesize total=_total;
@synthesize progressValue=_progressValue;
@synthesize playStatus=_playStatus;
@synthesize indexPath=_indexPath;
@synthesize delegate=_delegate;
@synthesize playOnline=_playOnline;
@synthesize deleteButton=_deleteButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [_downloadStatus sizeToFit];
        [_playStatus sizeToFit];
        [_deleteButton sizeToFit];
        [_playOnline sizeToFit];
    }
    return self;
}
-(void)initWithfileforcell:(fileForCell *)file fileCelldelegate:(id<fileCellDelegate>)delegate1 downloadDelegat:(id<downloadDelegate>) delegate2{
    _courseCode =_myFile.courseCode;
    _myFile=file;
    _total=0;
    
    _delegate=delegate1;
    _name.text=_myFile.fileName;
    _myFile.filePath=[MUSICFile stringByAppendingPathComponent:@"Screen.mp4"];
       if (![[NSFileManager defaultManager] fileExistsAtPath:MUSICFile]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:MUSICFile withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [self initDownload];
    [self initSelf];
    _operation.delegate=delegate2;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)download:(id)sender {
    if ([_myFile.status isEqualToString:@"0"]) {
        [_operation beginDownload];
    }
    else if([_myFile.status isEqualToString:@"1"])
    {
        [_operation pause];
    }
    else if([_myFile.status isEqualToString:@"2"])
        [_operation resume];
}

- (IBAction)play:(id)sender {
    [_delegate fileCellPlay:self];
}

- (IBAction)playOnline:(id)sender {
    [_delegate fileCellPlayOnline:self];
}

- (IBAction)deleteVideo:(id)sender {
    [_operation cancel];
}


-(void)updateSelf{
 //   NSLog(@"updateCell per %f  status %@",self.progressValue,self.myFile.status);
    [self.progress setProgress: self.myFile.progress];
    if (    self.progress.progress>0) {
        self.progress.hidden=NO;
    }
   // NSLog(@"progress.progress %f",self.progress.progress);
    if ([self.myFile.status isEqualToString:@"0"])
    {
        
        [self.downloadStatus setTitle:@"下载" forState: UIControlStateNormal];
        self.progress.hidden=YES;
        self.downloadStatus.hidden = NO;
        self.playStatus.hidden=YES;
        self.playOnline.hidden=NO;
        self.deleteButton.hidden=YES;
        
    }
    else if ([self.myFile.status isEqualToString:@"1"]){
        [self.downloadStatus setTitle:@"暂停" forState: UIControlStateNormal];
         self.playStatus.hidden=YES;
         self.downloadStatus.hidden = NO;
        self.progress.hidden=NO;
        self.playOnline.hidden=NO;
          self.deleteButton.hidden=NO;

    }
    else if ([self.myFile.status isEqualToString:@"2"]){
        [self.downloadStatus setTitle:@"继续" forState: UIControlStateNormal];
        self.playStatus.hidden=YES;
        self.downloadStatus.hidden = NO;
        self.progress.hidden=NO;
        self.playOnline.hidden=NO;
        self.deleteButton.hidden=NO;

    }
    else if([self.myFile.status isEqualToString:@"3"])
    {
        [self.downloadStatus setTitle:@"已下载" forState: UIControlStateNormal];
        self.progress.hidden=YES;
        self.downloadStatus.hidden = YES;
        self.playStatus.hidden=NO;
        self.playOnline.hidden=YES;
          self.deleteButton.hidden=NO;

    }
    
}
-(void)initSelf{
    //   NSLog(@"updateCell per %f  status %@",self.progressValue,self.myFile.status);
    [self.progress setProgress: self.myFile.progress];
    if (    self.progress.progress>0) {
        self.progress.hidden=NO;
    }
    // NSLog(@"progress.progress %f",self.progress.progress);
    if ([self.myFile.status isEqualToString:@"0"])
    {
        
        [self.downloadStatus setTitle:@"下载" forState: UIControlStateNormal];
        self.progress.hidden=YES;
        self.downloadStatus.hidden = NO;
        self.playStatus.hidden=YES;
        self.playOnline.hidden=NO;
         self.deleteButton.hidden=YES;
        
    }
    else if ([self.myFile.status isEqualToString:@"1"]){
        [self.downloadStatus setTitle:@"暂停" forState: UIControlStateNormal];
        self.playStatus.hidden=YES;
        self.downloadStatus.hidden = NO;
        self.progress.hidden=NO;
               self.playOnline.hidden=NO;
               self.deleteButton.hidden=NO;
    }
    else if ([self.myFile.status isEqualToString:@"2"]){
        [self.downloadStatus setTitle:@"继续" forState: UIControlStateNormal];
        self.playStatus.hidden=YES;
        self.downloadStatus.hidden = NO;
        self.progress.hidden=NO;
               self.playOnline.hidden=NO;
               self.deleteButton.hidden=NO;
    }
    else if([self.myFile.status isEqualToString:@"3"])
    {
        [self.downloadStatus setTitle:@"已下载" forState: UIControlStateNormal];
        self.progress.hidden=YES;
        self.downloadStatus.hidden = YES;
        self.playStatus.hidden=NO;
        self.playOnline.hidden=YES;
               self.deleteButton.hidden=NO;
    }
    
}
-(void)initDownload{
    _operation=[[download alloc]init];
    _operation.path=_myFile.filePath;
    _operation.url=_myFile.fileURL;
    _operation.indexPath=_indexPath;
    NSLog(@"indexPath%@",_indexPath);
}
@end
