//
//  CourseBBSViewController.m
//  skyclass
//
//  Created by 柳俊全 on 2017/12/22.
//

#import "CourseBBSViewController.h"
#import "InfoWebViewController.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "Cell.h"
#import "Course.h"
#import "XJTUDLCAppDelegate.h"
#import "collectionTableViewController.h"
#import "ChooseViewController.h"
#import "loginViewController.h"
#import "Reachability.h"
@interface CourseBBSViewController ()

@end

@implementation CourseBBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//     [self performSelectorInBackground:@selector(CourseBBS) withObject:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (IBAction)button:(id)sender {
    [self CourseBBS];
}

- (void) CourseBBS{
    //[MyMD5 md5:input_password];
    NSString *studentCode = [[NSUserDefaults standardUserDefaults] valueForKey:@"StudentCode"];
    NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"loginName"];
    NSString *usertype = @"0";
    NSString *from = @"202.117.16.41";
    NSString *PassWord = @"coursebbs.open.com.cn";
    NSString *KeyFormatString = [NSString stringWithFormat:@"%@%@%@%@",userName,usertype,from,PassWord];
    NSLog(@"拼接后的结果是：%@",KeyFormatString);
    NSString *KeyFormat =[MyMD5 md5:KeyFormatString];
    NSLog(@"加密后的结果是：%@",KeyFormat);
    // KeyFormat = [KeyFormat stringByAppendingFormat:@"%@,%@,%@,%@",userName,usertype,from,PassWord];
    NSString *title = @"";
    NSString *coursebbs_ = [NSString stringWithFormat:@"http://mbbs.xjtudlc.com/coursebbs/login.aspx?username=%@&usertype=0&from=202.117.16.41&key=%@&cmd=main&parm=&studentcode=%@",userName,KeyFormat,studentCode];
    NSString *basicAddress = coursebbs_;
    [self goToWebViewController:[NSString stringWithFormat:@"%@", basicAddress] title:title];
    
}

- (void)goToWebViewController:(NSString *)urlStr title:(NSString *)title{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSLog(@"request to %@", url);
    
    InfoWebViewController *webController = [[InfoWebViewController alloc] initWithURL:url Title:title];
    
    [self.navigationController pushViewController:webController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
