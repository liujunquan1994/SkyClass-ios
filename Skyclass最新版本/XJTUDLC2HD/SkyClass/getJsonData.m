//
//  getJsonData.m
//  MyWebView
//
//  Created by skyclass on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserve
#import "getJsonData.h"
#import "LiveList.h"
#import "NewsList.h"
#import "Course.h"
#import <CoreData/CoreData.h>
#import "XJTUDLCAppDelegate.h"
#import <UIKit/UIKit.h>
#import "Attachment+CoreDataProperties.h"
#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]
#define MUSICFile [DocumentsDirectory stringByAppendingPathComponent:file.fileName]
@implementation getJsonData
@synthesize managedObjectContext=_managedObjectContext;

static getJsonData *getData;
+(getJsonData*)sharedgetJsonData
{
    if(getData != nil) return getData;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        getData = [[getJsonData alloc] initHelper];
    
    });
    return getData;
}

-(id)initWithmanagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super init];
    if (self) {
        _managedObjectContext=context;
        NSLog(@"getJsonData init with %@",context);
    }
    return  self;
}
-(id)initHelper{
    self=[super init];
    if (self) {
       
     helper = [ZXCoreData sharedZXCoreData];

    }
    return  self;

}

-(NSMutableDictionary *)getNewsJsonData{
    /*NSURL *req=[NSURL URLWithString:@"http://www.xjtudlc.com/iphone_dlc/newlist.php"];
    NSData *data=[NSData dataWithContentsOfURL:req];
    if (data==nil) {
        return nil;}
    NSMutableDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (json) {
        return json;
    }            
    else {
        return nil;
        
        
        
        
    }*/
    //httppost地址设置
    NSURL *url = [NSURL URLWithString:@"http://www.xjtudlc.com/iphone_dlc/newlist.php"];
    
    //httppost创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //httppost连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
    if (received==nil) {
        return nil;
    }
    NSMutableDictionary *json=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    if (json) {
        return json;
    }
    else {
        return nil;
    }

    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    
    
    
}
-(NSMutableDictionary *)getHLSJsonData{
   /* NSURL *req=[NSURL URLWithString:@"http://www.xjtudlc.com/iphone_dlc/live.php"];
    NSData *data=[NSData dataWithContentsOfURL:req];
    if (data==nil) {
        return nil;}
    NSMutableDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (json) {
        return json;
    }            
    else {
        return nil;
    }*/
    //httppost地址设置
    NSURL *url = [NSURL URLWithString:@"http://www.skyclass.net/iphone/hls.php"];

    
    //httppost创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //httppost连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
    if (received==nil) {
        return nil;
    }
    NSMutableDictionary *json=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    if (json) {
        return json;
    }
    else {
        return nil;
    }
    
    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    

}
-(void)initNewsList{
    NSMutableDictionary *myJson=[self getNewsJsonData];
    NSEnumerator *enumerator = [myJson objectEnumerator];
    id value;
    
    while ((value = [enumerator nextObject])) {
        /* code that acts on the dictionary’s values */
        NSDictionary *myDetail=value;
        NSString *sid=[myDetail valueForKey:@"id"];
        NSString *title=[myDetail valueForKey:@"title"];
        NSString *keywords=[myDetail valueForKey:@"keywords"];
        NSString *des=[myDetail valueForKey:@"description"];
        [self insertNewsListEntryWithsid:sid title:title keywords:keywords des:des];
      }
}

-(void)initHLSList{
    
    NSMutableDictionary *myJson=[self getHLSJsonData];
    NSEnumerator *enumerator = [myJson objectEnumerator];
    id value;
    [self deleteAll:@"LiveList" key:@"classid"];
    
    while ((value = [enumerator nextObject])) {
        /* code that acts on the dictionary’s values */
        NSDictionary *myDetail=value;
        NSString *classid=[myDetail valueForKey:@"classid"];
        NSString *classname=[myDetail valueForKey:@"classname"];
        NSString *teachername=[myDetail valueForKey:@"teachername"];
        NSString *videopath=[myDetail valueForKey:@"videopath"];
        NSString *screenpath=[myDetail valueForKey:@"screenpath"];
        NSString *time=[myDetail valueForKey:@"starttime"];
        NSString *serverpath=[myDetail valueForKey:@"serverpath"];
        NSString *location=[myDetail valueForKey:@"location"];
        [self insertLiveListEntryWithsid:classid classname:classname screenpath:screenpath serverpath:serverpath teachername:teachername time:time videopath:videopath location:location];
        
    }
    
    
}



