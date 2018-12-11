//
//  setViewController.m
//  XJTUDLC
//
//  Created by skyclass on 14-3-29.
//
//

#import "setViewController.h"
#import "Log.h"
#import "Reachability.h"
#import "IPDetector.h"
@interface setViewController ()
@property (nonatomic,strong) NSUserDefaults *userDefault;
@end

@implementation setViewController

@synthesize receive=_receive;

- (void)viewDidLoad
{
    [super viewDidLoad];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    getData = [getJsonData sharedgetJsonData];
    self.userDefault = [NSUserDefaults standardUserDefaults];
    NSString * getGradeStr = [self.userDefault valueForKey:@"TOTALCREDITHOUR"];
    NSString * allGradeStr = [self.userDefault valueForKey:@"SUMCREDITHOUR"];
    if (allGradeStr) {
        self.LBGetGrade.text =[NSString stringWithFormat:@"已取得%@学分",getGradeStr];
        self.LBAllGrade.text = [NSString stringWithFormat:@"需要取得%@学分",allGradeStr];
        double  allGrade = [allGradeStr doubleValue];
        double  getGrade = [getGradeStr doubleValue];
        double precentDouble = getGrade/allGrade;
        self.PVPercent.progress = precentDouble;
        int precentInt = precentDouble*100;
        NSLog(@"precentInt:%d",precentInt);
        NSString *precentStr = [NSString stringWithFormat:@"%d",precentInt];
        precentStr = [precentStr stringByAppendingString:@"%"];
        self.LBPercent.text = precentStr;
    }
    
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





- (IBAction)tongbu:(id)sender {
    HUD.labelText = @"上传中...";
    [HUD show:YES];
    Reachability *reachable=[Reachability reachabilityWithHostName:@"xueli.xjtudlc.com"];
    switch ([reachable currentReachabilityStatus]) {
        case NotReachable:
        {
            //  NSLog(@"日志网络NotReachable");
            [HUD hide:YES];
            UIAlertView *alert_error= [[UIAlertView alloc] initWithTitle:@"日志网络连接错误" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert_error show];
            
        }
            break;
        case ReachableViaWWAN:
        {
            [self performSelectorInBackground:@selector(upLoadMyLog) withObject:nil];
            NSLog(@"日志网络ReachableViaWWAN");
        }
            break;
        case ReachableViaWiFi:
        {
            [self performSelectorInBackground:@selector(upLoadMyLog) withObject:nil];
            NSLog(@"日志网络ReachableViaWiFi");
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)zhuxiao:(id)sender {
    [self performSelectorOnMainThread:@selector(alert_zhuxiao) withObject:nil waitUntilDone:YES];
    
}

- (IBAction)about:(id)sender {
    
    
}

- (IBAction)login:(id)sender {
    
    HUD.labelText = @"同步中...";
    [HUD show:YES];
    [self performSelectorInBackground:@selector(loginWithUsername) withObject:nil];
    
}

- (IBAction)shanchu:(id)sender {
    HUD.labelText = @"删除中...";
    [HUD show:YES];
    [self performSelectorInBackground:@selector(deleteAllCache) withObject:nil];
}

-(void)deleteAllCache{
    [getData deleteAll:@"NewsList" key:@"sid"];
    [getData deleteAll:@"LiveList" key:@"classid"];
    [getData deleteFile];
    [self performSelectorOnMainThread:@selector(alert_delete_success) withObject:nil waitUntilDone:YES];
}
-(void)upLoadMyLog{
    getData=[getJsonData sharedgetJsonData];
    [getData upLoadLog];
    [self performSelectorOnMainThread:@selector(alert_success) withObject:nil waitUntilDone:YES];
    
}

-(NSString *)gettime{
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    return morelocationString;
    
}



-(BOOL)loginWithUsername{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    
    
    
    //MD5加密密码
    NSString *input_username = [userDefaults stringForKey:@"loginName"];
    NSString *password_MD5 = [userDefaults stringForKey:@"password"];
    NSLog(@"MD5结果:%@",password_MD5);
    NSLog(@"****************************************************************************");
    
    //httppost地址设置
    NSURL *url = [NSURL URLWithString:@"http://xueli.xjtudlc.com/MobileLearning/loginCheck.aspx"];
    
    //httppost创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *temp1 = @"name=";
    NSString *temp2 = @"&";
    NSString *temp3 = @"password=";
    NSString *str;
    
    //httppost设置参数
    
    str  = [temp1 stringByAppendingString:input_username];
    str  = [str stringByAppendingString:temp2];
    str = [str stringByAppendingString:temp3];
    str = [str stringByAppendingString:password_MD5];
    
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    //httppost连接服务器
    _receive = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
    NSString *str1 = [[NSString alloc]initWithData:_receive encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);
    
    //str1 = @"success";//测试用
    
    //登陆成功判断
    // if([str1 isEqualToString: @"success"])
    if ([str1 hasPrefix:@"["]&&[str1 hasSuffix:@"]"])
    {
        
        
        [self insertLoginMes];
        [self performSelectorOnMainThread:@selector(alert_login_success) withObject:nil waitUntilDone:YES];
        return true;
        
        
    }
    else if([str1 isEqualToString:@""])
    {
        [self performSelectorOnMainThread:@selector(alert_error) withObject:nil waitUntilDone:YES];
        return false;
    }
    //登陆失败判断
    else
    {
        [self performSelectorOnMainThread:@selector(alert_fail) withObject:nil waitUntilDone:YES];
        return false;
    }
    return false;
    
}
-(void)insertLoginMes{
    
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *myJson=[NSJSONSerialization JSONObjectWithData:_receive options:NSJSONReadingMutableContainers error:nil];
    if (myJson!=nil){
        NSLog(@"course data in not nil");
        NSEnumerator *enumerator = [myJson objectEnumerator];
        id value;
        int count=1;
        NSMutableArray *courseForLogin=[[NSMutableArray alloc]init];
        while ((value = [enumerator nextObject])) {
            
            if(count==1)
            {
                //   NSLog(@"count :%d",count);
                NSDictionary *myDetail=value;
                NSString *StudentCode = [myDetail valueForKey:@"StudentCode"];
                [userDefaults setObject:StudentCode forKey:@"StudentCode"];
                NSLog(@"StudentCode %@",StudentCode);
            }
            else
            {
                
                NSDictionary *myDetail=value;
                NSString *courseIDToSend= [myDetail valueForKey:@"CourseID"];
                NSString *courseID=@"";
                NSString *courseCode = [myDetail valueForKey:@"CourseCode"];
                NSString *courseName = [myDetail valueForKey:@"CourseName"];
                [courseForLogin addObject:courseCode];
                //httppost地址设置
                NSString *url_str=[[NSString alloc]initWithFormat:@"http://xueli.xjtudlc.com/MobileLearning/Get_Coursetree.aspx?cno=%@",courseCode];
                NSURL *url = [NSURL URLWithString:url_str];
                NSLog(@"course meg url :%@",url_str);
                //httppost创建请求
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
                
                //httppost连接服务器
                NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
                if (received) {
                    
                    NSString *rec=[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
                    NSString *rec_2=[rec stringByReplacingOccurrencesOfString:@":]" withString:@":[]"];
                    NSLog(@"json:%@",rec_2);
                    NSData *rec_3=[rec_2 dataUsingEncoding:NSUTF8StringEncoding];
                    NSMutableDictionary *json=[NSJSONSerialization JSONObjectWithData:rec_3 options:NSJSONReadingMutableContainers error:nil];
                    
                    
                    NSLog(@"json:%@",json);
                    NSArray *courseMeg=[json valueForKey:@"Tables"];
                    
                    
                    NSDictionary *dtcourse=[courseMeg objectAtIndex:0];
                    NSDictionary *dtplaycourse=[courseMeg objectAtIndex:1];
                    NSDictionary *dtstructure=[courseMeg objectAtIndex:2];
                    
                    
                    
                    NSArray *courseArray=[dtcourse valueForKey:@"Rows"];
                    NSArray *fileArray=[dtplaycourse valueForKey:@"Rows"];
                    NSArray *structArray=[dtstructure valueForKey:@"Rows"];
                    
                    
                    {
                        NSEnumerator *enumerator = [courseArray objectEnumerator];
                        id anObject;
                        while (anObject = [enumerator nextObject]) {
                            NSDictionary *oneCourse=anObject;
                            courseID = [oneCourse valueForKey:@"id"];
                        }
                    }
                    
                    {
                        NSEnumerator *enumerator = [fileArray objectEnumerator];
                        id anObject;
                        while (anObject = [enumerator nextObject]) {
                            NSDictionary *onefile=anObject;
                            NSLog(@"onefile%@",onefile);
                            fileForCell *file=[[fileForCell alloc]init];
                            file.fileName=[onefile valueForKey:@"name"];
                            file.fileURL=[[onefile valueForKey:@"svpath"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            file.courseStructID=[onefile valueForKey:@"structureid"];
                            file.courseID=[onefile valueForKey:@"cid"];
                            file.status=@"0";
                            file.fileID=[onefile valueForKey:@"id"];
                            file.courseCode=courseCode;
                            [getData insertfile:file];
                        }
                    }
                    
                    {
                        NSEnumerator *enumerator = [structArray objectEnumerator];
                        id anObject;
                        while (anObject = [enumerator nextObject]) {
                            NSDictionary *oneStruct=anObject;
                            
                            NSString *mycourseID=[oneStruct valueForKey:@"courseid"];
                            NSString *myID=[oneStruct valueForKey:@"id"];
                            NSString *name=[oneStruct valueForKey:@"name"];
                            NSLog(@"oneStruct : %@,%@,%@",mycourseID,myID,name);
                            [getData insertCourseStructWithID:myID courseID:mycourseID structName:name];
                        }
                    }
                    
                }
                [getData insertCourseEntry:courseID courseCode:courseCode courseName:courseName teacher:@"" intr:@"" courseIDToSend:courseIDToSend];
                
            }
            
            count++;
        }
        NSLog(@"courseCode%@",courseForLogin);
        [userDefaults setObject:courseForLogin forKey:@"courseList"];
    }
}
-(void)alert_login_success
{
    [HUD hide:YES];
    UIAlertView *alert_success= [[UIAlertView alloc] initWithTitle:@"同步成功" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert_success show];
}
-(void)alert_delete_success
{
    [HUD hide:YES];
    UIAlertView *alert_success= [[UIAlertView alloc] initWithTitle:@"删除成功" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert_success show];
}
-(void)alert_fail
{  [HUD hide:YES];
    
    UIAlertView *alert_fail= [[UIAlertView alloc] initWithTitle:@"用户名或密码错误" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //NSLog(@"%@",str1);//测试用
    [alert_fail show];
}
-(void)alert_success{
    [HUD hide:YES];
    UIAlertView *alert_success= [[UIAlertView alloc] initWithTitle:@"日志上传成功" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert_success show];
}
-(void)alert_error{
    [HUD hide:YES];
    UIAlertView *alert_error= [[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert_error show];
}
-(void)alert_zhuxiao{
    NSString *msg = @"确定要注销登录？";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"暂不" otherButtonTitles:@"注销", nil];
    alertView.tag = 2000;
    [alertView show];
}
/*********/
-(void)GetUpdate
{
    //httppost地址设置
    NSString *url_str=[[NSString alloc]initWithFormat:@"http://itunes.apple.com/lookup?id=%@",@"868040155"];
    NSURL *url = [NSURL URLWithString:url_str];
    
    //httppost创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //httppost连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
    if (received!=nil) {
        NSMutableDictionary *json=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"version json%@",json);
        int resultCount=[json objectForKey:@"resultCount"];
        if (resultCount==1) {
            NSArray *reArray=[json objectForKey:@"results"];
            NSDictionary *reDict=[reArray objectAtIndex:0];
            NSString *latestVersion = [reDict objectForKey:@"version"];
            newsVersionUrl = [reDict objectForKey:@"trackViewUrl"];//地址trackViewUrl
            NSLog(@"latest version %@ ,url %@",latestVersion,newsVersionUrl);
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
            NSLog(@"nowversion %@",nowVersion);
            if ([latestVersion doubleValue] > [nowVersion doubleValue]) {
                [self performSelectorOnMainThread:@selector(alert_update) withObject:nil waitUntilDone:YES];
            }else
            {
                [self performSelectorOnMainThread:@selector(alert_update_no) withObject:nil waitUntilDone:YES];
            }
        }
        else{
            [self performSelectorOnMainThread:@selector(alert_update_error2) withObject:nil waitUntilDone:YES];
        }
        
    }
    else{
        [self performSelectorOnMainThread:@selector(alert_update_error) withObject:nil waitUntilDone:YES];
        
    }
}
-(void)alert_update{
    [HUD hide:YES];
    NSString *msg = [NSString stringWithFormat:@"最新版本为%@,是否更新？",newsVersionUrl];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"暂不" otherButtonTitles:@"立即更新", nil];
    alertView.tag = 1000;
    [alertView show];
}
-(void)alert_update_no{
    [HUD hide:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您使用的是最新版本！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alertView.tag = 1001;
    [alertView show];
}
-(void)alert_update_error{
    [HUD hide:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"网络错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alertView.tag = 1002;
    [alertView show];
}
-(void)alert_update_error2{
    [HUD hide:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"未检测到版本信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alertView.tag = 1003;
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        if (alertView.tag == 1000) {
            if(newsVersionUrl)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:newsVersionUrl]];
            }
        }
        if (alertView.tag == 2000) {
            NSLog(@"注销");
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setObject:Nil forKey:@"courseList"];
            [userDefaults setBool:NO forKey:@"loginState"];
            NSLog(@"loginstate 0");
            [userDefaults setObject:Nil forKey:@"loginName" ];
            [userDefaults setObject:nil forKey:@"StudentCode"];
            [userDefaults synchronize];
            [self performSegueWithIdentifier:@"GoToLogin" sender:self];
        }
    }
    
}
@end
