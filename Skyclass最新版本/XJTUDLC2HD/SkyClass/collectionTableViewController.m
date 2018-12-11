//
//  collectionTableViewController.m
//  XJTUDLC
//
//  Created by skyclass on 14-3-21.
//
//

#import "collectionTableViewController.h"
#import "CourseStruct.h"
#import "fileCell.h"
#import "Attachment+CoreDataProperties.h"
#import "attachmentCell.h"

@interface collectionTableViewController ()
//导学资料列表
@property(nonatomic,strong)NSMutableArray * attachmentList;
@property(nonatomic,strong)NSMutableArray * articleID;
@property(nonatomic,strong)NSMutableArray * attachmentPath;
@property(nonatomic,strong)NSMutableArray * attachmentStatus;  //0 表示没下载，1表示已下载
//导学资料下载cell控件
@property(nonatomic,strong)UIButton * openBtn;
@property(nonatomic,strong)UIButton * deleteBtn;
@property(nonatomic,strong)UIButton * downloadBtn;
@property(nonatomic,assign)BOOL isDownload;
@property(nonatomic,strong)UIProgressView * progress;
@property(strong,nonatomic)AFDownloadRequestOperation *operation;
@property(nonatomic,strong)NSString * oneAttachmentPath;
//用于存储下载，删除，打开状态
@property(nonatomic,strong)NSUserDefaults *statusDefaults;
@property(nonatomic,strong,retain)UIDocumentInteractionController* documentController;
@end

