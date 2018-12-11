//
//  File.h
//  XJTUDLC
//
//  Created by skyclass on 14-4-11.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface File : NSManagedObject

@property (nonatomic, retain) NSString * courseID;
@property (nonatomic, retain) NSString * courseStructID;
@property (nonatomic, retain) NSString * fileID;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) NSString * fileURL;
@property float progress;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * courseCode;

@end
