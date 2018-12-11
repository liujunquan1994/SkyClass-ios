/*
     File: ViewController.m
 Abstract: The primary view controller for this app.
 
  Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 */

#import "ViewController.h"
#import "DetailViewController.h"
#import "Cell.h"
#import "Course.h"
#import "XJTUDLCAppDelegate.h"
#import "collectionTableViewController.h"
#import "ChooseViewController.h"
#import "loginViewController.h"
#import "Reachability.h"
#import "InfoWebViewController.h"
#import "loginViewController.h"
#import "MBProgressHUD.h"
#import "Student.h"
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
//#define coursebbs @"http://mbbs.xjtudlc.com/coursebbs/login.aspx?username=09016101001004&usertype=0&from=202.117.16.41&key=b6254029f713ad58e18dac4f924fc739&cmd=main&parm=&studentcode=1069800109030205"
NSString *kDetailedViewControllerID = @"DetailView";    // view controller storyboard id
NSString *kCellID = @"cellID";                          // UICollectionViewCell storyboard id

@interface ViewController()
@property (nonatomic,strong) NSUserDefaults *userDefault;
@end
@implementation ViewController{
    NSUserDefaults *version;   //非学历版本货学历版本
    NSUserDefaults *userDefaults;  //用户登录帐号或密码
}
@synthesize getData=_getData;
@synthesize data=_data;
@synthesize indication = _indication;
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self loadCourses];
    _getData=[getJsonData sharedgetJsonData];
    version = [NSUserDefaults standardUserDefaults];
   // [self performSelectorOnMainThread:@selector(insertLoginMes) withObject:nil waitUntilDone:YES];
    self.data=[[NSMutableArray alloc]init];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSArray *courseArray=[userDefaults arrayForKey:@"courseList"];
    NSEnumerator *enumerator = [courseArray objectEnumerator];
    id anObject;
    NSLog(@"coursearray %@",courseArray);
    while (anObject = [enumerator nextObject]) {
        NSString *courseCode=anObject;
        NSLog(@"courseCode::%@",courseCode);
        NSArray *temp=[_getData getOne:@"Course" key:@"courseCode" value:courseCode];
        if ([temp firstObject]) {
            [self.data addObject:[temp firstObject]];
        }
        
    }
//      UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 30, 30)];
//      [button setValue:nil forKey:@"haha"];
//      [button addTarget:nil action:@selector(prepareWithInvocationTarget:) forControlEvents:NULL];
//      [button setTintColor: [UIColor yellowColor]];
//      [self.view addSubview:button];
//    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [self.data count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    Course *dataForCell=[self.data objectAtIndex:indexPath.row];
    // make the cell's title the actual NSIndexPath value
    cell.label.text = dataForCell.courseName;
    
    // load the image for this cell
  /*  NSString *imageToLoad = [NSString stringWithFormat:@"%d.JPG", indexPath.row];
    cell.image.image = [UIImage imageNamed:imageToLoad];*/
    
    return cell;
}

