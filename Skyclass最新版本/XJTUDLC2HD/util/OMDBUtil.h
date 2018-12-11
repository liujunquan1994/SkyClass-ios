//
//  OTDBUtil.h
//  VideoEditorTrain
//
//  Created by fenguo on 13-5-20.
//  Copyright (c) 2013年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"


@interface OMDBUtil : NSObject

+ (BOOL) initDB;
+ (FMDatabase *)getDB;
+ (FMDatabase *)openDB;
+ (void) closeDB: (FMDatabase *)db;

@end
