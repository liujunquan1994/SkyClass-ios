//
//  loginViewController.m
//  Login
//
//  Created by menuz on 14-2-23.
//  Copyright (c) 2014年 menuz's lab. All rights reserved.
//

#import "loginViewController.h"
#import "MBProgressHUD.h"
#import "XJTUDLCAppDelegate.h"
#import "Student.h"
#import "Course.h"
#import "getJsonData.h"
#import "ZXCoreData.h"
#import "fileForCell.h"
#import "OMDataService.h"
#import "Attachment+CoreDataProperties.h"
#import "ASIInputStream.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "MJExtension.h"
#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]

@interface loginViewController ()
{
    UIView *loginView;
    NSMutableArray *videoArray;
    UIPageControl *pageControl;
    UIView *headView;
    NSTimer *timer;
    int currentPage;
    UIScrollView *slideScrollView;
    NSMutableArray *headVideoArray;
    int pageSize;
    int pageIndex;
    UILabel *nameLable;
    UIButton *playBtn;
    BOOL isLoading;
    int totalCount;
    OMDataService * OMDataService;
    NSString * resp;
   // IQKeyboardReturnKeyHandler * returnKeyHandler;

}
@end

@implementation loginViewController {
    
    MBProgressHUD *HUD;
    NSUserDefaults *userDefaults;  //用户登录帐号或密码
    NSUserDefaults *version;   //非学历版本货学历版本
    //IQKeyboardReturnKeyHandler *returnKeyHandler;
}
@synthesize myGetData=_myGetData;

@synthesize receive=_receive;
@synthesize  image=_image;
- (void)viewDidLoad
{

    [super viewDidLoad];


    CGSize size=[[UIScreen mainScreen]bounds].size;
    _image.frame=CGRectMake(0, 0, size.width, size.height);
    userDefaults=[NSUserDefaults standardUserDefaults];
    version = [NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"loginState"])
    {
        NSLog(@"loginstate 1");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self goToMainView];
        });
        //[self  performSelectorOnMainThread:@selector(goToMainView) withObject:nil waitUntilDone:FALSE];
        
    }
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];

    //	HUD.delegate = self;
	HUD.labelText = @"登录中...";
//    if ([self
    //键盘
//    returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc]init];
//    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyNext;
    
    /*
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
    returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc]initWithViewController:self];
    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    manager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    manager.canAdjustTextView  = YES;
     */
    _myGetData=[getJsonData sharedgetJsonData];

}
#pragma mark 以前写的更具用户名去课程信息
//// tap dismiss keyboard
//-(void)dismissKeyboard {
//    [self.view endEditing:YES];
//    [self.userPassword resignFirstResponder];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
- (IBAction)feiLogin:(id)sender {
    [version setBool:YES forKey:@"feixueli"];
    [HUD showWhileExecuting:@selector(loginUser) onTarget:self withObject:nil animated:YES];
}

*/


- (IBAction)Login:(id)sender {
    

    // MBProgressHUD后台新建子线程执行任务
    
    [HUD showWhileExecuting:@selector(loginUser) onTarget:self withObject:nil animated:YES];
}

// 子线程中
-(void) loginUser {
    // 显示进度条

    
    // 返回主线程执行
    if ([self loginWithUsername]) {
        
    dispatch_async(dispatch_get_main_queue(), ^{
        [self goToMainView];
    });
    //[self  performSelectorOnMainThread:@selector(goToMainView) withObject:nil waitUntilDone:FALSE];
    }
}

// 服务器交互进行用户名，密码认证

