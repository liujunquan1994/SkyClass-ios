//
//  Course.h
//  XJTUDLC
//
//  Created by skyclass on 14-4-15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * courseID;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSString * introduction;
@property (nonatomic, retain) NSString * teacher;
@property (nonatomic, retain) NSString * courseIDTOSend;

@end
