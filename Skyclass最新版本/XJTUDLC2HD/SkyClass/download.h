//
//  download.h
//  XJTUDLC
//
//  Created by skyclass on 14-4-4.
//
//

#import <Foundation/Foundation.h>
#import "AFDownloadRequestOperation.h"
@protocol downloadDelegate<NSObject>
@required
-(void)fileCellStatusChange:(NSIndexPath *)indexPath status:(NSString *)status;
-(void)fileCellStop:(NSIndexPath *)indexPath;
-(void)fileCellDownload:(NSIndexPath *)indexPath progress:(float)value;
-(void)fileCellFinish:(NSIndexPath *)indexPath;
@end
@interface download : NSObject
@property(strong,nonatomic)AFDownloadRequestOperation *operation;

@property(strong,nonatomic)NSIndexPath *indexPath;
@property(strong,nonatomic)NSString *url;
@property(strong,nonatomic)NSString *path;
@property(strong,nonatomic)id<downloadDelegate>delegate;
@property float before;

-(void)cancel;
-(void)resume;
-(void)pause;
-(void)beginDownload;
-(void)initOperation;
@end
