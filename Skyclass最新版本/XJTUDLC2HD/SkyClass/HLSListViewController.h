//
//  HLSListViewController.h
//  SkyClass
//
//  Created by skyclass on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "ZXCoreData.h"
@class getJsonData;
@class LiveList;
@interface HLSListViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    ZXCoreData *helper;
}
@property(nonatomic,copy)NSFetchedResultsController *myNSFetchedResultsController;
@property(nonatomic,copy)getJsonData *myJson;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indication;
- (IBAction)refresh:(id)sender;
-(void)getdata;
-(void)loaddata;
-(void)endload;
-(void)refreshdata;
@end