//***************通用方法*******************
-(NSMutableArray *)getdata:(NSString *)str key:(NSString *)key{

    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:str inManagedObjectContext:helper.managedObjectContext];
	[request setEntity:entity];
	
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
    
    
	
	// Execute the fetch -- create a mutable copy of the result.
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[helper.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
	
	// Set self's events array to the mutable array, then clean up.
	return mutableFetchResults;
}

-(NSMutableArray *)getOne:(NSString *)str key:(NSString *)key value:(NSString *)value
{

    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:str inManagedObjectContext:helper.managedObjectContext];
	[request setEntity:entity];
	
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
    
    NSPredicate *qcondition=[NSPredicate predicateWithFormat:@"%K = %@",key,value];
    [request setPredicate:qcondition];
	
	// Execute the fetch -- create a mutable copy of the result.
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[helper.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
	
	// Set self's events array to the mutable array, then clean up.
	return mutableFetchResults;
}
-(NSMutableArray *)getfiles:(NSString *)str key:(NSString *)key value:(NSString *)value
{
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:str inManagedObjectContext:helper.managedObjectContext];
	[request setEntity:entity];
	
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fileID" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
    
    NSPredicate *qcondition=[NSPredicate predicateWithFormat:@"%K = %@",key,value];
    [request setPredicate:qcondition];
	
	// Execute the fetch -- create a mutable copy of the result.
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[helper.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
	
	// Set self's events array to the mutable array, then clean up.
	return mutableFetchResults;
}

-(void)deleteOne:(NSString *)str key:(NSString *)key value:(NSString *)value
{

    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:str inManagedObjectContext:[helper childThreadContext] ];
	[request setEntity:entity];
	
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
    
    NSPredicate *qcondition=[NSPredicate predicateWithFormat:@"%K = %@",key,value];
    [request setPredicate:qcondition];
	      [[helper childThreadContext]  performBlockAndWait:^{
	// Execute the fetch -- create a mutable copy of the result.
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[[helper childThreadContext] executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
    else
    {
        NSEnumerator *enumerator = [mutableFetchResults objectEnumerator];
        id anObject;
        
        while (anObject = [enumerator nextObject]) {
            /* code to act on each element as it is returned */
            [[helper childThreadContext] deleteObject:anObject];
            NSError *error;
            if(![[helper childThreadContext]  save:&error]){
                NSLog(@"error delete :%@",[error description]);
            }
        }
    }
          }];
}
-(void)deleteAll:(NSString *)str key:(NSString *)key
{

    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:str inManagedObjectContext:[helper childThreadContext] ];
    [request setEntity:entity];
    
    // Order the events by creation date, most recent first.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
   

          [[helper childThreadContext]  performBlockAndWait:^{
    // Execute the fetch -- create a mutable copy of the result.
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[[helper childThreadContext]  executeFetchRequest:request error:&error] mutableCopy];
    NSEnumerator *enumerator = [mutableFetchResults objectEnumerator];
    id anObject;
    
    while (anObject = [enumerator nextObject]) {
        /* code to act on each element as it is returned */
        [[helper childThreadContext]  deleteObject:anObject];
        NSError *error;  
        if(![[helper childThreadContext]  save:&error]){
            NSLog(@"error delete :%@",[error description]);
        }
    }
          }];
}
-(void)insertCourseEntry:(NSString *)courseID courseCode:(NSString *)courseCode courseName:(NSString *)courseName teacher:(NSString *)teacher intr:(NSString *)intr courseIDToSend:(NSString *)courseIDToSend
{

    
    NSLog(@"插入数据course");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:[helper childThreadContext] ];
    [request setEntity:entity];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"courseCode = %@",courseCode];
    [request setPredicate:predicate];
      [[helper childThreadContext]  performBlockAndWait:^{
    NSArray *dataArray = [[helper childThreadContext]  executeFetchRequest:request error:nil];
    if ([dataArray count] > 0) {
        NSLog(@"数据已经存在，更新。。。");
        Course *oldEntry = [dataArray objectAtIndex:0];
        [[helper childThreadContext]  deleteObject:oldEntry];
        Course *entry=(Course *)[NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext: [helper childThreadContext] ];
        entry.courseCode=courseCode;
        entry.courseID =courseID;
        entry.courseName=courseName;
        entry.teacher=teacher;
        entry.introduction=intr;
        entry.courseIDTOSend=courseIDToSend;
        NSError *error;
        if (![[helper childThreadContext]  save:&error]) {
            NSLog(@"error saving :%@",[error description]);
        }
        else{
            NSLog(@"更新成功 %@", oldEntry);
          }
    }
    else{
        NSLog(@"数据不存在，插入。。。");
        Course *entry=(Course *)[NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext: [helper childThreadContext] ];
        entry.courseCode=courseCode;
        entry.courseID =courseID;
        entry.courseName=courseName;
        entry.teacher=teacher;
        entry.introduction=intr;
        entry.courseIDTOSend=courseIDToSend;
        NSError *error;
        if (![[helper childThreadContext]  save:&error]) {
            NSLog(@"error saving :%@",[error description]);
        }
          NSLog(@"插入成功 %@", entry);

    }
      }];
}


