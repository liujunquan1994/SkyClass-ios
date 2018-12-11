//
//  SkyClassAppDelegate.h
//  SkyClass
//
//  Created by skyclass on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ZXCoreData.h"

@interface XJTUDLCAppDelegate : UIResponder <UIApplicationDelegate>
{
    ZXCoreData *helper;
}
/*
@property (nonatomic ,retain, readonly)NSManagedObjectModel *managedObjectModel;
@property(nonatomic,retain,readonly)    NSManagedObjectContext *managedObjectContext;
@property(nonatomic,retain,readonly)    NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) NSOperationQueue *parseQueue;  */

@property (strong, nonatomic) UIWindow *window;

@end
