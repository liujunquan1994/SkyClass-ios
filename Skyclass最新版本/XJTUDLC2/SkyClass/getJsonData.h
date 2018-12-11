//
//  getJsonData.h
//  MyWebView
//
//  Created by skyclass on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LiveList.h"
#import "NewsList.h"
#import "Course.h"
#import "File.h"
#import "CourseStruct.h"
#import "fileForCell.h"
#import "Log.h"
#import "logMes.h"
#import "ZXCoreData.h"
@interface getJsonData : NSObject
{
    ZXCoreData *helper;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(NSMutableDictionary *)getNewsJsonData;
-(NSMutableDictionary *)getHLSJsonData;
-(void)initNewsList;
-(void)initHLSList;

-(void)deleteFile;
-(void)deletenewsdata;
-(void)deleteHLSdata;
-(void)deleteOne:(NSString *)str key:(NSString *)key value:(NSString *)value;
-(void)deleteAll:(NSString *)str key:(NSString *)key;
-(void)deleteAttachment;
-(void)displayError:(NSError *)theError;

-(NSMutableArray *)getdata:(NSString *)str key:(NSString *)key;
-(NSMutableArray *)getOne:(NSString *)str key:(NSString *)key value:(NSString *)value;
-(NSMutableArray *)getfiles:(NSString *)str key:(NSString *)key value:(NSString *)value;

-(void)insertCourseEntry:(NSString *)courseID courseCode:(NSString *)courseCode courseName:(NSString *)courseName teacher:(NSString *)teacher intr:(NSString *)intr courseIDToSend:(NSString *)courseIDToSend;
-(void)insertNewsListEntryWithsid:(NSString *)sid title:(NSString *)title keywords:(NSString *)keywords des:(NSString *)des;
-(void)insertLiveListEntryWithsid:(NSString *)classid classname:(NSString *)classname screenpath:(NSString *)screenpath serverpath:(NSString *)serverpath teachername:(NSString *)teachername time:(NSString *)time videopath:(NSString *)videopath location:(NSString *)location;
-(void)insertCourseStructWithID:(NSString *) structID courseID:(NSString *)courseID structName:(NSString *)structName;
-(void)insertAttachmentWitharticleID:(NSString *) articleID mainHead:(NSString *)mainHead  courseID:(NSString * )courseID attachmentPath:(NSString *)attachmentPath attachmentStatus:(NSString *)attachmentStatus;
-(void)insertfile:(fileForCell *)file;
-(void)insertLog:(logMes *)logMes;


-(NSFetchedResultsController *)getNewsListData;
-(NSFetchedResultsController *)getLiveListData;


-(id)initWithmanagedObjectContext:(NSManagedObjectContext *)context;
+(getJsonData*)sharedgetJsonData;
-(void)upLoadLog;
@end
