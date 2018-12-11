//
//  Attachment+CoreDataProperties.h
//  skyclass
//
//  Created by skyclass on 15/11/30.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Attachment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *articleID;
@property (nullable, nonatomic, retain) NSString *courseID;
@property (nullable, nonatomic, retain) NSString *mainHead;
@property (nullable, nonatomic, retain) NSString *attachmentPath;
@property (nullable, nonatomic, retain) NSString *attachmentStatus;

@end

NS_ASSUME_NONNULL_END
