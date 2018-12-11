//
//  NewListViewController.m
//  SkyClass
//
//  Created by skyclass on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewListViewController.h"
#import "getJsonData.h"
#import "NewsList.h"
#import "NewsView.h"
#import "Reachability.h"
#import "XJTUDLCAppDelegate.h"
@interface NewListViewController ()

@end

@implementation NewListViewController
@synthesize myJson=_myJson;
@synthesize indicate = _indicate;

@synthesize myNSFetchedResultsController=_myNSFetchedResultsController;


-(id)initWithStyle:(UITableViewStyle)style
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


    
    _myJson=[getJsonData sharedgetJsonData];
    _myNSFetchedResultsController=[[NSFetchedResultsController alloc]init];
    NSLog(@"init news feched");
    [self fetchContacts];
   [self performSelectorInBackground:@selector(refreshNewsListdata) withObject:nil];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    self.myNSFetchedResultsController=nil;
    [self setIndicate:nil];
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
    _myNSFetchedResultsController=[self.myJson getNewsListData];
    _myNSFetchedResultsController.delegate=self;
    NSError *error;
    if (![_myNSFetchedResultsController performFetch:&error]) {
        NSLog(@"fetched fail");
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

/*******************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"begin cell");
    static NSString *CellIdentifier = @"tablecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NewsList *dataForCell=[self.data objectAtIndex:indexPath.row];
    UILabel *title=(UILabel *)[cell viewWithTag:100];
    UILabel *des=(UILabel *)[cell viewWithTag:101];
    title.text=dataForCell.title;
    des.text=dataForCell.des;
    UIFont *font_title=[title font];
    UIFont *font_des=[des font];
    CGSize size=CGSizeMake(280, 1000);
    CGSize size_title=[title.text sizeWithFont:font_title constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [title setFrame:CGRectMake(10,10, size_title.width, size_title.height)];
    CGSize size_des=[des.text sizeWithFont:font_des constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [des setFrame:CGRectMake(15, size_title.height+12, size_des.width, size_des.height)];
    
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsList *dataForCell=[self.data objectAtIndex:indexPath.row];
    UIFont *font_title=[UIFont systemFontOfSize:14];;
    UIFont *font_des=[UIFont systemFontOfSize:12];
    CGSize size=CGSizeMake(280, 1000);
    CGSize size_title=[dataForCell.title sizeWithFont:font_title constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    CGSize size_des=[dataForCell.des sizeWithFont:font_des constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    NSLog(@"cell heigh%f",(size_des.height+size_title.height+30));
    return (size_des.height+size_title.height+25);
    
}
/***************************
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

     
}
/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier]isEqualToString:@"NewsView"]){
        NSIndexPath *path=[self.tableView indexPathForCell:sender];
        NewsView *myview=[segue destinationViewController];
        NewsList *dataForCell=[_data objectAtIndex:path.row];
        myview.sid=dataForCell.sid;
        myview.title_str=dataForCell.title;
        NSLog(@"goto newview %@",myview);
    }
}
 */
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self performSelectorOnMainThread:@selector(loaddata) withObject:nil waitUntilDone:NO];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:sender];
    [self performSelector:@selector(todoSomething:) withObject:sender afterDelay:1.0f];
}
-(void)todoSomething:(id)sender{
    [self performSelectorInBackground:@selector(refreshNewsListdata) withObject:nil];

}
-(void)loaddata{
    [self.indicate startAnimating];

}
-(void)endload{
    [self.indicate stopAnimating];

}
/****************/
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
/****************/


 -(void)refreshNewsListdata{
     Reachability *reachable=[Reachability reachabilityWithHostName:@"www.xjtudlc.com"];
     switch ([reachable currentReachabilityStatus]) {
         case NotReachable:
         {
            [self performSelectorOnMainThread:@selector(endload) withObject:nil waitUntilDone:NO];   
             [self performSelectorOnMainThread:@selector(alert_error) withObject:nil waitUntilDone:NO];
             
             NSLog(@"新闻网络NotReachable");
         }
             break;
         case ReachableViaWWAN:
         {
             NSLog(@"新闻网络ReachableViaWWAN");
             [_myJson initNewsList];
             [self performSelectorOnMainThread:@selector(endload) withObject:nil waitUntilDone:NO];        }
             break;
         case ReachableViaWiFi:
         {
             
             NSLog(@"新闻网络ReachableViaWiFi");
             [_myJson initNewsList];
             [self performSelectorOnMainThread:@selector(endload) withObject:nil waitUntilDone:NO];        }
             break;
             
         default:
             break;
     }
     
     
     
     
 
 }

 
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 if([[segue identifier]isEqualToString:@"NewsView"]){
 NSIndexPath *path=[self.tableView indexPathForCell:sender];
 NewsView *myview=[segue destinationViewController];
 NewsList *dataForCell=[self.myNSFetchedResultsController objectAtIndexPath:path];
 myview.sid=dataForCell.sid;
 myview.title_str=dataForCell.title;
 NSLog(@"goto newview %@",myview);
 }
 }
 
 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 NewsList *dataForCell=[self.myNSFetchedResultsController objectAtIndexPath:indexPath];
 UIFont *font_title=[UIFont systemFontOfSize:18];;
 UIFont *font_des=[UIFont systemFontOfSize:16];
 CGSize my_size=[[UIScreen mainScreen]bounds].size;
 CGSize size=CGSizeMake(my_size.width, 1000);
 CGSize size_title=[dataForCell.title sizeWithFont:font_title constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
 CGSize size_des=[dataForCell.des sizeWithFont:font_des constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
 
 //  NSLog(@"cell heigh%f",(size_des.height+size_title.height+30));
 return (size_des.height+size_title.height+50);
 
 }
 
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 //NSLog(@"begin cell");
 static NSString *CellIdentifier = @"tablecell";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 NewsList *dataForCell=[self.myNSFetchedResultsController objectAtIndexPath:indexPath];
 UILabel *title=(UILabel *)[cell viewWithTag:100];
 UILabel *des=(UILabel *)[cell viewWithTag:101];
 title.text=dataForCell.title;
 des.text=dataForCell.des;
 UIFont *font_title=[title font];
 UIFont *font_des=[des font];
 CGSize my_size=[[UIScreen mainScreen]bounds].size;

 CGSize size=CGSizeMake(my_size.width, 1000);
 CGSize size_title=[title.text sizeWithFont:font_title constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
 [title setFrame:CGRectMake(15,10, size_title.width, size_title.height)];
 CGSize size_des=[des.text sizeWithFont:font_des constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
 [des setFrame:CGRectMake(35, size_title.height+25, size_des.width, size_des.height)];
 
 return cell;
 
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
     id sectionInfo=[[self.myNSFetchedResultsController sections]objectAtIndex:section];
     return [sectionInfo numberOfObjects];
}
-(void)alert_error{
    
UIAlertView *alert_error= [[UIAlertView alloc] initWithTitle:@"新闻网络连接错误" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
[alert_error show];
}

@end
