//
//  Log.h
//  XJTUDLC
//
//  Created by skyclass on 14-4-4.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Log : NSManagedObject

@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * file;
@property (nonatomic, retain) NSString * len;
@property (nonatomic, retain) NSString * studentCode;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * operationID;
@end
