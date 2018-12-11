//
//  attachmentCell.m
//  skyclass
//
//  Created by yunhuihuang on 16/1/4.
//
//
//

#import "attachmentCell.h"

@implementation attachmentCell


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void )initWith:(NSString *)courseID tag:(NSInteger)tag {
    self.courseID = courseID;
    self.statusDefaults = [NSUserDefaults standardUserDefaults];
    self.nameLabel = [[UILabel alloc]init];
    self.backgroundColor = [UIColor lightGrayColor];
    self.progress = [[UIProgressView alloc]init];
    self.downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.progress.frame = CGRectMake(5, 45, 100, 2);
    self.openBtn.frame = CGRectMake(120,30,50,20);
    [self.openBtn setTitle:@"打开" forState:UIControlStateNormal];
    [self.openBtn addTarget:self action:@selector(openClick:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn.frame = CGRectMake(200, 30, 50, 20);
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    self.downloadBtn.frame = CGRectMake(200, 30, 50, 20);
    self.nameLabel.frame = CGRectMake(10, 0, 300, 30);
    [ self.downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    // downloadData.backgroundColor = [UIColor darkGrayColor];
    self.downloadBtn.tag = tag;
    [ self.downloadBtn addTarget:self action:@selector(downloadDataClick:) forControlEvents:UIControlEventTouchUpInside];
    //nameLabel.backgroundColor = [UIColor blackColor];
    self.nameLabel.textColor = [UIColor blackColor];
    NSString * mainHead = [self.attachmentList objectAtIndex:tag];
    self.nameLabel.text = mainHead;
    
    NSString * status =courseID;
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
    [self addSubview:self.progress];
    [self addSubview:self.deleteBtn];
    [self addSubview: self.downloadBtn];
    [self addSubview:self.nameLabel];
    [self addSubview:self.openBtn];
    //return self;
    
}
- (void)drawRect:(CGRect)rect {
    
}
//打开导学资料
-(void)openClick:(UIButton *)btn{
    
    NSLog(@"open");
    //NSString * status =self.courseCode;
    //status = [status stringByAppendingFormat:@"%ld",(long)self.downloadBtn.tag];
    // NSString * filePath = [self.statusDefaults objectForKey:status];
    NSFileManager *fileMnager=[NSFileManager defaultManager];
    if ([fileMnager fileExistsAtPath:self.oneAttachmentPath ]) {
        self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:self.oneAttachmentPath]];
        self.documentController.delegate = self;
        // documentController.UTI = @"com.microsoft.word.doc";
        [self.documentController presentOpenInMenuFromRect:btn.frame inView:self animated:YES];
        //[self.documentController presentPreviewAnimated:YES];
    }else{
        
        [self.deleteBtn setHidden: YES];
        [self.openBtn setHidden:YES];
        [self.downloadBtn setHidden:NO];
        NSString * status =self.courseID;
        status = [status stringByAppendingFormat:@"%ld",(long)self.downloadBtn.tag];
        [self.statusDefaults setObject:@"start download" forKey:status];
        
        
    }
    
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
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.attachmentPath objectAtIndex:btn.tag]]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[self.attachmentPath objectAtIndex:btn.tag]  withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    
    [self.deleteBtn setHidden:NO];
    [self.progress setHidden:NO];
    NSLog(@"test");
    NSString * attachmenUrlStr;
    if ([self.statusDefaults boolForKey:@"feixueli"]) {
        attachmenUrlStr = [NSString stringWithFormat:@"https://feixueli.xjtudlc.com/MobileLearning/Get_Attachment.aspx?ArticleID=%@",[self.articleID objectAtIndex:btn.tag]];

    }else{
        attachmenUrlStr = [NSString stringWithFormat:@"https://xueli.xjtudlc.com/MobileLearning/Get_Attachment.aspx?ArticleID=%@",[self.articleID objectAtIndex:btn.tag]];
    }
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
#pragma markdocumentInteractionController代理实现方法
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self.inputAccessoryViewController;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return  self.frame;
}


@end
