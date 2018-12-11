//
//  NewsView.m
//  SkyClass
//
//  Created by skyclass on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsView.h"
#import "Reachability.h"
@interface NewsView ()

@end

@implementation NewsView
@synthesize sid=_sid;
@synthesize title_str = _title_str;
@synthesize content = _content;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize size=[[UIScreen mainScreen]bounds].size;
    _content.frame=CGRectMake(0, 0, size.width, size.height);

    Reachability *reachable=[Reachability reachabilityWithHostName:@"www.xjtudlc.com"];
    switch ([reachable currentReachabilityStatus]) {
        case NotReachable:
        {
            NSLog(@"新闻网络NotReachable");
            UIAlertView *alert_error= [[UIAlertView alloc] initWithTitle:@"新闻网络连接错误" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert_error show];
        }
            break;
        case ReachableViaWWAN:
        {
            NSLog(@"新闻网络ReachableViaWWAN");
            [self performSelectorInBackground:@selector(getdata) withObject:nil];
        }
            break;
        case ReachableViaWiFi:
        {
            
            NSLog(@"新闻网络ReachableViaWiFi");
            [self performSelectorInBackground:@selector(getdata) withObject:nil];
        }
            break;
            
        default:
            break;
    }


	// Do any additional setup after loading the view.

}

- (void)viewDidUnload
{
    [self setContent:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)getdata{
   /* NSString *url=[[NSString alloc]initWithFormat:@"http://www.xjtudlc.com/iphone_dlc/news.php?id=%@",_sid];
    NSLog(@"sid=%@ url=%@",_sid,url);
    NSURL *req=[NSURL URLWithString:url];
    NSData *data=[NSData dataWithContentsOfURL:req];*/
    //httppost地址设置
    NSString *url_str=[[NSString alloc]initWithFormat:@"http://www.xjtudlc.com/iphone_dlc/news.php?id=%@",_sid];
    NSURL *url = [NSURL URLWithString:url_str];
    
    //httppost创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //httppost连接服务器
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
    if (data==nil) {
        UIAlertView *alert_error= [[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert_error show];

    }

    Byte *mybyte=[data bytes];
    int lenth=[data length];
    int i;
    for (i=0; i<lenth; i++) {
        if (mybyte[i]==0x0a||mybyte[i]==0x0d||mybyte[i]==0x09||mybyte[i]==0x08||mybyte[i]==0x0b) {
            mybyte[i]=0x20;
        }
    }
    NSData *data2=[NSData dataWithBytes:mybyte length:lenth];
    NSMutableDictionary *json=[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
    NSString *content=[json valueForKey:@"content"];
    CGSize size=[[UIScreen mainScreen]bounds].size;
    int width= size.width;
    NSString *css=@"<style type=\"text/css\">"
    " .suofang {MARGIN: auto;WIDTH: 400px;}"
    "  .suofang img{MAX-WIDTH: 100%!important;HEIGHT: auto!important;width:expression(this.width > 400 ? \"400px\" :     this.width)!important;}"
    " </style>";
    NSString *mycontent=[[NSString alloc]initWithFormat:@"<html><head>%@</head><body><div class=\"suofang\" style= \"word-wrap : break-word; word-break: normal; width : %dpx; font-size :20px;\"><p style=\"font-weight:bold\">%@</p>%@</div></body></html>",css,(width-20),_title_str,content];
    NSLog(@"content :%@",mycontent);
    [self.content loadHTMLString:mycontent baseURL:nil];
    
 }
@end
