//
//  download.m
//  XJTUDLC
//
//  Created by skyclass on 14-4-4.
//
//

#import "download.h"

@implementation download
@synthesize operation=_operation;
@synthesize indexPath=_indexPath;
@synthesize url=_url;
@synthesize path=_path;
@synthesize delegate=_delegate;
@synthesize before=_before;
-(void)initOperation{
    
    NSURL *url = [NSURL URLWithString:_url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3600];
    _operation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:_path shouldResume:YES];
    _operation.deleteTempFileOnCancel=YES;
    _before=0;
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully downloaded file to %@",_path);
          NSURL *url=[NSURL fileURLWithPath:_path];
        [self addSkipBackupAttributeToItemAtURL:url];
        [_delegate fileCellStatusChange:_indexPath status:@"3"];
        [_delegate fileCellFinish:_indexPath];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_operation cancel];
        [_delegate fileCellStatusChange:_indexPath status:@"0"];
        [_delegate fileCellStop:_indexPath];
        NSLog(@"下载Error: %@", error);
    }];
    
    [_operation setProgressiveDownloadProgressBlock:^(NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
        float percentDone = totalBytesReadForFile/(float)totalBytesExpectedToReadForFile;
        if ((percentDone-0.02)>=_before) {
            _before=percentDone;
            [_delegate fileCellDownload:_indexPath progress:percentDone];

        }
        /*
         
         NSLog(@"------%f",percentDone);
         NSLog(@"Operation%i: bytesRead: %d", 1, bytesRead);
         NSLog(@"Operation%i: totalBytesRead: %lld", 1, totalBytesRead);
         NSLog(@"Operation%i: totalBytesExpected: %lld", 1, totalBytesExpected);
         NSLog(@"Operation%i: totalBytesReadForFile: %lld", 1, totalBytesReadForFile);
         NSLog(@"Operation%i: totalBytesExpectedToReadForFile: %lld", 1, totalBytesExpectedToReadForFile);*/
    }];
    
    
    
}
-(void)beginDownload{
    NSFileManager *fileMnager=[NSFileManager defaultManager];
    if ([fileMnager fileExistsAtPath:_path]) {
        NSLog(@"  file exiest %@", _path);
      
        [_delegate fileCellStatusChange:_indexPath status:@"3"];
        [_delegate fileCellFinish:_indexPath];}
    else
    {
        NSLog(@"download url: %@. targetPath : %@",_url,_path);
            [self initOperation];
            
            [_operation start];
        
            [_delegate fileCellStatusChange:_indexPath status:@"1"];
            
    }
}
-(void)pause{
    NSFileManager *fileMnager=[NSFileManager defaultManager];
    if ([fileMnager fileExistsAtPath:_path]) {
        NSLog(@"  file exiest %@", _path);
   
        [_delegate fileCellStatusChange:_indexPath status:@"3"];
         [_delegate fileCellFinish:_indexPath];}
    else
    {
        [_operation pause];
        
        [_delegate fileCellStatusChange:_indexPath status:@"2"];
        
    }

}
-(void)resume
{
    NSFileManager *fileMnager=[NSFileManager defaultManager];
    if ([fileMnager fileExistsAtPath:_path]) {
        NSLog(@"  file exiest %@", _path);
   
        [_delegate fileCellStatusChange:_indexPath status:@"3"];
         [_delegate fileCellFinish:_indexPath];}
    else{
    if ([_operation isExecuting]) {
        
        [_operation resume];
    }
    else{
        NSLog(@"已经停止");
        [self initOperation];
        [_operation start];
    }
    
    [_delegate fileCellStatusChange:_indexPath status:@"1"];
    }
}
-(void)cancel{
    NSLog(@"operation cancle");
    [_operation resume];
    [_operation cancel];
    NSFileManager *fileMnager=[NSFileManager defaultManager];
    if ([fileMnager fileExistsAtPath:_path]) {
        [fileMnager removeItemAtPath:_path error:nil];
    }
    [_delegate fileCellStop:_indexPath];
    [_delegate fileCellStatusChange:_indexPath status:@"0"];
}
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
@end