// the user tapped a collection item, load and set the image on the detail view controller
//
- (void)loaddata{
      [self.indication startAnimating];
}
- (void)enddata{
      [self.indication stopAnimating];
}
-(void)todoSomething:(id)sender{
      [self performSelectorInBackground:@selector(refreshdata) withObject:nil];
}
-(void)loadCourses{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    //MD5加密密码
    NSString *input_username = [userDefaults stringForKey:@"loginName"];
    NSString *password_MD5 = [userDefaults stringForKey:@"password"];
    NSLog(@"MD5结果:%@",password_MD5);
    NSLog(@"****************************************************************************");
    
    //httppost地址设置
    NSURL *url = [NSURL URLWithString:@"https://xueli.xjtudlc.com/MobileLearning/loginCheck.aspx"];
    
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
        [self insertCourses];
    }
}
-(void)insertCourses{
    //NSUserDefaults *userDefaults;  //用户登录帐号或密码
    //NSUserDefaults *version;
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
                NSString *courseCode = [myDetail valueForKey:@"CourseCode"];
                NSString *courseName = [myDetail valueForKey:@"CourseName"];
                NSString *courseID=[myDetail valueForKey:@""];
                [courseForLogin addObject:courseCode];
                //httppost地址设置区分学历版本和非学历版本
                NSString *url_str;
                if ([version boolForKey:@"feixueli"]) {
                    url_str=[[NSString alloc]initWithFormat:@"https://feixueli.xjtudlc.com/MobileLearning/Get_Coursetree.aspx?cno=%@",courseCode];
                    
                }else{
                    
                    url_str=[[NSString alloc]initWithFormat:@"https://xueli.xjtudlc.com/MobileLearning/Get_Coursetree.aspx?cno=%@",courseCode];
                    
                }
                
                NSURL *url = [NSURL URLWithString:url_str];
                NSLog(@"course meg url :%@",url_str);
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
                    //NSMutableDictionary *json=[NSJSONSerialization JSONObjectWithData:rec_3 options:NSJSONReadingMutableContainers error:NULL];
                    NSMutableDictionary * json = [NSJSONSerialization JSONObjectWithData:rec_3 options:NSJSONReadingMutableContainers error:NULL];
                    
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
                            // fileForCell *fileModel = [fileForCell mj_objectWithKeyValues:onefile];
                            [self.myGetData insertfile:file];
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
                            [self.myGetData insertCourseStructWithID:myID courseID:mycourseID structName:name];
                        }
                    }
                    
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
/*
        NSLog(@"courseCode%@",courseForLogin);
        NSString * learnProgressStr = [[NSString alloc]init];
        if ([version boolForKey:@"feixueli"]) {
            learnProgressStr = [NSString stringWithFormat:@"http://feixueli.xjtudlc.com/mobilelearning/LearningProgress.aspx?studentcode=%@",[userDefaults valueForKey:@"StudentCode"]];
            
        }else{
            
            learnProgressStr = [NSString stringWithFormat:@"http://xueli.xjtudlc.com/mobilelearning/LearningProgress.aspx?studentcode=%@",[userDefaults valueForKey:@"StudentCode"]];
            
            
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
                //                NSString * allGrade  = [oneCourse valueForKey:@"SUMCREDITHOUR"];
                //                NSString * getGrade = [oneCourse valueForKey:@"TOTALCREDITHOUR"];
                [userDefaults setObject:iTotalCreditHour forKey:@"TOTALCREDITHOUR"];
                [userDefaults setObject:iSumCreditHour forKey:@"SUMCREDITHOUR"];
                [userDefaults  setObject:iGraduatelowlimDays forKey:@"GRADUATELOWLIM"];
                [userDefaults setObject:iGraduatehighlimDays forKey:@"GRADUATEHIGHLIM"];
                [userDefaults setObject:iStudyDays forKey:@"STUDYDAYS"];
                
            }
        }
 */
        
        [userDefaults setObject:courseForLogin forKey:@"courseList"];
    }
}
-(void)alert_error{
            
            UIAlertView *alert_error= [[UIAlertView alloc] initWithTitle:@"新闻网络连接错误" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert_error show];
      }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
      {
            if([[segue identifier]isEqualToString:@"GoToCourse"]){
                  NSIndexPath *path=[self.collectionView indexPathForCell:sender];
                  
                  collectionTableViewController *myview=[segue destinationViewController];
                  Course *dataForCell=[self.data objectAtIndex:path.row];
                  myview.courseCode=dataForCell.courseCode;
                  myview.courseID=dataForCell.courseID;
                  myview.courseName=dataForCell.courseName;
                  myview.courseIDToSend=dataForCell.courseIDTOSend;
                  /*
                   ChooseViewController *myview=[segue destinationViewController];
                   Course *dataForCell=[self.data objectAtIndex:path.row];
                   myview.courseCode=dataForCell.courseCode;
                   myview.courseID=dataForCell.courseID;
                   myview.courseName=dataForCell.courseName;
                   myview.courseIDToSend=dataForCell.courseIDTOSend;
                   */
            }
      }
- (IBAction)CourseBBS:(id)sender {
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
    NSString *coursebbs_ = [NSString stringWithFormat:@"https://mbbs.xjtudlc.com/coursebbs/login.aspx?username=%@&usertype=0&from=202.117.16.41&key=%@&cmd=main&parm=&studentcode=%@",userName,KeyFormat,studentCode];
    NSString *basicAddress = coursebbs_;
    [self goToWebViewController:[NSString stringWithFormat:@"%@", basicAddress] title:title];
}

- (void)goToWebViewController:(NSString *)urlStr title:(NSString *)title{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSLog(@"request to %@", url);
    
    InfoWebViewController *webController = [[InfoWebViewController alloc] initWithURL:url Title:title];
    
    [self.navigationController pushViewController:webController animated:YES];
}
- (IBAction)refreCourse:(id)sender {
      [self performSelectorOnMainThread:@selector(loaddata) withObject:nil waitUntilDone:NO];
      [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:sender];
      [self performSelector:@selector(todoSomething:) withObject:sender afterDelay:1.0f];
}
      
@end