-(NSFetchedResultsController *)getLiveListData{
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"LiveList" inManagedObjectContext:helper.managedObjectContext];
	[request setEntity:entity];
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"classid" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
    [request setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                        managedObjectContext:helper.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    
    return theFetchedResultsController;
}
-(NSFetchedResultsController *)getNewsListData{

 
        
 
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"NewsList" inManagedObjectContext:helper.managedObjectContext];
	[request setEntity:entity];
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sid" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
    [request setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                        managedObjectContext:helper.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    
    return theFetchedResultsController;

}
-(void)insertNewsListEntryWithsid:(NSString *)sid title:(NSString *)title keywords:(NSString *)keywords des:(NSString *)des
{
    
    
    
    NSLog(@"插入数据NewsList");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NewsList" inManagedObjectContext:[helper childThreadContext]];
    [request setEntity:entity];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"sid = %@",sid];
    [request setPredicate:predicate];
    [[helper childThreadContext]  performBlockAndWait:^{
        NSArray *dataArray = [[helper childThreadContext]  executeFetchRequest:request error:nil];
        if ([dataArray count] > 0) {
            NSLog(@"数据已经存在");
            
    /*      NewsList *entry = [dataArray objectAtIndex:0];
             
             
             entry.sid=sid;
             entry.title =title;
             entry.keywords=keywords;
             entry.des=des;
          
            BOOL result = [[helper childThreadContext]  save:nil];
            if (result) {
                NSLog(@"更新成功");
            }else{
                NSLog(@"更新失败");
            }*/
        }
        else{
            NSLog(@"数据不存在，插入。。。");
            NewsList *entry=(NewsList *)[NSEntityDescription insertNewObjectForEntityForName:@"NewsList" inManagedObjectContext: [helper childThreadContext] ];
            entry.sid=sid;
            entry.title =title;
            entry.keywords=keywords;
            entry.des=des;
            NSError *error;
            if (![[helper childThreadContext]  save:&error]) {
                NSLog(@"error saving :%@",[error description]);
            }
            NSLog(@"插入成功%@", entry);
            
        }
        
    }];
}
-(void)insertLiveListEntryWithsid:(NSString *)classid classname:(NSString *)classname screenpath:(NSString *)screenpath serverpath:(NSString *)serverpath teachername:(NSString *)teachername time:(NSString *)time videopath:(NSString *)videopath location:(NSString *)location
{
   
    
    NSLog(@"插入数据LiveList");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LiveList" inManagedObjectContext:[helper childThreadContext] ];
    [request setEntity:entity];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"classid = %@",classid];
    [request setPredicate:predicate];
      [[helper childThreadContext]  performBlockAndWait:^{
    NSArray *dataArray = [[helper childThreadContext]  executeFetchRequest:request error:nil];
    if ([dataArray count] > 0) {
        NSLog(@"数据已经存在，更新。。。");
   
        LiveList *oldEntry = [dataArray objectAtIndex:0];
        [[helper childThreadContext]deleteObject:oldEntry];
        LiveList *newEntry=(LiveList *)[NSEntityDescription insertNewObjectForEntityForName:@"LiveList" inManagedObjectContext: [helper childThreadContext] ];

        newEntry.classid   = classid;
        newEntry.classname=classname;
        newEntry.screenpath=screenpath;
        newEntry.serverpath=serverpath;
        newEntry.teachername=teachername;
        newEntry.time=time;
        newEntry.videopath=videopath;
        newEntry.location=location;
        BOOL result = [[helper childThreadContext]  save:nil];
        if (result) {
            NSLog(@"更新成功%@", oldEntry);
        }else{
            NSLog(@"更新失败");
        }
    
    }
    else{
        NSLog(@"数据不存在，插入。。。");
        LiveList *oldEntry=(LiveList *)[NSEntityDescription insertNewObjectForEntityForName:@"LiveList" inManagedObjectContext: [helper childThreadContext] ];
        oldEntry.classid   = classid;
        oldEntry.classname=classname;
        oldEntry.screenpath=screenpath;
        oldEntry.serverpath=serverpath;
        oldEntry.teachername=teachername;
        oldEntry.time=time;
        oldEntry.videopath=videopath;
        oldEntry.location=location;
        NSError *error;
        if (![[helper childThreadContext] save:&error]) {
            NSLog(@"error saving :%@",[error description]);
        }
        NSLog(@"插入成功%@", oldEntry);
        
    }
      }];
}
-(void)insertCourseStructWithID:(NSString *) structID courseID:(NSString *)courseID structName:(NSString *)structName{
    NSLog(@"插入数据CourseStructWithID");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CourseStruct" inManagedObjectContext:[helper childThreadContext]];
    [request setEntity:entity];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"courseStructID = %@",structID];
    [request setPredicate:predicate];
    [[helper childThreadContext] performBlockAndWait:^{
        NSArray *dataArray = [[helper childThreadContext] executeFetchRequest:request error:nil];
        if ([dataArray count] > 0) {
            NSLog(@"数据已经存在");
           CourseStruct *oldEntryForDelete = [dataArray objectAtIndex:0];
            [[helper childThreadContext] deleteObject:oldEntryForDelete];
            CourseStruct *oldEntry=(CourseStruct *)[NSEntityDescription insertNewObjectForEntityForName:@"CourseStruct" inManagedObjectContext: [helper childThreadContext]];
            oldEntry.courseID   = courseID;
            oldEntry.courseStructID=structID;
            oldEntry.courseStructName=structName;
            BOOL result = [[helper childThreadContext] save:nil];
            if (result) {
                NSLog(@"更新成功%@", oldEntry);
            }else{
                NSLog(@"更新失败");
            }
        }
        else{
            NSLog(@"数据不存在，插入。。。");
            CourseStruct *oldEntry=(CourseStruct *)[NSEntityDescription insertNewObjectForEntityForName:@"CourseStruct" inManagedObjectContext: [helper childThreadContext]];
            oldEntry.courseID   = courseID;
            oldEntry.courseStructID=structID;
            oldEntry.courseStructName=structName;
            NSError *error;
            if (![[helper childThreadContext] save:&error]) {
                NSLog(@"error saving :%@",[error description]);
            }
            NSLog(@"插入成功%@", oldEntry);
            
        }
    }];
}

