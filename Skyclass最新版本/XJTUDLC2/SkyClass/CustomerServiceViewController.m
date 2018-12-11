//
//  CustomerServiceViewController.m
//  skyclass
//
//  Created by liujunquan on 2017/7/24.
//
//

#import "CustomerServiceViewController.h"
      //#import "CSInfoWebViewController.h"
#import "InfoWebViewController.h"

#define KefuRandomAddress @"http://kefu.ziyun.com.cn/vclient/chat/?websiteid=60296"
#define KefuFeixueliAddress @"http://kefu.ziyun.com.cn/vclient/chat/?websiteid=38839"
#define KefuIntergatedWangAddress @"http://kefu.ziyun.com.cn/vclient/chat/?websiteid=60296&groupid=32057"
//#define KefuIntergatedMiaoAddress @"http://kefu.qycn.com/vclient/chat/?websiteid=60296&clerkid=721037"
//#define KefuIntergatedTangAddress @"http://kefu.qycn.com/vclient/chat/?websiteid=60296&clerkid=721040"
#define KefuTeacherYuAddress @"http://kefu.ziyun.com.cn/vclient/chat/?websiteid=60296&groupid=38889"
//#define KefuTeacherLiAddress @"http://kefu.qycn.com/vclient/chat/?websiteid=60296&clerkid=982945"
//#define KefuTeacherLiuAddress @"http://kefu.qycn.com/vclient/chat/?websiteid=60296&clerkid=826496"
#define KefuTechnologyAddress @"http://kefu.ziyun.com.cn/vclient/chat/?websiteid=60296&groupid=35504"
#define KefuEnrollmentWangAddress @"http://kefu.ziyun.com.cn/vclient/chat/?websiteid=60296&groupid=33079"
#define KefuEnrollmentLiAddress @"http://kefu.ziyun.com.cn/vclient/chat/?websiteid=60296&clerkid=844622"
#define KefuRobotAddress @"http://kefu.ziyun.com.cn/vclient/chat/?websiteid=60296&robot=1"



@interface  CustomerServiceViewController ()//<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webview;

@end

@implementation CustomerServiceViewController
UIActivityIndicatorView* activityIndicator;


- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = @"在线客服";
      
      self.tableView.tableFooterView = [[UIView alloc] init];
    // Do any additional setup after loading the view.

            //_webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 375, 670)];
            //UIWebView *myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//      self.webview.scalesPageToFit = YES;
//      self.webview = [[UIWebView alloc] initWithFrame:self.view.frame];
//      
//      self.webview.delegate = self;
//      activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//      [activityIndicator setCenter:self.view.center];
//      activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
//      [self.view addSubview:activityIndicator];
//      activityIndicator.hidden = YES;
//                 //_webview.height = _webview.scrollView.contentSize.height;
//            // [self.webview setScalesPageToFit:YES];
//      
//      self.webview.opaque = YES;
//      NSURL *url = [NSURL URLWithString:@"http://kefu.qycn.com/vclient/chat/?m=m&websiteid=60296"];
//            //InfoWebViewController *info = [[InfoWebViewController alloc] initWithURL:url Title:nil];
//            // [self.navigationController pushViewController:info animated:YES];
//      NSURLRequest *request = [NSURLRequest requestWithURL:url];
//      [self.webview loadRequest:request];
//      [self.view addSubview:self.webview];
      

      
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      NSString *studentCode = [[NSUserDefaults standardUserDefaults] valueForKey:@"StudentCode"];
      NSString *basicAddress = @"";
      NSString *title = @"";
      if(indexPath.section == 0 && indexPath.row == 0)
      {
          basicAddress =  KefuIntergatedWangAddress;
            title = @"综合服务";
      }
//      else if(indexPath.section == 0 && indexPath.row == 1)
//      {
//            basicAddress =  KefuIntergatedMiaoAddress;
//            title = @"综合服务苗老师";
//      }else if(indexPath.section == 0 && indexPath.row == 2)
//      {
//            basicAddress =  KefuIntergatedTangAddress;
//            title = @"综合服务唐老师";
//      }
      else if(indexPath.section == 1 && indexPath.row == 0)
      {
            basicAddress = KefuTeacherYuAddress;
            title = @"班主任";
      }
//      else if(indexPath.section == 1 && indexPath.row == 1)
//      {
//            basicAddress =  KefuTeacherLiAddress;
//            title = @"班主任李老师";
//      }else if(indexPath.section == 1 && indexPath.row == 2)
//      {
//            basicAddress =  KefuTeacherLiuAddress;
//            title = @"班主任刘老师";
//      }
      else if(indexPath.section == 2 && indexPath.row == 0)
      {
            basicAddress =  KefuEnrollmentWangAddress;
            title = @"招生咨询";
      }
      else if(indexPath.section == 3 && indexPath.row == 0)
      {
            basicAddress = KefuFeixueliAddress;
            title = @"非学历咨询";
      }
      else if(indexPath.section == 3 && indexPath.row == 1)
      {
            basicAddress = KefuTechnologyAddress;
            title = @"技术支持";
      }
      //      else if(indexPath.section == 2 && indexPath.row == 1)
//      {
//            basicAddress = KefuEnrollmentLiAddress;
//            title = @"招生李老师";
//      }
      else
      {
            basicAddress =  KefuRobotAddress;
            title = @"机器人客服";
      }
      
      
      [self goToWebViewController:[NSString stringWithFormat:@"%@", basicAddress] title:title];
}
// [self goToWebViewController:[NSString stringWithFormat:@"%@%@%@%@", coursebbs,username,coursebbs2,studentcode] title:title];
- (void)goToWebViewController:(NSString *)urlStr title:(NSString *)title{
      NSURL *url = [NSURL URLWithString:urlStr];
      
      NSLog(@"request to %@", url);
      
      
      InfoWebViewController *webController = [[InfoWebViewController alloc] initWithURL:url Title:title];
      [self.navigationController pushViewController:webController animated:YES];
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
      activityIndicator.hidden = NSNotFound;
      [activityIndicator startAnimating];
      
//      UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
//      [view setTag:108];
//      [view setBackgroundColor:[UIColor blackColor]];
//      [view setAlpha:0.5];
//      [self.view addSubview:view];
//
//      UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//      [activityIndicator setCenter:self.view.center];
//      activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
//      [self.view addSubview:activityIndicator];
//
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
      [activityIndicator stopAnimating];
      activityIndicator.hidden = YES;
      
      UIView *view = (UIView*)[self.view viewWithTag:108];
      [view removeFromSuperview];
      NSLog(@"webViewDidFinishLoad");

//      CGSize contentSize = webView.scrollView.contentSize;
//      CGSize viewSize = self.view.bounds.size;
//      
//      float rw = viewSize.width / contentSize.width;
//      
//      webView.scrollView.minimumZoomScale = rw;
//      webView.scrollView.maximumZoomScale = rw;
//      webView.scrollView.zoomScale = rw;
      
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
      [activityIndicator stopAnimating];
      
      UIView *view = (UIView*)[self.view viewWithTag:108];
      [view removeFromSuperview];
}
-(void)goClicked{

}

//- (IBAction)kefu:(id)sender {
//      UIWebView *myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 370)];
//      myWebView.opaque = NO;
//      myWebView.scalesPageToFit = YES;
//      NSURL *url = [NSURL URLWithString:@"http://kefu.qycn.com/vclient/chat/?m=m&websiteid=60296"];
//      NSURLRequest *request = [NSURLRequest requestWithURL:url];
//      [myWebView loadRequest:request];
//      [self.view addSubview:myWebView];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
