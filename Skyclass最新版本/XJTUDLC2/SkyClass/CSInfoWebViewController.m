//
//  CSInfoWebViewController.m
//  skyclass
//
//  Created by liujunquan on 2017/10/6.
//
//

#import "CSInfoWebViewController.h"

@interface CSInfoWebViewController ()<UIWebViewDelegate>

@end

@implementation CSInfoWebViewController

UIActivityIndicatorView *activityIndicator;
/*
- (instancetype)initWithURL:(NSURL *)url Title:(NSString *)title{
      self = [super init];
      if(self){
            self.url = url;
            self.title = title;
      }
      return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem.title = self.title;
      self.webview = [[UIWebView alloc] initWithFrame:self.view.frame];
      self.webview.delegate = self;
      self.webview.scalesPageToFit = YES;
      self.webview.opaque = YES;
      
      NSURL *new_url = [NSURL URLWithString:self.url];
      
      NSURLRequest *request = [NSURLRequest requestWithURL:new_url];
      [self.webview loadRequest:request];
      
      [self.view addSubview:self.webview];

}
-(void)webViewDidStartLoad:(UIWebView *)webView{
      activityIndicator.hidden = NSNotFound;
      [activityIndicator startAnimating];
      
                  UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
                  [view setTag:108];
                  [view setBackgroundColor:[UIColor blackColor]];
                  [view setAlpha:0.5];
                  [self.view addSubview:view];
            
                  UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
                  [activityIndicator setCenter:self.view.center];
                  activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
                  [self.view addSubview:activityIndicator];
            
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
      [activityIndicator stopAnimating];
      activityIndicator.hidden = YES;
      
      UIView *view = (UIView*)[self.view viewWithTag:108];
      [view removeFromSuperview];
      NSLog(@"webViewDidFinishLoad");
      
//                  CGSize contentSize = webView.scrollView.contentSize;
//                  CGSize viewSize = self.view.bounds.size;
//            
//                  float rw = viewSize.width / contentSize.width;
//            
//                  webView.scrollView.minimumZoomScale = rw;
//                  webView.scrollView.maximumZoomScale = rw;
//                  webView.scrollView.zoomScale = rw;
//      
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
