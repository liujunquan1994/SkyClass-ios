//
//  SkyClassAppDelegate.m
//  SkyClass
//
//  Created by skyclass on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XJTUDLCAppDelegate.h"
#import <CoreData/CoreData.h>
#import "getJsonData.h"
#import "NewListViewController.h"
#import "IQKeyboardManager.h"
@implementation XJTUDLCAppDelegate

@synthesize window = _window;

/*
@synthesize managedObjectModel=_managedObjectModel;
@synthesize managedObjectContext=_managedObjectContext;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;
@synthesize parseQueue=_parseQueue;*/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
        [[IQKeyboardManager sharedManager] setEnable:YES];
         [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:80];
          helper = [ZXCoreData sharedZXCoreData];

    // Override point for customization after application launch.
   /* NewListViewController *ViewController = [[NewListViewController alloc] initWithStyle:UITableViewStylePlain];
    NSManagedObjectContext *context = [self managedObjectContext];
	if (!context) {
		// Handle the error.
	}
    ViewController.managedObjectContext = context;
    ViewController.myJson.managedObjectContext=context;*/
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  /*  NSError *error;
    if (_managedObjectContext != nil) {
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
	
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }*/
      [helper saveContext];

}
/*
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator!=nil) {
        return _persistentStoreCoordinator;
    }
    NSString *docs=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSURL *storeUrl=[NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"XJTUDLC.sqlite"]];
    NSError *error=nil;
    _persistentStoreCoordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]){
         NSLog(@"unresolved error %@,%@",error,[error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}
-(NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext!=nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator=[self persistentStoreCoordinator];
    if (coordinator!=nil) {
        _managedObjectContext=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    NSLog(@"main manageContext %@",_managedObjectContext);
    return _managedObjectContext;
}
-(NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel!=nil) {
        return _managedObjectModel;
    }
    _managedObjectModel=[NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;                
}

*/
@end
