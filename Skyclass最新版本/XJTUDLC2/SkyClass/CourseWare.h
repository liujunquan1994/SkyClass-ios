//
//  CourseWare.h
//  XJTUDLC
//
//  Created by skyclass on 14-3-24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course;

@interface CourseWare : NSManagedObject

@property (nonatomic, retain) NSString * courseID;
@property (nonatomic, retain) NSString * courseWareID;
@property (nonatomic, retain) NSString * videoUrl;
@property (nonatomic, retain) NSString * courseWareName;
@property (nonatomic, retain) NSString * pptUrl;
@property (nonatomic, retain) NSString * pdfURL;
@property (nonatomic, retain) Course *relationship;

@end
