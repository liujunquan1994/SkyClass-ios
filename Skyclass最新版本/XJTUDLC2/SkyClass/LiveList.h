//
//  LiveList.h
//  SkyClass
//
//  Created by skyclass on 13-1-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LiveList : NSManagedObject

@property (nonatomic, retain) NSString * classid;
@property (nonatomic, retain) NSString * classname;
@property (nonatomic, retain) NSString * screenpath;
@property (nonatomic, retain) NSString * serverpath;
@property (nonatomic, retain) NSString * teachername;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * videopath;
@property (nonatomic,retain)  NSString * location;
@end