-(BOOL)loginWithUsername{
   
  
    //[self getOpenCourseVideoData];
    
    if(self.userName.text.length==0||self.userPassword.text.length==0){    //输入空告警
        UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"用户名或密码不能为空" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
        //MD5加密密码
        NSString *input_username = self.userName.text;
        NSString *input_password = self.userPassword.text;
        NSString *password_MD5 = [MyMD5 md5:input_password];
        NSLog(@"MD5结果:%@",password_MD5);
        NSLog(@"****************************************************************************");
        
        NSURL * url;
//        //httppost地址设置区分非学历版本和学历版本
//        if ([version boolForKey:@"feixueli"]) {
//            url = [NSURL URLWithString:@"http://feixueli.xjtudlc.com/MobileLearning/loginCheck.aspx"];
//        }else{
//            url = [NSURL URLWithString:@"http://xueli.xjtudlc.com/MobileLearning/loginCheck.aspx"];
//        }
        url = [NSURL URLWithString:@"https://xueli.xjtudlc.com/MobileLearning/loginCheck.aspx"];

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
        NSLog(@"login:%@",str);
        
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPBody:data];
        
        //httppost连接服务器
        _receive = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
        NSString *str1 = [[NSString alloc]initWithData:_receive encoding:NSUTF8StringEncoding];
        NSLog(@"返回:\n%@",str1);
        
        //str1 = @"success";//测试用
        
        //登陆成功判断
        // if([str1 isEqualToString: @"success"])
        if ([str1 hasPrefix:@"["]&&[str1 hasSuffix:@"]"])
        {
            
            [version setBool:NO forKey:@"feixueli"];
            [self insertLoginMes];
            [userDefaults setObject:self.userName.text forKey:@"loginName"];
            [userDefaults setBool:YES forKey:@"loginState"];
            [userDefaults synchronize];
            [userDefaults setObject:password_MD5 forKey:@"password"];
            NSLog(@"登陆成功");
            NSLog(@"登录返回数据%@",str1);
            NSMutableDictionary *myJson=[NSJSONSerialization JSONObjectWithData:_receive options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"***********************%@",myJson);
            NSLog(@"****************************************************************************");
            return true;

        }else{
        
            url = [NSURL URLWithString:@"https://feixueli.xjtudlc.com/MobileLearning/loginCheck.aspx"];
            
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
            NSLog(@"login:%@",str);
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            [request setHTTPBody:data];
            
            //httppost连接服务器
            _receive = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
            NSString *str1 = [[NSString alloc]initWithData:_receive encoding:NSUTF8StringEncoding];
            NSLog(@"返回%@",str1);

            if ([str1 hasPrefix:@"["]&&[str1 hasSuffix:@"]"])
            {
                
                [version setBool:YES forKey:@"feixueli"];
                [self insertLoginMes];
                [userDefaults setObject:self.userName.text forKey:@"loginName"];
                [userDefaults setBool:YES forKey:@"loginState"];
                [userDefaults synchronize];
                [userDefaults setObject:password_MD5 forKey:@"password"];

                NSLog(@"登陆成功");
                NSLog(@"登录返回数据%@",str1);
                NSLog(@"****************************************************************************");
                return true;
                
            }else if([str1 isEqualToString:@""])
            {
                UIAlertView *alert_error= [[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert_error show];
                return false;
            }else  {   //登陆失败判断
                
                UIAlertView *alert_fail= [[UIAlertView alloc] initWithTitle:@"用户名或密码错误" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //NSLog(@"%@",str1);//测试用
                [alert_fail show];
                return false;
            }

            
        }
        
    }

    return false;

}
//跳转到首页
-(void) goToMainView {

       [self performSegueWithIdentifier:@"GoToMainViewSegue" sender:self];
}
-(void)insertLoginMes{
    NSMutableDictionary *myJson=[NSJSONSerialization JSONObjectWithData:_receive options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"***********************%@",myJson);
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
                NSString *courseCode = [myDetail valueForKey:@"CourseCode"];
                NSString *courseName = [myDetail valueForKey:@"CourseName"];
                NSString *courseID=[myDetail valueForKey:@""];
                [courseForLogin addObject:courseCode];
                //httppost地址设置区分学历版本和非学历版本
                NSString *url_str;
                if ([version boolForKey:@"feixueli"]) {
                    url_str=[[NSString alloc]initWithFormat:@"https://feixueli.xjtudlc.com/MobileLearning/Get_Coursetree.aspx?cno=%@",courseCode];
                    
                }else{
                    //http://kjguanli.xjtudlc.com/index.php/Xjtudlc/xueli/get_course/cno/
                    //http://xueli.xjtudlc.com/MobileLearning/Get_Coursetree.aspx?cno=
                    url_str=[[NSString alloc]initWithFormat:@"https://kjguanli.xjtudlc.com/index.php/Xjtudlc/xueli/get_course/cno/%@",courseCode];
                    
                }
                
                NSURL *url = [NSURL URLWithString:url_str];
                NSLog(@"course meg url :%@",url_str);
                NSLog(@"--------%@",url);
                //httppost创建请求
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
                
                //httppost连接服务器
                NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
                if (received) {
                    
                    NSString *rec=[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
                    NSLog(@"rec--:%@",rec);
                    NSString *rec_2=[rec stringByReplacingOccurrencesOfString:@":]" withString:@":[]"];
                    //因为这次服务器发送的数据中在最后多个了一个null
                    NSInteger length = rec_2.length;
                    NSString * judgeString = [rec_2 substringFromIndex:length-4];
                    NSString * rec_1;
                    if ([judgeString isEqualToString:@"null"]) {
                        
                        rec_1 = [rec_2  substringToIndex:length-4];
                    }else{
                        
                        rec_1 = rec_2;
                    }
                    NSData *rec_3 = [rec_1 dataUsingEncoding:NSUTF8StringEncoding];
                    NSInteger length_1 = rec_3.length;
                    if (length_1 < 1000) {
                        count++;
                        continue;
                    }else{
                        NSMutableDictionary * json = [NSJSONSerialization JSONObjectWithData:rec_3 options:NSJSONReadingMutableContainers error:NULL];
                        
                        NSLog(@"json:%@",json);
                        NSArray *courseMeg=[json valueForKey:@"Tables"];
                        
                        
                        NSDictionary *dtcourse=[courseMeg objectAtIndex:0];
                        NSDictionary *dtplaycourse=[courseMeg objectAtIndex:1];
                        //NSDictionary *dtstructure=[courseMeg objectAtIndex:2];
                        
                        
                        
                        NSArray *courseArray=[dtcourse valueForKey:@"Rows"];
                        NSArray *fileArray=[dtplaycourse valueForKey:@"Rows"];
                        // NSArray *structArray=[dtstructure valueForKey:@"Rows"];
                        
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
                                // file.courseStructID=[onefile valueForKey:@"structureid"];
                                //  file.courseID=[onefile valueForKey:@"cid"];
                                file.status=@"0";
                                file.fileID=[onefile valueForKey:@"id"];
                                file.courseCode=courseCode;
                                // fileForCell *fileModel = [fileForCell mj_objectWithKeyValues:onefile];
                                [self.myGetData insertfile:file];
                            }
                        }
                        
                    }
                  /*
                   {
                        NSEnumerator *enumerator = [structArray objectEnumerator];
                        id anObject;
                        while (anObject = [enumerator nextObject]) {
                                  NSDictionary *oneStruct=anObject;

                            NSString *mycourseID=[oneStruct valueForKey:@"courseid"];
                            NSString *myID=[oneStruct valueForKey:@"id"];
                            NSString *name=[oneStruct valueForKey:@"name"];
                            NSLog(@"oneStruct : %@,%@,%@",mycourseID,myID,name);
                            [self.myGetData insertCourseStructWithID:myID courseID:mycourseID structName:name];
                        }
                    }  */

                }
                
                [self.myGetData insertCourseEntry:courseID courseCode:courseCode courseName:courseName teacher:@"" intr:@"" courseIDToSend:courseID];
                NSLog(@"courseID:  %@",courseIDToSend);
                NSString * attachmenUrlStr;
                if ([version boolForKey:@"feixueli"]) {
                    attachmenUrlStr=[[NSString alloc]initWithFormat:@"https://feixueli.xjtudlc.com/MobileLearning/Get_AttachmentList.aspx?CourseID=%@",courseIDToSend];
                }else{
                    
                    attachmenUrlStr=[[NSString alloc]initWithFormat:@"https://xueli.xjtudlc.com/MobileLearning/Get_AttachmentList.aspx?CourseID=%@",courseIDToSend];
                    
                }

                NSURL *attachmenurl = [NSURL URLWithString:attachmenUrlStr];
                NSLog(@"attachmenUrlStr :%@",attachmenUrlStr);
                //httppost创建请求
                
                NSMutableURLRequest *requestAttachment = [[NSMutableURLRequest alloc]initWithURL:attachmenurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
                
                //httppost连接服务器
                NSData *receivedAttachment = [NSURLConnection sendSynchronousRequest:requestAttachment returningResponse:nil error:nil];//等待返回参数
                if (receivedAttachment) {
                    NSMutableDictionary * json = [NSJSONSerialization JSONObjectWithData:receivedAttachment options:NSJSONReadingMutableContainers error:nil];
                    
                    NSLog(@"json:%@",json);
                    NSDictionary * attachmentList = [json valueForKey:@"Rows"];
                    
                    {
                        NSEnumerator *enumerator = [attachmentList objectEnumerator];
                        id anObject;
                        while (anObject = [enumerator nextObject]) {
                            NSDictionary *oneCourse=anObject;
                            NSString * articleID  = [oneCourse valueForKey:@"ArticleID"];
                            NSString * mainHead = [oneCourse valueForKey:@"MainHead"];
                            NSString * attachmentStatus = @"0";
                            NSString * attachmentPath =DocumentsDirectory;
                            attachmentPath = [attachmentPath stringByAppendingPathComponent:courseCode];
                            attachmentPath = [attachmentPath stringByAppendingPathComponent:courseName];
                            
                            [self.myGetData insertAttachmentWitharticleID:articleID mainHead:mainHead courseID:courseID attachmentPath:attachmentPath attachmentStatus:attachmentStatus];
                        }
                    }
                }

            }
           count++;
        }
        NSLog(@"courseCode%@",courseForLogin);
        NSString * learnProgressStr = [[NSString alloc]init];
        if ([version boolForKey:@"feixueli"]) {
            learnProgressStr = [NSString stringWithFormat:@"https://feixueli.xjtudlc.com/mobilelearning/LearningProgress.aspx?studentcode=%@",[userDefaults valueForKey:@"StudentCode"]];

        }else{
            
            learnProgressStr = [NSString stringWithFormat:@"https://xueli.xjtudlc.com/mobilelearning/LearningProgress.aspx?studentcode=%@",[userDefaults valueForKey:@"StudentCode"]];

            
        }

        NSURL *learnProgreeURL = [NSURL URLWithString:learnProgressStr];
        NSMutableURLRequest *learnProgressRequest = [[NSMutableURLRequest alloc]initWithURL:learnProgreeURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
        NSData *learnProgressData = [NSURLConnection  sendSynchronousRequest:learnProgressRequest returningResponse:nil error:nil];
        if (learnProgressData) {
            NSMutableDictionary * learnProgressJson = [NSJSONSerialization JSONObjectWithData:learnProgressData options:nil error:nil];
            NSLog(@"learnProgressJson:%@",learnProgressJson);
            NSDictionary * learnProgressDic = [learnProgressJson valueForKey:@"Rows"];
            NSEnumerator *enumerator = [learnProgressDic objectEnumerator];
            id anObject;
            while (anObject = [enumerator nextObject]) {
                NSDictionary *oneCourse=anObject;
                NSString* iTotalCreditHour = [oneCourse valueForKey:@"TOTALCREDITHOUR"];
                NSString* iSumCreditHour = [oneCourse valueForKey:@"SUMCREDITHOUR"];
                NSString* iGraduatelowlimDays = [oneCourse valueForKey:@"GRADUATELOWLIM"];
                NSString* iGraduatehighlimDays = [oneCourse valueForKey:@"GRADUATEHIGHLIM"];
                NSString* iStudyDays = [oneCourse valueForKey:@"STUDYDAYS"];
                NSLog(@"ooo");
                NSLog(@"%@，%@",iTotalCreditHour,iSumCreditHour);
//                NSString * allGrade  = [oneCourse valueForKey:@"SUMCREDITHOUR"];
//                NSString * getGrade = [oneCourse valueForKey:@"TOTALCREDITHOUR"];
                [userDefaults setObject:iTotalCreditHour forKey:@"TOTALCREDITHOUR"];
                [userDefaults setObject:iSumCreditHour forKey:@"SUMCREDITHOUR"];
                [userDefaults  setObject:iGraduatelowlimDays forKey:@"GRADUATELOWLIM"];
                [userDefaults setObject:iGraduatehighlimDays forKey:@"GRADUATEHIGHLIM"];
                [userDefaults setObject:iStudyDays forKey:@"STUDYDAYS"];
                
            }
        }
    
        [userDefaults setObject:courseForLogin forKey:@"courseList"];
    }

}
@end
