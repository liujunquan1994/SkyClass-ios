//
//  logMes.h
//  XJTUDLC
//
//  Created by skyclass on 14-4-4.
//
//

#import <Foundation/Foundation.h>

@interface logMes : NSObject
@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * file;
@property (nonatomic, retain) NSString * len;
@property (nonatomic, retain) NSString * studentCode;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * operationID;

-(void)initLog;
@end