-(void)insertAttachmentWitharticleID:(NSString *) articleID mainHead:(NSString *)mainHead  courseID:(NSString * )courseID attachmentPath:(NSString *)attachmentPath attachmentStatus:(NSString *)attachmentStatus{
    NSLog(@"插入数据Attachmen");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Attachment" inManagedObjectContext:[helper childThreadContext]];
    [request setEntity:entity];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"articleID = %@",articleID];
    [request setPredicate:predicate];
    [[helper childThreadContext] performBlockAndWait:^{
        NSArray *dataArray = [[helper childThreadContext] executeFetchRequest:request error:nil];
        if ([dataArray count] > 0) {
            NSLog(@"数据已经存在");
            Attachment *oldEntryForDelete = [dataArray objectAtIndex:0];
            [[helper childThreadContext] deleteObject:oldEntryForDelete];
            Attachment *oldEntry=(Attachment *)[NSEntityDescription insertNewObjectForEntityForName:@"Attachment" inManagedObjectContext: [helper childThreadContext]];
            oldEntry.courseID   = courseID;
            oldEntry.articleID=articleID;
            oldEntry.mainHead=mainHead;
            oldEntry.attachmentPath = attachmentPath;
            oldEntry.attachmentStatus = attachmentStatus;
            BOOL result = [[helper childThreadContext] save:nil];
             if (result) {
             NSLog(@"更新成功%@", oldEntry);
             }else{
             NSLog(@"更新失败");
             }
        }
        else{
            NSLog(@"数据不存在，插入。。。");
            Attachment *oldEntry=(Attachment *)[NSEntityDescription insertNewObjectForEntityForName:@"Attachment" inManagedObjectContext: [helper childThreadContext]];
            oldEntry.courseID   = courseID;
            oldEntry.articleID=articleID;
            oldEntry.mainHead=mainHead;
            oldEntry.attachmentPath = attachmentPath;
            oldEntry.attachmentStatus = attachmentStatus;
            NSError *error;
            if (![[helper childThreadContext] save:&error]) {
                NSLog(@"error saving :%@",[error description]);
            }
            NSLog(@"插入成功%@", oldEntry);
            
        }
    }];
}

