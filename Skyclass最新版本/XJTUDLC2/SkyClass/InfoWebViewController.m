//
//  InfoWebViewController.m
//  skyclass
//
//  Created by skyclass on 05/05/2017.
//
//

#import "InfoWebViewController.h"

@interface InfoWebViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webview;
@property (strong, nonatomic) UIActivityIndicatorView* activityIndicator;
@property (strong, nonatomic) NSURL *url;
@property (copy, nonatomic) NSString *title;
@end

@implementation InfoWebViewController

- (instancetype)initWithURL:(NSURL *)url Title:(NSString *)title{
    self = [super init];
    if(self){
          self.url = url;
          self.title = title;
//        [self setUrl:url];
//        [self setTitle:title];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.title;
    
    NSLog(@"webview : %@", self.url);
      
    self.webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webview.delegate = self;
      self.webview.scalesPageToFit = YES;
      self.webview.opaque = YES;
     
//      NSURL *url_ = [NSURL URLWithString:@"http://kefu.qycn.com/vclient/chat/?m=m&websiteid=60296"];
      //NSLog(@"hahahha %@", self.url);
      NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
      [self.webview loadRequest:request];
    
    [self.view addSubview:self.webview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [self.activityIndicator setCenter:view.center];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:self.activityIndicator];
    
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
    
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.activityIndicator stopAnimating];
    
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
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
