//
//  testFileViewController.m
//  XJTUDLC
//
//  Created by skyclass on 14-3-31.
//
//

#import "testFileViewController.h"
#import "fileForCell.h"
#import "fileCell.h"
@interface testFileViewController ()

@end

@implementation testFileViewController
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"test";
    fileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    fileForCell *tempFile=[[fileForCell alloc]init];
    tempFile.fileName=@"123";
    tempFile.fileURL=@"http://kj.xjtudlc.com/YC/JS015/01/Screen.mp4";
    tempFile.status=@"0";
    tempFile.courseID=@"123";
    [cell initWithfileforcell:tempFile delegate:self];

    // Configure the cell...
    
    return cell;
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(void)fileCellStatusChange:(fileCell *)cell{
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:cell waitUntilDone:YES];
}

-(void)fileCellStop:(fileCell *)cell{
    
}
-(void)fileCellDownload:(fileCell*)cell{
  
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:cell waitUntilDone:YES];

}
-(void)updateCell:(fileCell *)cell{
    NSLog(@"updateCell per %f  status %@",cell.progressValue,cell.myFile.status);
    [cell.progress setProgress: cell.progressValue];
    if (    cell.progress.progress>0) {
        cell.progress.hidden=NO;
    }
    NSLog(@"progress.progress %f",cell.progress.progress);
    if ([cell.myFile.status isEqualToString:@"0"])
    {
    
        [cell.downloadStatus setTitle:@"下载" forState: UIControlStateNormal];
        cell.progress.hidden=YES;
        cell.downloadStatus.hidden = NO;

        
    }
    else if ([cell.myFile.status isEqualToString:@"1"]){
               [cell.downloadStatus setTitle:@"暂停" forState: UIControlStateNormal];
    }
    else if ([cell.myFile.status isEqualToString:@"2"]){
         [cell.downloadStatus setTitle:@"继续" forState: UIControlStateNormal];
    }
    else if([cell.myFile.status isEqualToString:@"3"])
    {
            [cell.downloadStatus setTitle:@"已下载" forState: UIControlStateNormal];
        cell.progress.hidden=YES;
        cell.downloadStatus.hidden = YES;
    }
}
@end
