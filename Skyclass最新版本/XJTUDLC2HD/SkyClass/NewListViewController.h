//
//  NewListViewController.h
//  SkyClass
//
//  Created by skyclass on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "ZXCoreData.h"
@class indicateViewController;
@class getJsonData;
@interface NewListViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    ZXCoreData *helper;
}
@property(nonatomic,copy)getJsonData *myJson;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicate;
@property(nonatomic,copy)NSFetchedResultsController *myNSFetchedResultsController;


- (IBAction)refresh:(UIBarButtonItem *)sender;
-(void)getdata;
-(void)loaddata;
-(void)endload;
-(void)refreshNewsListdata;

@end
