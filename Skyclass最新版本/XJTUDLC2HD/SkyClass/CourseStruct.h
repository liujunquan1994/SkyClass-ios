//
//  CourseStruct.h
//  XJTUDLC
//
//  Created by skyclass on 14-4-2.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CourseStruct : NSManagedObject

@property (nonatomic, retain) NSString * courseID;
@property (nonatomic, retain) NSString * courseStructID;
@property (nonatomic, retain) NSString * courseStructName;

@end
