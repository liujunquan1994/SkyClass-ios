//
//  Attachment+CoreDataProperties.h
//  skyclass
//
//  Created by yunhuihuang on 16/1/4.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Attachment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *articleID;
@property (nullable, nonatomic, retain) NSString *attachmentPath;
@property (nullable, nonatomic, retain) NSString *attachmentStatus;
@property (nullable, nonatomic, retain) NSString *courseID;
@property (nullable, nonatomic, retain) NSString *mainHead;

@end

NS_ASSUME_NONNULL_END
