//
//  OMDbutil.h
//  meos-i
//
//  Created by shadow ren on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FMDatabase.h"

#define kFolder 1
#define kFile 0
#define kDefaultFolderId @""

@class OMCourseItem;

@interface OMUPDbutil : NSObject
+ (BOOL) initDB;
+ (FMDatabase *)getDB;
+ (FMDatabase *)openDB;
+ (void) closeDB: (FMDatabase *)db;
+(void)getInsertMyMessageSql;

//+ (int) refreshServerItems: (NSArray *)items withCourseItem:(NSMutableArray *)userCourseArray withUserId: (NSString *)userId;


//+ (void) dragToVacant: (FMDatabase *)db withCellIndex: (int)pageIndex withCellPageNo: (int) pageNo withFolderId:(NSString *)folderId;
//
//
//+ (void) removeItemWhenPaging: (FMDatabase *)db 
//                   withPageNo: (int)pageNo 
//                withPageIndex: (int)pageIndex 
//                 withFolderId: (NSString *)folderId;
//
//+ (void) insertItem: (FMDatabase *)db 
//     withCourseItem: (OMCourseItem *)courseItem 
//        withIsCheck: (BOOL) isCheck 
//      withTotalPage: (int) totalPageNum;
//+ (BOOL) saveTitleForCourseItem: (OMCourseItem *)courseItem;
//
//+ (void) insertItem:(FMDatabase *)db withCourseItem:(OMCourseItem *)courseItem;
//+ (void) updateToFolder:(FMDatabase *)db withItem:(OMCourseItem *)courseItem;
//+ (void) removeItem:(FMDatabase *)db withItem:(OMCourseItem *)courseItem;
//+ (void) fillChildItem: (NSMutableArray *)childArray withDB: (FMDatabase *)db withFolderId: (NSString *)folderId;
//+ (void) updatePageIndex: (FMDatabase *)db withItemId:(NSString *)itemId withPageIndex:(int)pageIndex;
//+ (NSArray *) searchCourse: (FMDatabase *)db withText: (NSString *)searchText withArray: (NSMutableArray *)searchArray;
//
//+(BOOL)excuDB:(NSString*)stmt withDB:(FMDatabase*)db;
//
//+(int)exceQueryMinId:(NSString*)stmt  withDB:(FMDatabase*)db;
@end