-(void)insertfile:(fileForCell *)file{
    NSLog(@"插入数据file");
    if (![file.status isEqualToString:@"3"]) {
        NSString  *filePath=[MUSICFile stringByAppendingPathComponent:@"Screen.mp4"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:MUSICFile]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:MUSICFile withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSFileManager *fileMnager=[NSFileManager defaultManager];
        if ([fileMnager fileExistsAtPath:filePath]) {
            file.filePath=filePath;
            file.status=@"3";
        }

    }
       NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"File" inManagedObjectContext:[helper childThreadContext]];
    [request setEntity:entity];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"fileID = %@",file.fileID];
    [request setPredicate:predicate];
    [[helper childThreadContext] performBlockAndWait:^{
        NSArray *dataArray = [[helper childThreadContext] executeFetchRequest:request error:nil];
        if ([dataArray count] > 0) {
            NSLog(@"数据已经存在，更新。。。");
           //   File *oldEntryfordelete = [dataArray objectAtIndex:0];
           //  [[helper childThreadContext] deleteObject:oldEntryfordelete];
           //  File *oldEntry=(File *)[NSEntityDescription insertNewObjectForEntityForName:@"File" inManagedObjectContext: [helper childThreadContext]];
            
            File *oldEntry = [dataArray objectAtIndex:0];
            
            
             oldEntry.fileName   = file.fileName;
             oldEntry.filePath=file.filePath;
             oldEntry.fileURL=file.fileURL;
             oldEntry.status=file.status;
             oldEntry.courseID=file.courseID;
             oldEntry.courseStructID=file.courseStructID;
             oldEntry.fileID=file.fileID;
             oldEntry.progress=file.progress;
             oldEntry.courseCode=file.courseCode;
             BOOL result = [[helper childThreadContext] save:nil];
             if (result) {
             NSLog(@"更新成功%@", oldEntry);
             }else{
             NSLog(@"更新失败");
             }
        }
        else{
            NSLog(@"数据不存在，插入。。。");
            File *oldEntry=(File *)[NSEntityDescription insertNewObjectForEntityForName:@"File" inManagedObjectContext: [helper childThreadContext]];
            oldEntry.fileName   = file.fileName;
            oldEntry.filePath=file.filePath;
            oldEntry.fileURL=file.fileURL;
            oldEntry.status=file.status;
            oldEntry.courseID=file.courseID;
            oldEntry.courseStructID=file.courseStructID;
              oldEntry.fileID=file.fileID;
            oldEntry.progress=file.progress;
            oldEntry.courseCode=file.courseCode;

            NSError *error;
            if (![[helper childThreadContext] save:&error]) {
                NSLog(@"error saving :%@",[error description]);
            }
            NSLog(@"插入成功%@", oldEntry);
            
        }
    }];
}

