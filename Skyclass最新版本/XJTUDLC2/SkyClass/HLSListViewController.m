//
//  HLSListViewController.m
//  SkyClass
//
//  Created by skyclass on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HLSListViewController.h"
#import "HLSPlayer.h"
#import "hlsPlayerViewController.h"
#import "getJsonData.h"
#import <CoreData/CoreData.h>
#import "LiveList.h"
#import "XJTUDLCAppDelegate.h"
#import "Reachability.h"
#import "SCPlayerViewController.h"

@interface HLSListViewController ()

@end

@implementation HLSListViewController
@synthesize indication=_indication;
@synthesize myJson=_myJson;
@synthesize myNSFetchedResultsController=_myNSFetchedResultsController;




- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_myJson deleteAll:@"LiveList" key:@"classid"];

    _myJson=[getJsonData sharedgetJsonData];
    _myNSFetchedResultsController=[[NSFetchedResultsController alloc]init];
    NSLog(@"init myNsfetch");
    [self fetchContacts];
    [self performSelectorInBackground:@selector(refreshdata) withObject:nil];
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)refreshTableView{
    if(self.refreshControl.refreshing){
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中"];
        [self refreshdata];
        [self reloadView];
    }
}
- (void)viewDidUnload
{
    [self setIndication:nil];
     self.myNSFetchedResultsController=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)fetchContacts
{
    _myNSFetchedResultsController=[self.myJson getLiveListData];
    _myNSFetchedResultsController.delegate=self;
    NSError *error;
    if (![_myNSFetchedResultsController performFetch:&error]) {
        NSLog(@"fetched fail");
    }
}
-(void)reloadView{
    
    if(self.refreshControl ){
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    id sectionInfo=[[self.myNSFetchedResultsController sections]objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HLSCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    LiveList *dataForCell=[self.myNSFetchedResultsController objectAtIndexPath:indexPath];
    [[cell textLabel]setText:dataForCell.classname];
    [[cell detailTextLabel]setText:dataForCell.teachername];
    NSLog(@"cell is %@",cell.detailTextLabel.text);
    return  cell;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier]isEqualToString:@"toHLS"]){
        NSIndexPath *path=[self.tableView indexPathForCell:sender];
        hlsPlayerViewController *hls=[segue destinationViewController];
        LiveList *dataForCell=[self.myNSFetchedResultsController objectAtIndexPath:path];
        hls.hlsMsg=dataForCell;
        NSLog(@"goto hlsplayer %@",hls);
    }
}
- (IBAction)refresh:(id)sender {
     [self performSelectorOnMainThread:@selector(loaddata) withObject:nil waitUntilDone:NO];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:sender];
    [self performSelector:@selector(todoSomething:) withObject:sender afterDelay:1.0f];

}
-(void)todoSomething:(id)sender{
  [self performSelectorInBackground:@selector(refreshdata) withObject:nil];
    
}
-(void)loaddata{
    [self.indication startAnimating];
    
}
-(void)endload{
    [self.indication stopAnimating];
    
}
-(void)refreshdata{
    Reachability *reachable=[Reachability reachabilityWithHostName:@"www.xjtudlc.com"];
    switch ([reachable currentReachabilityStatus]) {
        case NotReachable:
        {
            [self performSelectorOnMainThread:@selector(endload) withObject:nil waitUntilDone:NO]; 
            [self performSelectorOnMainThread:@selector(alert_error) withObject:nil waitUntilDone:NO];

            NSLog(@"直播网络NotReachable");
                 }
            break;
        case ReachableViaWWAN:
        {
            NSLog(@"直播网络ReachableViaWWAN");
 
            [_myJson initHLSList];
            [self performSelectorOnMainThread:@selector(endload) withObject:nil waitUntilDone:NO];        }
            break;
        case ReachableViaWiFi:
        {
            
            NSLog(@"直播网络ReachableViaWiFi");
      
            [_myJson initHLSList];
            [self performSelectorOnMainThread:@selector(endload) withObject:nil waitUntilDone:NO];        }
            break;
            
        default:
            break;
    }




   
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            // [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}
-(void)alert_error{
    UIAlertView *alert_error= [[UIAlertView alloc] initWithTitle:@"直播网络连接错误" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert_error show];
}

@end

