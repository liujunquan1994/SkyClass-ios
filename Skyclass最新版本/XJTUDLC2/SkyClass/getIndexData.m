//
//  getIndexData.m
//  skyclass
//
//  Created by skyclass on 15/6/3.
//
//

#import "getIndexData.h"
#import "ASIHTTPRequest.h"

@implementation getIndexData
/*
+(void) sendAsyncHttpPostRequestss:(NSString *)urlService withAction:(NSString *)action withActionName:(NSString *)actionName
                 withParameterNote:(NSString *)parameterNote withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
               withRequestUserInfo:(NSDictionary *)userInfo  withComBlock: ( void ( ^ )( NSString * ) )handler
                     withFailBlock: failBlock
{
    NSString *soapMessage = [self getSoapMessage:parameterNote withActionName:actionName];
    
    NSURL *url = [NSURL URLWithString:urlService];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
     //  ASIHTTPRequest * theRequest = [ASIHTTPRequest requestWithURL:url];
    __block ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:url];
    
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
    //    [theRequest setDelegate:httpDelegate];
    //    [theRequest setUserInfo:userInfo];
    [theRequest setCompletionBlock:^{
        NSString *responseString = [theRequest responseString];
        handler(responseString);
    }];
    
    [theRequest setFailedBlock:failBlock];
    [theRequest startAsynchronous];
}



+(NSString *) getSoapMessage:(NSString *)parameterNote withActionName:(NSString *)actionName
{
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<CredentialSoapHeader xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                             "<ClientCredential>%@</ClientCredential>\n"
                             "<TerminalType>%@</TerminalType>\n"
                             "<Model>%@</Model>\n"
                             "<SystemVersion>%@</SystemVersion>\n"
                             "<ApplicationVersion>%@</ApplicationVersion>\n"
                             "<DeviceID>%@</DeviceID>\n"
                             "<PhoneScreenSize>%@</PhoneScreenSize>\n"
                             "<PhoneNumber>%@</PhoneNumber>\n"
                             "</CredentialSoapHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "%@\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>" ,
                             actionName, @"000000000", @"000000000", @"000000000", @"000000000", @"000000000", @"000000000", @"000000000", @"000000000",
                             parameterNote];
    
    return soapMessage;
}




+(void)getOpenCourseVideoList:(NSString *)category withPageNumber:(NSString *)pageNumber withPageSize:(NSString *)pageSize withDelegate:(ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo{
    
    //NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *urlService =@"http://115.182.41.79/Services/CourseService.asmx";
    //NSString *action = [OMDataUtil getUrlForKey:GET_OPEN_COURSE_LIST];
    NSString *action = @"GetPublicCourseList";
   // NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    NSString *actionName = @"CourseService"	;
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<categoryCode>%@</categoryCode>\n"
                                     "<pageIndex>%@</pageIndex>\n"
                                     "<pageSize>%@</pageSize>\n"
                                     "</%@>", action, actionName,category,pageNumber, pageSize, action];
    
    [self sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
    
}



+(void)getOpenCourseVideoListWithBlock:(NSString *)category withPageNumber:(NSString *)pageNumber withPageSize:(NSString *)pageSize withDelegate:(ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo  withComBlock: ( void ( ^ )( NSString * ) )handler
                         withFailBlock: failBlock {
    
    NSString *urlService = [OMDataUtil getUrlForKey:COURSE_SERVICE];
    NSString *action = [OMDataUtil getUrlForKey:GET_OPEN_COURSE_LIST];
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_COURSE_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<categoryCode>%@</categoryCode>\n"
                                     "<pageIndex>%@</pageIndex>\n"
                                     "<pageSize>%@</pageSize>\n"
                                     "</%@>", action, actionName,category,pageNumber, pageSize, action];
    
    //    [OMDataService sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
    //                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
    
    [OMDataService sendAsyncHttpPostRequestss:urlService withAction:action withActionName:actionName withParameterNote:parameterNoteString withDelegate:httpDelegate withRequestUserInfo:userinfo withComBlock:handler withFailBlock:failBlock];
 
}
 */


@end