-(void)insertLog:(logMes *)logMes{
    [[helper childThreadContext] performBlockAndWait:^{

            NSLog(@"数据不存在，插入。。。");
            Log *Entry=(Log *)[NSEntityDescription insertNewObjectForEntityForName:@"Log" inManagedObjectContext: [helper childThreadContext]];
        Entry.file=logMes.file;
        Entry.courseCode=logMes.courseCode;
        Entry.studentCode=logMes.studentCode;
        Entry.time=logMes.time;
        Entry.len=logMes.len;
        Entry.operationID=logMes.operationID;

            NSError *error;
            if (![[helper childThreadContext] save:&error]) {
                NSLog(@"error saving :%@",[error description]);
            }
            NSLog(@"插入成功%@", Entry);
        
    }];
}


-(void)displayError:(NSError *)theError
{
	if (theError)
	{
		UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error"
                              message: [theError localizedDescription]
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
		[alert show];
	}
}


-(void)deleteFile
{
    NSLog(@"deleteFile");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"File" inManagedObjectContext:[helper childThreadContext] ];
	[request setEntity:entity];
	
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"courseCode" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	// Execute the fetch -- create a mutable copy of the result.
     [[helper childThreadContext] performBlockAndWait:^{
         NSError *error = nil;

	NSMutableArray *mutableFetchResults = [[[helper childThreadContext] executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
    else
    {
        NSEnumerator *enumerator = [mutableFetchResults objectEnumerator];
        id anObject;
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        NSArray *courseArray=[userDefaults arrayForKey:@"courseList"];
        NSLog(@"courseList%@",courseArray);
        NSLog(@"file%@",mutableFetchResults);
        while (anObject = [enumerator nextObject]) {
            /* code to act on each element as it is returned */
            File *tempFile=anObject;

            if ([courseArray indexOfObject:tempFile.courseCode]==NSNotFound) {
                NSFileManager *fileMnager=[NSFileManager defaultManager];
                if ([fileMnager fileExistsAtPath:tempFile.filePath]) {
                    [fileMnager removeItemAtPath:tempFile.filePath error:nil];
                    tempFile.filePath=nil;
                    tempFile.status=0;
                    tempFile.progress=0;
                    [[helper childThreadContext] save:nil];
                    NSLog(@"删除%@",tempFile);
                }
            }
        }
    }}];
}
-(void)deleteAttachment{
    NSLog(@"deleteAttachment");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Attachment" inManagedObjectContext:[helper childThreadContext] ];
    [request setEntity:entity];
    
    // Order the events by creation date, most recent first.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"courseID" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    // Execute the fetch -- create a mutable copy of the result.
    [[helper childThreadContext] performBlockAndWait:^{
        NSError *error = nil;
        
        NSMutableArray *mutableFetchResults = [[[helper childThreadContext] executeFetchRequest:request error:&error] mutableCopy];
        if (mutableFetchResults == nil) {
            // Handle the error.
        }
        else
        {
            NSEnumerator *enumerator = [mutableFetchResults objectEnumerator];
            id anObject;
           // NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//            NSArray *courseArray=[userDefaults arrayForKey:@"courseList"];
//            NSLog(@"courseList%@",courseArray);
//            NSLog(@"file%@",mutableFetchResults);
            while (anObject = [enumerator nextObject]) {
                /* code to act on each element as it is returned */
                Attachment *tempAttachment=anObject;
                
                
                    NSFileManager *fileMnager=[NSFileManager defaultManager];
                    if ([fileMnager fileExistsAtPath:tempAttachment.attachmentPath]) {
                        [fileMnager removeItemAtPath:tempAttachment.attachmentPath error:nil];
                        tempAttachment.attachmentPath=nil;
                        tempAttachment.attachmentStatus=@"1";
                       // tempAttachment.progress=0;
                        [[helper childThreadContext] save:nil];
                        NSLog(@"删除%@",tempAttachment);
                    }
                }
            }
    }];

    
}


-(void)upLoadLog{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *studentCode=[userDefaults stringForKey:@"StudentCode"];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Log" inManagedObjectContext:[helper childThreadContext] ];
	[request setEntity:entity];
	
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"studentCode" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
    
    NSPredicate *qcondition=[NSPredicate predicateWithFormat:@"%K = %@",@"studentCode",studentCode];
    [request setPredicate:qcondition];
    [[helper childThreadContext]  performBlockAndWait:^{
        // Execute the fetch -- create a mutable copy of the result.
        NSError *error = nil;
        NSMutableArray *mutableFetchResults = [[[helper childThreadContext] executeFetchRequest:request error:&error] mutableCopy];
        if (mutableFetchResults == nil) {
            // Handle the error.
        }
        else
        {
            NSEnumerator *enumerator = [mutableFetchResults objectEnumerator];
            id anObject;
            
            while (anObject = [enumerator nextObject]) {
                Log *templog=anObject;
 
////////////////////
                NSString *str=[[NSString alloc]initWithFormat:@"p=3&o=%@&t=%@&s=%@&c=%@&l=%@&i=%@",templog.operationID,templog.time,templog.studentCode,templog.courseCode,templog.len,templog.file];

                NSString *url_str=[[NSString alloc]initWithFormat:@"http://xueli.xjtudlc.com/MobileLearning/learningLog.aspx?%@",str];
                NSString *webUrl=[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *url = [NSURL URLWithString:webUrl];
                
         
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];

               //httppost连接服务器
                NSData  *receive= [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
                NSString *str_re = [[NSString alloc]initWithData:receive encoding:NSUTF8StringEncoding];
                NSLog(@"返回%@",str_re);

                
                
                
//                
//        
//                NSString *str2=[[NSString alloc]initWithFormat:@"p=3&o=2&t=%@&s=%@&c=%@&l=%@&i=%@",[self gettime],templog.studentCode,templog.courseCode,templog.len,templog.file];
//                NSString *url_str2=[[NSString alloc]initWithFormat:@"http://xueli.xjtudlc.com/MobileLearning/learningLog.aspx?%@",str2];
//                NSString *webUrl2=[url_str2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//                NSURL *url2 = [NSURL URLWithString:webUrl2];
//                
//                //httppost创建请求
//                
//            NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc]initWithURL:url2 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
//            
//         
//                              //httppost连接服务器
//                NSData  *receive2= [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];//等待返回参数
//                NSString *str_re2 = [[NSString alloc]initWithData:receive2 encoding:NSUTF8StringEncoding];
//                NSLog(@"返回%@",str_re2);

                [[helper childThreadContext] deleteObject:anObject];
                NSError *error;
               if(![[helper childThreadContext]  save:&error]){
                    NSLog(@"error delete :%@",[error description]);
                }
         }
     }
    }];

    
}
-(NSString *)getIP{
    /*
     [IPDetector getLANIPAddressWithCompletion:^(NSString *IPAddress) {
     self->LANIp = IPAddress;
     
     
     }];
     [IPDetector getWANIPAddressWithCompletion:^(NSString *IPAddress) {
     self->WANIp = IPAddress;
     
     }];*/
    NSString *url_str=[[NSString alloc]initWithFormat:@"http://202.117.16.110:9090/University/tracking/logtest.aspx?p=3"];
    /*  NSString *url_str=[[NSString alloc]initWithFormat:@"http://202.117.16.110:9090/University/tracking/logtest.aspx?p=3&o=1&t=2014-04-04 17:12:33&s=001&c=JS015&f=202.117.10.53&i=JAVA语言-第一章 语言概述-Java语言背景"];*/
    NSURL *url = [NSURL URLWithString:url_str];
    
    //httppost创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //httppost连接服务器
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
    NSString *str1 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"ip return %@",str1);
    NSArray *array=[str1 componentsSeparatedByString:@"?"];
    NSString *ip=[array firstObject];
    NSLog(@"ip return %@",ip);
    return ip;
    
}
-(NSString *)gettime{
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    return morelocationString;
    
}
@end
