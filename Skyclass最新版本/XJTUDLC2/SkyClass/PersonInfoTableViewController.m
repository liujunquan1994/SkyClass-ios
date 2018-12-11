//
//  PersonInfoTableViewController.m
//  skyclass
//
//  Created by skyclass on 05/05/2017.
//
//

#import "PersonInfoTableViewController.h"
#import "InfoWebViewController.h"

#define StudentInfoAddress @"http://weixin.xjtudlc.com/WeixinServer/Studentbaseinfo.aspx?stucode="
#define StudentScoresAddress @"http://weixin.xjtudlc.com/WeixinServer/stuexam.aspx?stucode="
#define StudentExpensesAddress @"http://weixin.xjtudlc.com/WeixinServer/stuexpenses.aspx?stucode="

@interface PersonInfoTableViewController ()

@end

@implementation PersonInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *studentCode = [[NSUserDefaults standardUserDefaults] valueForKey:@"StudentCode"];
    NSString *basicAddress = @"";
    NSString *title = @"";
    if(indexPath.row == 0){
        basicAddress = StudentInfoAddress;
        title = @"基本信息";
    }
    else if(indexPath.row == 1){
        basicAddress = StudentExpensesAddress;
        title = @"费用信息";
    }
    else if (indexPath.row == 2)
    {
        basicAddress = StudentScoresAddress;
        title = @"成绩信息";
    }
//    else if(indexPath.row == 3)
//    {
//          basicAddress = KefuRandomAddress;
//          title = @"随机客服";
//    }
//    else if(indexPath.row == 4)
//    {
//          basicAddress = KefuFeixueliAddress;
//          title = @"非学历客服咨询";
//    }else if(indexPath.row == 5)
//    {
//          basicAddress =  KefuIntergatedWangAddress;
//          title = @"综合服务王老师";
//    }else if(indexPath.row == 6)
//    {
//          basicAddress =  KefuIntergatedMiaoAddress;
//          title = @"综合服务苗老师";
//    }else if(indexPath.row == 7)
//    {
//          basicAddress =  KefuIntergatedTangAddress;
//          title = @"综合服务唐老师";
//    }else if(indexPath.row == 8)
//    {
//          basicAddress = KefuTeacherYuAddress;
//          title = @"班主任于老师";
//    }else if(indexPath.row == 9)
//    {
//          basicAddress =  KefuTeacherLiAddress;
//          title = @"班主任李老师";
//    }else if(indexPath.row == 10)
//    {
//          basicAddress =  KefuTeacherLiuAddress;
//          title = @"班主任刘老师";
//    }else if(indexPath.row == 11)
//    {
//          basicAddress = KefuTechnologyAddress;
//          title = @"技术支持客服咨询";
//    }else if(indexPath.row == 12)
//    {
//          basicAddress =  KefuEnrollmentWangAddress;
//          title = @"招生王老师";
//    }
//    else if(indexPath.row == 13)
//    {
//          basicAddress = KefuEnrollmentLiAddress;
//          title = @"招生李老师";
//    }else
//    {
//          basicAddress =  KefuRobotAddress;
//          title = @"机器人客服";
//    }

    
    [self goToWebViewController:[NSString stringWithFormat:@"%@%@", basicAddress, studentCode] title:title];
}

- (void)goToWebViewController:(NSString *)urlStr title:(NSString *)title{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSLog(@"request to %@", url);
    
    InfoWebViewController *webController = [[InfoWebViewController alloc] initWithURL:url Title:title];
    
    [self.navigationController pushViewController:webController animated:YES];
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
