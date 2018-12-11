//
//  OTDBUtil.m
//  VideoEditorTrain
//
//  Created by fenguo on 13-5-20.
//  Copyright (c) 2013年 open. All rights reserved.
//

#import "OMDBUtil.h"
#import "LBBaseViewController.h"

@implementation OMDBUtil

+ (BOOL) initDB
{
    FMDatabase *db = [OMDBUtil openDB];
    if (db) {
        
        [db close];
        return YES;
    }
    return NO;
}


+ (FMDatabase *)openDB
{
    FMDatabase *db= [OMDBUtil getDB];
    if (![db open]) {
        return nil;
    }
    return db;
}


+ (FMDatabase *)getDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"VideoEditorDB.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    
    //////////
    [LBBaseViewController addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:dbPath isDirectory:NO]];
    /////////
    return db;
}



+ (void) closeDB: (FMDatabase *)db
{
    [db close];
}

@end