@implementation collectionTableViewController
@synthesize courseCode  = _courseCode;
@synthesize movieplayer=_movieplayer;
@synthesize courseID=_courseID;
@synthesize courseName=_courseName;
@synthesize log=_log;
@synthesize courseIDToSend=_courseIDToSend;
@synthesize beginTime=_beginTime;
@synthesize state= _state;
@synthesize startPauseTime =_startPauseTime;
@synthesize startSeekingTime=_startSeekingTime;
@synthesize stopPauseTime =_stopPauseTime;
@synthesize stopSeekingTime=_stopSeekingTime;
NSString * playing=@"playing";
NSString * paused = @"paused";
NSString * seeking= @"seeking";
long int pauseTime=0;
long int seekingTime=0;
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
    dataArray = [[NSMutableArray alloc] init];
    self.articleID =[[NSMutableArray alloc] init];
    self.attachmentList = [[NSMutableArray alloc] init];
    self.attachmentPath = [[NSMutableArray alloc] init];
    self.attachmentStatus =  [[NSMutableArray alloc] init];


    //  helper =[ZXCoreData sharedZXCoreData];
    getData=[getJsonData sharedgetJsonData];
    //   updateData=[[getJsonData alloc]initWithmanagedObjectContext:[helper childThreadContext]];
    self.isVideoView = YES;
    self.title=_courseName;
    
    
    self.statusDefaults=[NSUserDefaults standardUserDefaults];
    
    NSArray * attachmentList = [getData getOne:@"Attachment" key:@"courseID" value:_courseID];
    //添加导学资料数据
    {
        NSLog(@"attachmentList %@",attachmentList);
        NSEnumerator *enumerator = [attachmentList objectEnumerator];
        id anObject;
        while (anObject = [enumerator nextObject]) {
            Attachment *tempattachment =anObject;
            NSLog(@"---%@,%@",tempattachment.articleID,tempattachment.mainHead);
            [self.attachmentList addObject:tempattachment.mainHead];
            [self.articleID addObject:tempattachment.articleID];
            [self.attachmentPath addObject:tempattachment.attachmentPath];
            [self.attachmentStatus addObject:tempattachment.attachmentStatus];
            if (![[NSFileManager defaultManager] fileExistsAtPath:tempattachment.attachmentPath]) {
                [[NSFileManager defaultManager] createDirectoryAtPath:tempattachment.attachmentPath withIntermediateDirectories:YES attributes:nil error:nil];
                
            }

        }
        
    }
    
    //导学资料下载路径
    //self.AttachmentPath=[AttachmentFile stringByAppendingPathComponent:@"attachment"];
    
    // 添加视频数据数据
    NSArray *courseStruct=[getData getOne:@"CourseStruct" key:@"courseID" value:_courseID];
    if ([courseStruct firstObject]==nil) {
        NSArray *files=[getData getfiles:@"File" key:@"courseCode" value:_courseCode];
        if ([files firstObject]==nil) {
            [self alert];
        }else{
            int num=[files count];
            int section=(num+3)/4;
            for (int j=0,i=0; j<section; j++) {
                collectionTableData  *myData = [[collectionTableData alloc] init];
                NSMutableArray *tempfiles=[[NSMutableArray alloc]init];
                for (int temp=0; temp<4&&i<num; temp++,i++) {
                    [tempfiles addObject:[files objectAtIndex:i]];
                }
                
                myData.name = [[NSString alloc]initWithFormat:@"第%d-%d讲",j*4+1,(j+1)*4];
                if (i>=num-1) {
                    myData.name = [[NSString alloc]initWithFormat:@"第%d-%d讲",j*4+1,num];
                    
                }
                myData.isShow=false;
                myData.array=tempfiles;
                [dataArray addObject:myData];
                
            }
        }
        NSLog(@"dataarry %@",dataArray);
    }else{
        NSLog(@"courseStruct %@",courseStruct);
        NSEnumerator *enumerator = [courseStruct objectEnumerator];
        id anObject;
        
        while (anObject = [enumerator nextObject]) {
            CourseStruct *tempstruct =anObject;
            collectionTableData  *myData = [[collectionTableData alloc] init];
            myData.name = tempstruct.courseStructName;
            NSLog(@"CourseStructID : %@",tempstruct.courseStructID);
            myData.array=[getData getfiles:@"File" key:@"courseStructID" value:tempstruct.courseStructID];
            myData.isShow=false;
            [dataArray addObject:myData];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)videoButton:(id)sender {
    self.isVideoView = YES;
    [self.tableView reloadData];

}

- (IBAction)dataView:(id)sender {
    self.isVideoView = NO;
    [self.tableView reloadData];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    if (self.isVideoView) {
        return [dataArray count];
    }else{
        
        return self.attachmentList.count;
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (self.isVideoView) {
        collectionTableData *data = [dataArray objectAtIndex:section];
        if ([data isShow]) {
            NSLog(@"%ld:%lu",(long)section,(unsigned long)[data.array count]);
            return  [data.array count];
        }else{
            return  0;
        }
        
    }else{
        
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.isVideoView) {
        return 80;
    }else{
        
        return 5;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.isVideoView) {
        return 45;
    }else{
        
        return 70;
    }
    
    
}

/*
 -(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
 
 if (self.isVideoView) {
 return 45;
 }else{
 
 return 100;
 }
 }
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*  static NSString *CellIdentifier = @"collectionTableCell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
     collectionTableData *data = [dataArray objectAtIndex:indexPath.section];
     fileForCell *dataForCell= [[data array] objectAtIndex:indexPath.row];
     cell.textLabel.text=dataForCell.fileName;*/
    if (self.isVideoView) {
        // Configure the cell...
        static NSString *CellIdentifier = @"test";
        fileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        collectionTableData *data = [dataArray objectAtIndex:indexPath.section];
        fileForCell *dataForCell= [[data array] objectAtIndex:indexPath.row];
        cell.indexPath=indexPath;
        [cell initWithfileforcell:dataForCell fileCelldelegate:self downloadDelegat:self];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        // Configure the cell...
        return cell;
    }else{
        /*
         NSArray * obj = [[NSBundle mainBundle]loadNibNamed:@"DataCell" owner:self options:nil];
         
         DataCell *cell =[obj objectAtIndex:0];
         //cell.delegate = cell;
         
         cell.nameLabel.text = @"导学资料";
         return cell;
         */
        UITableViewCell * cell = [[UITableViewCell alloc]init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        
        return cell;
        
    }
    
    
    
}
// 定义头标题的视图，添加点击事件
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (self.isVideoView) {
        collectionTableData *data = [dataArray objectAtIndex:section];
        UIView  *view=[[UIView alloc]init];
        UIButton *download = [UIButton buttonWithType:UIButtonTypeCustom];
        
        download.frame = CGRectMake(500, 0, 70, 45);
        [download setTitle:@"下载" forState:UIControlStateNormal];
        download.tag = section;
        download.hidden=YES;
        // [download addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, tableView.bounds.size.width, 45);
        [btn setTitle:data.name forState:UIControlStateNormal];
        btn.tag = section;
        NSLog(@"%ld",(long)btn.tag);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (section%2) {
            download.backgroundColor = [UIColor darkGrayColor];
            btn.backgroundColor = [UIColor darkGrayColor];
        }else{
            download.backgroundColor = [UIColor lightGrayColor];
            btn.backgroundColor = [UIColor lightGrayColor];
        }
        [view addSubview:btn];
        [view addSubview:download];
        return view;
        
        
    }else{
        /*
        UIView  *view=[[UIView alloc]init];
        UILabel * nameLabel = [[UILabel alloc]init];
        view.backgroundColor = [UIColor lightGrayColor];
        self.progress = [[UIProgressView alloc]init];
        self.downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.progress.frame = CGRectMake(10, 60, 200, 2);
        self.openBtn.frame = CGRectMake(500,45,50,25);
        [self.openBtn setTitle:@"打开" forState:UIControlStateNormal];
        [self.openBtn addTarget:self action:@selector(openClick:) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBtn.frame = CGRectMake(400, 45, 50, 25);
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        self.downloadBtn.frame = CGRectMake(500, 45, 40, 25);
        nameLabel.frame = CGRectMake(10, 0, tableView.bounds.size.width, 45);
        [ self.downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
        // downloadData.backgroundColor = [UIColor darkGrayColor];
        self.downloadBtn.tag = section;
        [ self.downloadBtn addTarget:self action:@selector(downloadDataClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString * mainHead = [self.attachmentList objectAtIndex:section];
        nameLabel.text = mainHead;
        
        NSString * status =_courseID;
        status = [status stringByAppendingFormat:@"%ld",self.downloadBtn.tag ];
       // NSMutableString * statusName = [_courseID stringByAppendingPathComponent:];
        if ([[self.statusDefaults objectForKey:status] isEqualToString:@"start download"]){
            [self.openBtn setHidden:NO];
            [self.deleteBtn setHidden:NO];
            [self.downloadBtn setHidden:YES];
            [self.progress setHidden:YES];
            [self.statusDefaults setObject:@"start download" forKey:status];

            
            
        }else {
            [self.openBtn setHidden:YES];
            [self.deleteBtn setHidden:YES];
            [self.downloadBtn setHidden:NO];
            [self.progress setHidden:YES];
            [self.statusDefaults setObject:@"finish download" forKey:status];
            
                  }
               //self.oneAttachmentPath = [self.attachmentPath objectAtIndex:section];
        [view addSubview:self.progress];
        [view addSubview:self.deleteBtn];
        [view addSubview: self.downloadBtn];
        [view addSubview:nameLabel];
        [view addSubview:self.openBtn];
        return view;
    }
         */
        attachmentCell * attachment = [[attachmentCell alloc]init];
        attachment.articleID = self.articleID;
        attachment.attachmentList = self.attachmentList;
        attachment.attachmentPath = self.attachmentPath;
        attachment.attachmentStatus = self.attachmentStatus;
        [attachment initWith:self.courseID tag:section];

        return attachment;
    }
    
}
/*
//打开导学资料
-(void)openClick:(UIButton *)btn{
    
    NSLog(@"open");
    //NSString * status =self.courseCode;
    //status = [status stringByAppendingFormat:@"%ld",(long)self.downloadBtn.tag];
   // NSString * filePath = [self.statusDefaults objectForKey:status];
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:self.oneAttachmentPath]];
    self.documentController.delegate = self;
    // documentController.UTI = @"com.microsoft.word.doc";
    [self.documentController presentOpenInMenuFromRect:btn.frame inView:self.view animated:YES];
    //[documentController presentPreviewAnimated:YES];
}
-(void)deleteClick:(UIButton *)btn{
    NSLog(@"operation cancle");
    [_operation resume];
    [_operation cancel];
    NSFileManager *fileMnager=[NSFileManager defaultManager];
    if ([fileMnager fileExistsAtPath:self.oneAttachmentPath ]) {
        [fileMnager removeItemAtPath:self.oneAttachmentPath error:nil];
    }
    [self.deleteBtn setHidden: YES];
    [self.openBtn setHidden:YES];
    [self.downloadBtn setHidden:NO];
    NSString * status =self.courseID;
    status = [status stringByAppendingFormat:@"%ld",(long)self.downloadBtn.tag];
    [self.statusDefaults setObject:@"start download" forKey:status];
    
    
}
//下载导学资料点击下载按钮
-(void)downloadDataClick:(UIButton *)btn{
    
    
    [self.deleteBtn setHidden:NO];
    [self.progress setHidden:NO];
    NSLog(@"test");
    NSString * attachmenUrlStr = [NSString stringWithFormat:@"http://xueli.xjtudlc.com/MobileLearning/Get_Attachment.aspx?ArticleID=%@",[self.articleID objectAtIndex:btn.tag]];
    //NSURL *url = [NSURL URLWithString:urlStr];
    
    //NSString * attachmenUrlStr= @"http://xueli.xjtudlc.com/MobileLearning/Get_Attachment.aspx?ArticleID=2420";
    NSURL *attachmenurl = [NSURL URLWithString:attachmenUrlStr];
    NSLog(@"attachmenUrlStr :%@",attachmenurl);
    //httppost创建请求
    
    NSMutableURLRequest *requestAttachment = [[NSMutableURLRequest alloc]initWithURL:attachmenurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    NSLog(@"requestAttachment:%@",requestAttachment);
    //http post连接服务器
    NSData *receivedAttachment = [NSURLConnection sendSynchronousRequest:requestAttachment returningResponse:nil error:nil];//等待返回参数
    NSLog(@"receivedAttachment:%@",receivedAttachment);
    NSError *error;
    if (receivedAttachment) {
        NSString * str = [[NSString alloc]initWithData:receivedAttachment encoding:NSUTF8StringEncoding];
        //正则表达式取所有URL
        NSString * regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        NSArray *arrayOfAllMatches = [regex matchesInString:str options:0 range:NSMakeRange(0, [str length])];
        //根据返回的结果取第二个URL为下载地址
        NSTextCheckingResult * string = [arrayOfAllMatches lastObject];
        NSString* urlStr = [str substringWithRange:string.range];
        NSLog(@"string :%@",urlStr);
        NSURL * url = [NSURL URLWithString:urlStr];
        NSString * fileName = [url lastPathComponent];
        self.oneAttachmentPath = [[self.attachmentPath objectAtIndex:btn.tag]stringByAppendingFormat:@"/%@",fileName];
        NSLog(@"filePath-----:%@",self.oneAttachmentPath);
        //NSString * status =self.courseCode;
        //status = [status stringByAppendingFormat:@"%ld",(long)self.downloadBtn.tag];
       // [self.statusDefaults setObject:filePath forKey:status];
        
        // dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self downloadAttachment:url];
        //});
    }
    
}
//根据页面返回URL下载资料
-(void)downloadAttachment:(NSURL *)url{
    
    
    //通过页面取的真实url下载资料
    //http://xueli.xjtudlc.com/attachment/Lms/Article/2015-6-26/Article635709324197289614.zip
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.oneAttachmentPath]) {
       
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3600];
        self.operation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:self.oneAttachmentPath shouldResume:YES];
        __weak typeof(self) weakSelf = self;
        
        [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Successfully downloaded file to %@  responseObject:%@",weakSelf.oneAttachmentPath,responseObject);
            [weakSelf.openBtn setHidden:NO];
            [weakSelf.deleteBtn setHidden:NO];
            [weakSelf.downloadBtn setHidden:YES];
            [weakSelf.progress setHidden:YES];
            NSString * status =weakSelf.courseID;
            status = [status stringByAppendingFormat:@"%ld",(long)weakSelf.downloadBtn.tag];
            [weakSelf.statusDefaults setObject:@"finish download" forKey:status];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [weakSelf.operation cancel];
            [weakSelf.openBtn setHidden:YES];
            [weakSelf.deleteBtn setHidden:YES];
            [weakSelf.downloadBtn setHidden:NO];
            [weakSelf.progress setHidden:YES];
            NSString * status =weakSelf.courseID;
            status = [status stringByAppendingFormat:@"%ld",(long)weakSelf.downloadBtn.tag];
            [weakSelf.statusDefaults setObject:@"start download" forKey:status];
            NSLog(@"下载Error: %@", error);
            UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"下载错误" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alter show];
            
        }];
        //float before = 0;
        [_operation setProgressiveDownloadProgressBlock:^(NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
            float percentDone = totalBytesReadForFile/(float)totalBytesExpectedToReadForFile;
            weakSelf.progress.progress = percentDone;
        }];
        [_operation start];
        
    }else{
    
        [self.openBtn setHidden:NO];
        [self.deleteBtn setHidden:NO];
        [self.downloadBtn setHidden:YES];
        [self.progress setHidden:YES];
        NSString * status =self.courseID;
        status = [status stringByAppendingFormat:@"%ld",(long)self.downloadBtn.tag];
        [self.statusDefaults setObject:@"finish download" forKey:status];
        
    }

    
}
*/
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

- (void) btnClick:(UIButton *)btn
{
    
    collectionTableData *data = [dataArray objectAtIndex:btn.tag];
    // 改变组的显示状态
    if ([data isShow]) {
        [data setIsShow:false];
    }else{
        [data setIsShow:true];
        NSIndexPath *myIndex = [NSIndexPath indexPathForRow:0 inSection:btn.tag] ;
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:myIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    // 刷新点击的组标题，动画使用卡片
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma markdocumentInteractionController代理实现方法
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return  self.view.frame;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
//download代理
-(void)fileCellStatusChange:(NSIndexPath *)indexPath status:(NSString *)status{
    NSLog(@"fileCellStatusChange %@,%@",indexPath,status);
    collectionTableData *data = [dataArray objectAtIndex:indexPath.section];
    fileForCell *dataForCell= [[data array] objectAtIndex:indexPath.row];
    dataForCell.status=status;
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:indexPath waitUntilDone:YES];
}

-(void)fileCellStop:(NSIndexPath *)indexPath{
    NSLog(@"fileCellStop %@",indexPath);

    collectionTableData *data = [dataArray objectAtIndex:indexPath.section];
    fileForCell *dataForCell= [[data array] objectAtIndex:indexPath.row];
    dataForCell.status=@"0";
    dataForCell.progress=0;
    [getData insertfile:dataForCell];
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:indexPath waitUntilDone:YES];
}
-(void)fileCellDownload:(NSIndexPath *)indexPath progress:(float)value{
    NSLog(@"fileCellDownload %@,%f",indexPath,value);
    collectionTableData *data = [dataArray objectAtIndex:indexPath.section];
    fileForCell *dataForCell= [[data array] objectAtIndex:indexPath.row];
    dataForCell.progress=value;
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:indexPath waitUntilDone:YES];
    
}
-(void)fileCellFinish:(NSIndexPath *)indexPath{
    NSLog(@"fileCellStatusChange %@",indexPath);
    collectionTableData *data = [dataArray objectAtIndex:indexPath.section];
    fileForCell *dataForCell= [[data array] objectAtIndex:indexPath.row];
    dataForCell.status=@"3";
    [getData insertfile:dataForCell];
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:indexPath waitUntilDone:YES];

}
//////////////////////
-(void)updateCell:(NSIndexPath *)indexPath{
    fileCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    collectionTableData *data = [dataArray objectAtIndex:indexPath.section];
    fileForCell *dataForCell= [[data array] objectAtIndex:indexPath.row];
    cell.myFile=dataForCell;
    [cell updateSelf];
}

