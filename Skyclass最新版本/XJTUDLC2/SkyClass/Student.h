//
//  Student.h
//  XJTUDLC
//
//  Created by skyclass on 14-3-25.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * loginname;
@property (nonatomic, retain) NSNumber * loginState;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * studentCode;

@end
