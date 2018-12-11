//
//  OTDataService.m
//  MeosTrain
//
//  Created by fenguo on 13-5-31.
//  Copyright (c) 2013年 open. All rights reserved.
//

#import "OMDataService.h"
#import "OMDataUtil.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation OMDataService


+(void) sendAsyncHttpPostRequest:(NSString *)urlService withAction:(NSString *)action withActionName:(NSString *)actionName
               withParameterNote:(NSString *)parameterNote withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
//NSLog(@"url service=======%@》》》》》》》action====%@", urlService, action);
//NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%@", parameterNote);
    
    NSString *soapMessage = [self getSoapMessage:parameterNote withActionName:actionName];
    
//    NSLog(@"soap message =======%@", soapMessage);
    
    NSURL *url = [NSURL URLWithString:urlService];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    ASIHTTPRequest * theRequest = [ASIHTTPRequest requestWithURL:url];
    
    [theRequest addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
    NSString *soapAction = [NSString stringWithFormat:@"http://learningbar.open.com.cn/%@/%@", actionName, action];
//    NSLog(@"soap action =================");
//    NSLog(@"soap action =================%@", soapAction);
//    NSLog(@"soap message =================%@", soapMessage);
    [theRequest addRequestHeader:@"SOAPAction" value: soapAction];
    [theRequest addRequestHeader:@"Content-Length" value: msgLength];
    [theRequest setRequestMethod:@"POST"];
    [theRequest appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [theRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [theRequest setDelegate:httpDelegate];
    [theRequest startAsynchronous];
}


+(void) sendAsyncHttpPostRequest:(NSString *)urlService withAction:(NSString *)action withActionName:(NSString *)actionName
               withParameterNote:(NSString *)parameterNote withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
             withRequestUserInfo:(NSDictionary *)userInfo
{
    NSString *soapMessage = [self getSoapMessage:parameterNote withActionName:actionName];
    
    NSURL *url = [NSURL URLWithString:urlService];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    ASIHTTPRequest * theRequest = [ASIHTTPRequest requestWithURL:url];
   
    [theRequest addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
    theRequest.defaultResponseEncoding = NSUTF8StringEncoding;
    NSString *soapAction = [NSString stringWithFormat:@"http://learningbar.open.com.cn/%@/%@", actionName, action];
 
//NSLog(@"soap message =======url=%@", urlService);
//NSLog(@"soap message =================%@", soapMessage);
    
    [theRequest addRequestHeader:@"SOAPAction" value: soapAction];
    [theRequest addRequestHeader:@"Content-Length" value: msgLength];
    [theRequest setRequestMethod:@"POST"];
    [theRequest appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [theRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [theRequest setDelegate:httpDelegate];
    [theRequest setUserInfo:userInfo];
    [theRequest startAsynchronous];
}
+(void) sendAsyncHttpPostRequestss:(NSString *)urlService withAction:(NSString *)action withActionName:(NSString *)actionName
               withParameterNote:(NSString *)parameterNote withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
               withRequestUserInfo:(NSDictionary *)userInfo  withComBlock: ( void ( ^ )( NSString * ) )handler
                     withFailBlock: failBlock
{
    NSString *soapMessage = [self getSoapMessage:parameterNote withActionName:actionName];
    
    NSURL *url = [NSURL URLWithString:urlService];
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    //    ASIHTTPRequest * theRequest = [ASIHTTPRequest requestWithURL:url];
    __block ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:url];
    
    [theRequest addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
    theRequest.defaultResponseEncoding = NSUTF8StringEncoding;
    //NSString *soapAction = [NSString stringWithFormat:@"http://learningbar.open.com.cn/%@/%@", actionName, action];
    NSString *soapAction = [NSString stringWithFormat:@"http://tempuri.org/GetPublicCourseList"];
    //NSLog(@"soap message =======url=%@", urlService);
    //NSLog(@"soap message =================%@", soapMessage);
    
    [theRequest addRequestHeader:@"SOAPAction" value: soapAction];
    [theRequest addRequestHeader:@"Content-Length" value: msgLength];
    [theRequest setRequestMethod:@"POST"];
    [theRequest appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [theRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [theRequest setDelegate:httpDelegate];
    [theRequest setUserInfo:userInfo];
    [theRequest setCompletionBlock:^{
        NSString *responseString = [theRequest responseString];
        handler(responseString);
    }];
    
    [theRequest setFailedBlock:failBlock];
    [theRequest startAsynchronous];
    
    /*
    while (panduan) {
         [theRequest startSynchronous];
        panduan = NO;
    }
   
    NSError * error  = [theRequest error];
    if (!error) {
        NSString *responseString = [theRequest responseString];
        handler(responseString);
        
    }
*/
    
}


+(NSString *) getSoapMessage:(NSString *)parameterNote withActionName:(NSString *)actionName
{
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             // "<soap:Header>\n"
                             //"<CredentialSoapHeader xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                             //"<ClientCredential>%@</ClientCredential>\n"
                             //"<TerminalType>%@</TerminalType>\n"
                             //"<Model>%@</Model>\n"
                             //"<SystemVersion>%@</SystemVersion>\n"
                             //"<ApplicationVersion>%@</ApplicationVersion>\n"
                             //"<DeviceID>%@</DeviceID>\n"
                             //"<PhoneScreenSize>%@</PhoneScreenSize>\n"
                             //"<PhoneNumber>%@</PhoneNumber>\n"
                             //"</CredentialSoapHeader>\n"
                             //"</soap:Header>\n"
                             "<soap:Body>\n"
                             "%@\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>" ,
                             //actionName, @"000000000", @"000000000", @"000000000", @"000000000", @"000000000", @"000000000", @"000000000", @"000000000",
                             parameterNote];
    
    return soapMessage;
}

// 用户注册
+(void)registerUser:(NSDictionary*) userinfo withUserName:(NSString *)userName withPassword:(NSString *)password withDelegate:(ASIHTTPRequestDelegate *)httpDelegate{
    NSString *urlService = [OMDataUtil getUrlForKey:USER_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:USER_REGISTER];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<username>%@</username>\n"
                                     "<pass>%@</pass>\n"
                                     "</%@>", action, actionName, userName, password, action];
    
//    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
//                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];


}


//用户登录
+ (void)loginUserName: (NSString *)userName withPassword: (NSString *) password withDelegate: (ASIHTTPRequestDelegate *) httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:USER_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:USER_LOGIN];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<username>%@</username>\n"
                                     "<password>%@</password>\n"
                                     "</%@>", action, actionName, userName, password, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}



//用户登录
+(void)loginUserWithBlock:(NSString *)userName withPassword:(NSString *)password withComBlock:(void (^)(NSString *))handler withFailBlock:(id)failBlock{
    
    
    NSString *urlService = [OMDataUtil getUrlForKey:USER_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:USER_LOGIN];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<username>%@</username>\n"
                                     "<password>%@</password>\n"
                                     "</%@>", action, actionName, userName, password, action];
    
    [OMDataService sendAsyncHttpPostRequestss:urlService withAction:action withActionName:actionName withParameterNote:parameterNoteString withDelegate:nil withRequestUserInfo:nil withComBlock:handler withFailBlock:failBlock];
   
}






+(void)getOpenCourseVideoList:(NSString *)category withPageNumber:(NSString *)pageNumber withPageSize:(NSString *)pageSize withDelegate:(ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo{
   
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_OPEN_COURSE_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<categoryCode>%@</categoryCode>\n"
                                     "<pageIndex>%@</pageIndex>\n"
                                     "<pageSize>%@</pageSize>\n"
                                     "</%@>", action, actionName,category,pageNumber, pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];

}



+(void)getOpenCourseVideoListWithBlock:(NSString *)category withPageNumber:(NSString *)pageNumber withPageSize:(NSString *)pageSize withDelegate:(ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo  withComBlock: ( void ( ^ )( NSString * ) )handler
                         withFailBlock: failBlock {
    
    //    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    //    NSString *action = [OMDataUtil getUrlForKey:GET_OPEN_COURSE_LIST];
    //    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    //NSString *urlService =@"http://xueba.open.com.cn/services/CourseService.asmx?";
    NSString * urlService = @"http://publiccourselist.xjtudlc.com/";
    NSString *action =@"GetPublicCourseList";
    NSString *actionName =@"CourseService";
    /*
     NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
     "<categoryCode>%@</categoryCode>\n"
     "<pageIndex>%@</pageIndex>\n"
     "<pageSize>%@</pageSize>\n"
     "</%@>", action, actionName,category,pageNumber, pageSize, action];
     */
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://tempuri.org/\"/>", action];
    
    //    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
    //                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
    
    [OMDataService sendAsyncHttpPostRequestss:urlService withAction:action withActionName:actionName withParameterNote:parameterNoteString withDelegate:httpDelegate withRequestUserInfo:userinfo withComBlock:handler withFailBlock:failBlock];
    
}


/*

//我的课程
+(void) getMyCourseListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode
                 withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
                   withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
                    withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo
{
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<orderByType>%@</orderByType>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userID, studentCode, orderByType, orderType, pageIndex, pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];
}




//获取课程的评测列表
+(void) getCourseExamTaskListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode
                          withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType
                         withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex
                          withPageSize:(NSString *)pageSize
                          withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo
{
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_EXAMTASK_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<orderByType>%@</orderByType>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, orderByType, orderType, pageIndex, pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];
}


// 获取文档列表
+(void)getCourseDocPDFListForUserIDBlock:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withComBlock:(void (^)(NSString *))handler withFailBlock:(id)failBlock{
    
    
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_PDF_DOC_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<orderByType>%@</orderByType>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, orderByType, orderType, pageIndex, pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequestss:urlService withAction:action withActionName:actionName withParameterNote:parameterNoteString withDelegate:nil withRequestUserInfo:nil withComBlock:handler withFailBlock:failBlock];
}

// 获取评测列表
+(void)getCourseExamTaskListForUserIDBlock:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withComBlock:(void (^)(NSString *))handler withFailBlock:(id)failBlock{
    
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_EXAMTASK_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];

    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<orderByType>%@</orderByType>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, orderByType, orderType, pageIndex, pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequestss:urlService withAction:action withActionName:actionName withParameterNote:parameterNoteString withDelegate:nil withRequestUserInfo:nil withComBlock:handler withFailBlock:failBlock];
}

// 获取公告列表
+(void)getCourseNoticePDFListForUserIDBlock:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withComBlock:(void (^)(NSString *))handler withFailBlock:(id)failBlock{
    
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_NOTICE_PDF_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<orderByType>%@</orderByType>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, orderByType, orderType, pageIndex, pageSize, action];
    
 [OMDataService sendAsyncHttpPostRequestss:urlService withAction:action withActionName:actionName withParameterNote:parameterNoteString withDelegate:nil withRequestUserInfo:nil withComBlock:handler withFailBlock:failBlock];

}

// 获取视频列表
+(void)getCourseVideoListForUserIDBlock:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withComBlock:(void (^)(NSString *))handler withFailBlock:(id)failBlock{
    
    
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_VIDEO_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<orderByType>%@</orderByType>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, orderByType, orderType, pageIndex, pageSize, action];
//    
//    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
//                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];
    
    [OMDataService sendAsyncHttpPostRequestss:urlService withAction:action withActionName:actionName withParameterNote:parameterNoteString withDelegate:nil withRequestUserInfo:nil withComBlock:handler withFailBlock:failBlock];

    
}
//用户的课程的视频
+(void) getCourseVideoListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode
                       withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType
                      withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex
                       withPageSize:(NSString *)pageSize
                       withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo
{
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_VIDEO_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<orderByType>%@</orderByType>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, orderByType, orderType, pageIndex, pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];
}

//获取 PDF 文档
+(void) getCourseDocPDFListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode
                        withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType
                       withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex
                        withPageSize:(NSString *)pageSize
                        withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo
{
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_PDF_DOC_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<orderByType>%@</orderByType>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, orderByType, orderType, pageIndex, pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];
}

//用户的课程的 PDF 公告
+(void) getCourseNoticePDFListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode
                           withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType
                          withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex
                           withPageSize:(NSString *)pageSize
                           withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo
{
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_NOTICE_PDF_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<orderByType>%@</orderByType>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, orderByType, orderType, pageIndex, pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];
}

//获取单个评测评测作业
+(void) GetCourseExamTaskForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withExamTaskID:(NSString *)examTaskID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo
{
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_EXAMTASK];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<examItemID>%@</examItemID>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, examTaskID, action];
    
//    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
//                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];
}

//更新课件状态（是否已为New）
+(void) setCoursewareStudyStatusForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withCoursewareID:(NSString *)coursewareID withCoursewareType:(NSString *)coursewareType withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:UPDATE_COURSE_WARE_STUDY_STATUS];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<coursewareID>%@</coursewareID>\n"
                                     "<coursewareType>%@</coursewareType>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, coursewareID, coursewareType, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//保存视频文档学习位置（断点续学保留接口）
+(void) setCoursewareStudyPointForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withCoursewareID:(NSString *)coursewareID withCoursewareType:(NSString *)coursewareType withCoursePoint:(NSString *)coursePoint withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:UPDATE_COURSE_WARE_STUDY_POINT];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<coursewareID>%@</coursewareID>\n"
                                     "<coursewareType>%@</coursewareType>\n"
                                     "<coursePoint>%@</coursePoint>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, coursewareID, coursewareType, coursePoint, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//获取评测试题内容
+(void) getCourseExamTaskItemForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withExamItemID:(NSString *)examItemID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo
{
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_EXAMTASK_ITEM];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<examItemID>%@</examItemID>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, examItemID, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];
}

//保存(未完成试题)   保存(未完成试题)saveUnFinishExamTaskResult
+(void) saveUnFinishExamTaskResultForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withExamTaskID:(NSString *)examTaskID withAnswerData:(NSString *)AnswerData withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo
{
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:SAVE_UNFINISH_EXAMTASK_RESULT];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<examTaskID>%@</examTaskID>\n"
                                     "<AnswerData>%@</AnswerData>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, examTaskID, AnswerData, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];
}

//交卷(完成试题)
+(void) submitObjectiveExamResultForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withExamTaskID:(NSString *)examTaskID withAnswerData:(NSString *)AnswerData withObjectiveScore:(NSString *)objectiveScore withState:(NSString *)state withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo
{
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:SUBMIT_EXAM_RESULT];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<examTaskID>%@</examTaskID>\n"
                                     "<AnswerData>%@</AnswerData>\n"
                                     "<objectiveScore>%@</objectiveScore>\n"
                                     "<state>%@</state>\n"
                                     "</%@>", action, actionName, userID, studentCode, courseID, examTaskID, AnswerData, objectiveScore, state, action];
    
//    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
//                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
//    
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];
}



//用户反馈  AddUserFeedback
+(void) addUserFeedbackForUserID:(NSString *)userID withFeedbackContent:(NSString *)feedbackContent
                   withUserEmail:(NSString *)userEmail
                    withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo
{
    NSString *urlService = [OMDataUtil getUrlForKey:USER_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:USER_FEEDBACK];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<feedbackContent>%@</feedbackContent>\n"
                                     "<userEmail>%@</userEmail>\n"
                                     "</%@>", action, actionName, userID, feedbackContent, userEmail, action];
//    NSLog(@"-------------------action====%@", action);
//    NSLog(@"-------------------urlService====%@", urlService);
//    NSLog(@"-------------------parameterNoteString====%@", parameterNoteString);
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userinfo];
}


// 主题列表
+(void) getThemeList:(NSString *)userBaseID withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_GET_THEME_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userBaseID>%@</userBaseID>\n"
                                     "<orderByField>%@</orderByField>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userBaseID, orderByType, orderType, pageIndex, pageSize, action];
//    NSLog(@"-------------------action====%@", action);
//    NSLog(@"-------------------urlService====%@", urlService);
//    NSLog(@"-------------------parameterNoteString====%@", parameterNoteString);
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}


// 我关注的 主题列表
+(void) getThemeListByUserID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_GET_THEME_LIST_BYUSERID];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userBaseID>%@</userBaseID>\n"
                                     "</%@>", action, actionName, userBaseID, action];
    //    NSLog(@"-------------------action====%@", action);
    //    NSLog(@"-------------------urlService====%@", urlService);
    //    NSLog(@"-------------------parameterNoteString====%@", parameterNoteString);
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}




//添加对主题的关注
+(void) addAttentionOfThemeByuserBaseID:(NSString *)userBaseID withThemeID:(NSString*)themeID
                           withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_ADD_ATTENTION_OF_THEME];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userBaseID>%@</userBaseID>\n"
                                     "<themeID>%@</themeID>\n"
                                     "</%@>", action, actionName, userBaseID, themeID, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userInfo];
}

//取消对主题的关注
+(void) cancleAttentionOfThemeByuserBaseID:(NSString *)userBaseID withThemeID:(NSString*)themeID
                          withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_CANCEL_ATTENTION_OF_THEME];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userBaseID>%@</userBaseID>\n"
                                     "<themeID>%@</themeID>\n"
                                     "</%@>", action, actionName, userBaseID, themeID, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userInfo];
}

//主题详情
+(void)getThemeDetailByThemeID:(NSString *)themeID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_GET_THEME_DETAIL_BY_THEMEID];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<themeID>%@</themeID>\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "</%@>", action, actionName, themeID,userID, studentCode, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//主题的发言列表
+(void)getSpeakListByThemeID:(NSString *)themeID withOrderByField:(NSString *)orderByField withOrderType:(NSString *)orederType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_GET_GET_SPEAK_LIST_BY_THEMEID];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<themeID>%@</themeID>\n"
                                     "<orderByField>%@</orderByField>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action,actionName,themeID,orderByField, orederType,pageIndex, pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//参与发言
+(void)addSpeakContentByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withThemeID:(NSString *)themeID withSpeakContent:(NSString *)speakContent withOriginalSpeakID:(NSString *)originalSpeakID withIsTranspond:(NSString *)isTranspond withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_ADD_SPEAK_CONTENT];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "<ThemeID>%@</ThemeID>\n"
                                     "<SpeakContent>%@</SpeakContent>\n"
                                     "<OriginalSpeakID>%@</OriginalSpeakID>\n"
                                     "<IsTranspond>%@</IsTranspond>\n"
                                     "</%@>", action,actionName,userID,studentCode, themeID,speakContent, originalSpeakID,isTranspond, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//发言条目详情
+(void)getSpeakDetailBySpeakID:(NSString *)speakID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_GET_SPEAK_DETAIL_BY_SPEAKID];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<SpeakID>%@</SpeakID>\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "</%@>", action,actionName,speakID,userID, studentCode, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//发言条目评价列表
+(void)getReviewListBySpeakID:(NSString *)speakID withOrderByField:(NSString *)orderByField withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_GET_REVIEWLIST_BY_SPEAKID];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<SpeakID>%@</SpeakID>\n"
                                     "<orderByField>%@</orderByField>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action,actionName,speakID,orderByField,orderType, pageIndex,pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//删除发言
+(void)deleteSpeakBySpeakID:(NSString *)speakID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{

    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_DELETE_SPEAK_BY_SPEAKID];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "<SpeakID>%@</SpeakID>\n"
                                     "</%@>", action,actionName,userID,studentCode,speakID, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//赞发言
+(void)addSupportSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_ADD_SUPPORT_SPEAK];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "<SpeakID>%@</SpeakID>\n"
                                     "</%@>", action,actionName,userID,studentCode,speakID, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//收藏发言
+(void)addFavoriteSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_ADD_FAVORITE_SPEAK];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "<SpeakID>%@</SpeakID>\n"
                                     "</%@>", action,actionName,userID,studentCode,speakID, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//删除收藏发言
+(void)deleteFavoriteSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_DELETE_FAVORITE_SPEAK];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "<SpeakID>%@</SpeakID>\n"
                                     "</%@>", action,actionName,userID,studentCode,speakID, action];
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//添加发言评论
+(void)addReviewOfSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withReviewContent:(NSString *)reviewContent withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_ADD_REVIEW_OF_SPEAK];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "<SpeakID>%@</SpeakID>\n"
                                     "<ReviewContent>%@</ReviewContent>\n"
                                     "</%@>", action,actionName,userID,studentCode,speakID,reviewContent, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//回复评论
+(void)addRevertOfReviewByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withReviewID:(NSString *)reviewID withRevertContent:(NSString *)revertContent withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_ADD_REVERT_OF_REVIEW];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "<ReviewID>%@</ReviewID>\n"
                                     "<RevertContent>%@</RevertContent>\n"
                                     "</%@>", action,actionName,userID,studentCode,reviewID,revertContent, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//发布个人主页（教师主页）
+(void)getThemeAuthorDetailByThemeAuthorID:(NSString *)themeAuthorID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_GET_THEME_AUTHORDETAIL_BY_THEMEAUTHORID];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<ThemeAuthorID>%@</ThemeAuthorID>\n"
                                     "<userBaseID>%@</userBaseID>\n"
                                     "</%@>", action,actionName,themeAuthorID,userID, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//发布人的主题
+(void)getThemeListByAuthorID:(NSString *)themeAuthorID withuserBaseID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_GET_THEMELIST_BY_AUTHORID];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userBaseID>%@</userBaseID>\n"
                                     "<ThemeAuthorID>%@</ThemeAuthorID>\n"
                                     "</%@>", action,actionName,userBaseID,themeAuthorID, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//我的发言
+(void)getSpeakListByUserID:(NSString *)UserID withStudentCode:(NSString *)studentCode withOrderByField:(NSString *)orderByField withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_GET_SPEAKLIST_BY_USERID];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "<orderByField>%@</orderByField>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action,actionName,UserID,studentCode,orderByField,orderType,pageIndex,pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//用户禁言信息
+(void)getUserNoSpeakInfoByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_GET_USER_NOSPEAKINFO_BY_USERID];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "</%@>", action,actionName,userID,studentCode, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//编辑发言
+(void)editSpeakContentByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withThemeID:(NSString *)themeID withSpeakContent:(NSString *)speakContent withOriginalSpeakID:(NSString *)originalSpeakID withIsTranspond:(NSString *)isTranspond withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_EDIT_SPEAK_CONTENT];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "<SpeakID>%@</SpeakID>\n"
                                     "<ThemeID>%@</ThemeID>\n"
                                     "<SpeakContent>%@</SpeakContent>\n"
                                     "<OriginalSpeakID>%@</OriginalSpeakID>\n"
                                     "<IsTranspond>%@</IsTranspond>\n"
                                     "</%@>", action,actionName,userID,studentCode,speakID,themeID,speakContent,originalSpeakID,isTranspond, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//编辑发言评论
+(void)editReviewOfSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withReviewID:(NSString *)reviewID withReviewContent:(NSString *)reviewContent withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_EDIT_REVIEW_OF_SPEAK];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<StudentCode>%@</StudentCode>\n"
                                     "<SpeakID>%@</SpeakID>\n"
                                     "<ReviewID>%@</ReviewID>\n"
                                     "<ReviewContent>%@</ReviewContent>\n"
                                     "</%@>", action,actionName,userID,studentCode,speakID,reviewID,reviewContent, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}



//获取教务公告列表
+(void)getEducationNoticeListByUserID:(NSString *)userID
                      withStudentCode:(NSString *)studentCode
                      withOrderByType:(NSString *)orderByType
                        withOrderType:(NSString *)orderType
                        withPageIndex:(NSString *)pageIndex
                         withPageSize:(NSString *)pageSize
                         withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:PERSONAL_HOMEPAGE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_EDUCATION_NOTICE_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_PERSONAL_HOMEPAGE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<orderByType>%@</orderByType>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userID, studentCode, orderByType, orderType, pageIndex, pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//获取教务公告详情
+(void)getEducationNoticeDetailByUserID:(NSString *)userID
                      withStudentCode:(NSString *)studentCode
                withEducationNoticeID:(NSString *)educationNoticeID
                         withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *urlService = [OMDataUtil getUrlForKey:PERSONAL_HOMEPAGE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_EDUCATION_NOTICE_DETAIL];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_PERSONAL_HOMEPAGE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<EducationNoticeID>%@</EducationNoticeID>\n"
                                     "</%@>", action, actionName, userID, studentCode, educationNoticeID, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}



//OES 积分 在线时长积分规则
+(void)addOBUserCourseTotalTimeWithUserID:(NSString *)userID
                   withCourseID:(NSString *)CourseID
                  withTotalTime:(NSString *)TotalTime
                   withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSLog(@"-------------addOBUserCourseTotalTimeWithUserID");
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = NSLocalizedString(@"url_add_user_total_time_action", nil);
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<totalTime>%@</totalTime>\n"
                                     "</%@>", action, actionName, userID, CourseID, TotalTime, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}

//OES 积分 课件点击积分规则
+(void)addOBUserCourseClickTimeWithUserID:(NSString *)userID
                withStudentCode:(NSString *)studentCode
                   withCourseID:(NSString *)CourseID
               withCourseWareID:(NSString *)CourseWareID
                   withLoadDate:(NSString *)loadDate
                 withUnloadDate:(NSString *)unloadDate
                   withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
     NSLog(@"-------------addOBUserCourseClickTimeWithUserID");
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = NSLocalizedString(@"url_add_user_course_click_time_action", nil);;
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<coursewareid>%@</coursewareid>\n"
                                     "<loadDate>%@</loadDate>\n"
                                     "<unloadDate>%@</unloadDate>\n"
                                     "</%@>", action, actionName, userID, studentCode, CourseID, CourseWareID, loadDate, unloadDate, action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
}





//OES 积分 课件点击积分规则
+(void)addOBUserCourseClickTimeWithUserIDWithBlock:(NSString *)userID
                          withStudentCode:(NSString *)studentCode
                             withCourseID:(NSString *)CourseID
                         withCourseWareID:(NSString *)CourseWareID
                             withLoadDate:(NSString *)loadDate
                           withUnloadDate:(NSString *)unloadDate
                           withComBlock: ( void ( ^ )( NSString * ) )handler
                            withFailBlock: failBlock
{
    
    NSLog(@"addOBUserCourseClickTimeWithUserIDWithBlock:%@-------%@",loadDate,unloadDate);

    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = NSLocalizedString(@"url_add_user_course_click_time_action", nil);;
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<courseID>%@</courseID>\n"
                                     "<coursewareid>%@</coursewareid>\n"
                                     "<loadDate>%@</loadDate>\n"
                                     "<unloadDate>%@</unloadDate>\n"
                                     "</%@>", action, actionName, userID, studentCode, CourseID, CourseWareID, loadDate, unloadDate, action];
    
//    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
//                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
    
     [OMDataService sendAsyncHttpPostRequestss:urlService withAction:action withActionName:actionName withParameterNote:parameterNoteString withDelegate:nil withRequestUserInfo:nil withComBlock:handler withFailBlock:failBlock];
}




//同专业的好友列表
+(void)getFriendListBySameSpecialty:(NSString *)UserID withstudentCode:(NSString *)studentCode withuserType:(NSString *)userType withorderByField:(NSString *)orderByField withorderType:(NSString *)orderType withpageIndex:(NSString *)pageIndex withpageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
                withRequestUserinfo:(NSDictionary *)userInfo  withComBlock: ( void ( ^ )( NSString * ) )handler
                      withFailBlock: failBlock;
{
    
    NSString *urlService = [OMDataUtil getUrlForKey:PERSONAL_HOMEPAGE_SERVICE];
    NSString *action = NSLocalizedString(@"learningbar_sdk_method_getFriendListBySameSpecicalty", nil);;
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_PERSONAL_HOMEPAGE_NAME];
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<userType>%@</userType>\n"
                                     "<orderByField>%@</orderByField>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<pageIndex>%@</pageIndex>\n"
                                     "<pageSize>%@</pageSize>\n"
                                     "<token>%@</token>\n"
                                     "</%@>", action, actionName, UserID, studentCode, userType,
                                     orderByField, orderType, pageIndex,pageSize, ([[[UIApplication sharedApplication] delegate]).userInfo.tokenOfOBS, action];
//    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
//                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
    [OMDataService sendAsyncHttpPostRequestss:urlService withAction:action withActionName:actionName withParameterNote:parameterNoteString withDelegate:httpDelegate withRequestUserInfo:userInfo withComBlock:handler withFailBlock:failBlock];
    
//    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrl withData:paraDict withComBlock:handler withFailBlock:failBlock];
    
    
}

//我的课程
+(void) getMyCourseListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode
                 withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
                   withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
                    withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo withComBlock: ( void ( ^ )( NSString * ) )handler
                   withFailBlock: failBlock
{

    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_COURSE_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<orderByType>%@</orderByType>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, userID, studentCode, orderByType, orderType, pageIndex, pageSize, action];
    
    [OMDataService sendAsyncHttpPostRequestss:urlService withAction:action withActionName:actionName withParameterNote:parameterNoteString withDelegate:httpDelegate withRequestUserInfo:userinfo withComBlock:handler withFailBlock:failBlock];
    
}

// 获取主题分类的列表
+(void)getThemeCategoryList:(NSString *)userID withType:(NSString *)userType  withToken:(NSString*) token  withDelegate:(ASIHTTPRequestDelegate *)httpDelegate{
    
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:DISCUSS_GET_THEME_CATEGORY];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<userID>%@</userID>\n"
                                     "<type>%@</type>\n"
                                     "<token>%@</token>\n"
                                     "</%@>", action, actionName, userID, userType,token,action];
    
    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                              withParameterNote:parameterNoteString withDelegate: httpDelegate];
    
    
}*/

@end