//*********************************************************
-(void)fileCellPlay:(fileCell *)cell{
    NSIndexPath *cellIndex=[self.tableView indexPathForCell:cell];
    NSInteger *section=[cellIndex section];
   // NSString *structName=[[dataArray objectAtIndex:section] name];
    _log=[[logMes alloc]init];
    [_log initLog];
    _log.file=[[NSString alloc]initWithFormat:@"ipad-%@",cell.myFile.fileName];
    _log.courseCode=_courseIDToSend;
    _log.studentCode= [[NSUserDefaults standardUserDefaults]stringForKey:@"StudentCode"];
    [self play:cell.myFile.filePath];
  }
-(void)fileCellPlayOnline:(fileCell *)cell{
    NSIndexPath *cellIndex=[self.tableView indexPathForCell:cell];
    NSInteger *section=[cellIndex section];
   // NSString *structName=[[dataArray objectAtIndex:section] name];
    _log=[[logMes alloc]init];
    [_log initLog];
    _log.file=[[NSString alloc]initWithFormat:@"ipad-%@",cell.myFile.fileName];
    _log.courseCode=_courseIDToSend;
    _log.studentCode= [[NSUserDefaults standardUserDefaults]stringForKey:@"StudentCode"];
    NSLog(@"myfile url %@",cell.myFile.fileURL);
    [self playOnline:cell.myFile.fileURL];
}
/////////////
-(void)play:(NSString *)urlStr{
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    NSLog(@"play urlstr %@",url);
    _movieplayer=[[MPMoviePlayerViewController alloc]initWithContentURL:url];
    _movieplayer.view.transform = CGAffineTransformConcat(_movieplayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
    [self presentMoviePlayerViewControllerAnimated:_movieplayer];

     _state =@"playing";

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playMovieFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieplayer.moviePlayer];//注册通知：Finish
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayDone:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:self.movieplayer.moviePlayer];//注册通知：Done
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:self.movieplayer.moviePlayer];//注册通知：state

    
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
    _movieplayer=[[MPMoviePlayerViewController alloc]initWithContentURL:url];
    _movieplayer.moviePlayer.view.transform = CGAffineTransformConcat(_movieplayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
    [self presentMoviePlayerViewControllerAnimated:_movieplayer];
    _state =@"playing";
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playMovieFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieplayer.moviePlayer];//注册通知：Finish
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayDone:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:self.movieplayer.moviePlayer];//注册通知：Done
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:self.movieplayer.moviePlayer];//注册通知：state

    
    //获取播放时间
    
    NSString *time = [self gettime];
    _beginTime=time;
    _log.time=time;
    _log.operationID=@"1";
    [getData insertLog:_log];
   // NSLog(@"play url:%@",_movieplayer.contentURL);
    NSLog(@"Open time is %@",time);
    
    //[_movieplayer play];//开始播放
    
}
-(void)playMovieFinished:(NSNotification*)theNotification
{
    [self removeMovieNotificationHandlers];
    
    [[NSNotificationCenter defaultCenter]
    removeObserver:self
    name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieplayer.moviePlayer];
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
    //[self.movieplayer.moviePlayer.view removeFromSuperview];
    NSLog(@"Finish time is %@ len is %@",finish_time,_log.len);
}

-(void)moviePlayDone:(NSNotification*)theNotification
{
    //[self removeMovieNotificationHandlers];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerDidExitFullscreenNotification object:self.movieplayer.moviePlayer];
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
    if ([_log.len intValue]>0) {
        [getData insertLog:_log];
    }
    NSLog(@"Done time is %@",time);
    
    
}
-(void)removeMovieNotificationHandlers
{
    MPMoviePlayerController *player = self.movieplayer.moviePlayer;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.movieplayer.moviePlayer];
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
            //_log.time = [NSString stringWithFormat: @"%f",_startSeekingTime];

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
