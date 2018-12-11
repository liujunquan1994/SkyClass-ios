//
//  fileForCell.h
//  XJTUDLC
//
//  Created by skyclass on 14-3-31.
//
//

#import <Foundation/Foundation.h>

@interface fileForCell : NSObject
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * courseID;
@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * fileURL;
@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) NSString * courseStructID;
@property (nonatomic, retain) NSString * fileID;
@property float progress;
@end
