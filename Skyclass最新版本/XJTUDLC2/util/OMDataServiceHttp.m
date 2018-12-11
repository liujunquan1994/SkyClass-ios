//
//  OMDataServiceHttp.m
//  LearningBar
//
//  Created by fenguo on 13-10-25.
//  Copyright (c) 2013年 open. All rights reserved.
//

#import "OMDataServiceHttp.h"
#import "OMDataService.h"
#import "OMDataUtil.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "LBAppDelegate.h"


@implementation OMDataServiceHttp

#pragma mark meself methord
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
               withParameterNote:(NSString *)parameterNote withComBlock: ( void ( ^ )( NSString * ) )handler
                   withFailBlock: failBlock{
    //NSLog(@"url service=======%@》》》》》》》action====%@", urlService, action);
    //NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%@", parameterNote);
    
    NSString *soapMessage = [self getSoapMessage:parameterNote withActionName:actionName];
    
    //    NSLog(@"soap message =======%@", soapMessage);
    
    NSURL *url = [NSURL URLWithString:urlService];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    __block ASIHTTPRequest * theRequest = [ASIHTTPRequest requestWithURL:url];
    
    [theRequest addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
    
    NSString *soapAction = [NSString stringWithFormat:@"http://learningbar.open.com.cn/%@/%@", actionName, action];
    //    NSLog(@"soap action =================");
    //    NSLog(@"soap action =================%@", soapAction);
    //    NSLog(@"soap message =================%@", soapMessage);
    [theRequest addRequestHeader:@"SOAPAction" value: soapAction];
    [theRequest addRequestHeader:@"Content-Length" value: msgLength];
    [theRequest setRequestMethod:@"POST"];
    [theRequest setCompletionBlock:^{
        NSString *responseString = [theRequest responseString];
        handler(responseString);
    }];
    [theRequest setFailedBlock:failBlock];
    [theRequest appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [theRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [theRequest startAsynchronous];
}

//get request
+ (void) sendAsyncHttpRequest: (NSString *) urlStr withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
//NSLog(@"request http url>>>>>>>>>>>>>>>>>>>>>>%@",urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:url];
    [req setDelegate:httpDelegate];
    
    [req addRequestHeader:@"token" value:GETUSER_INFO.tokenOfOBS];
    [req startSynchronous];
}

//get request with request userInfo
+ (void) sendAsyncHttpRequest: (NSString *) urlStr withDelegate: (ASIHTTPRequestDelegate *)httpDelegate  withRequestUserInfo:(NSDictionary *)userInfo
{
//NSLog(@"request http url userInfo>>>>>>>>>>>>>>>>>>>>>>>%@",urlStr);
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:url];
    [req addRequestHeader:@"token" value:GETUSER_INFO.tokenOfOBS];
    [req setDelegate:httpDelegate];
    [req setUserInfo:userInfo];
    [req startSynchronous];
}

//post request
+ (void) sendAsyncHttpPostRequest:(NSString *)urlStr withData: (NSDictionary *)dataDict withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
//NSLog(@"request http post url>>>>>>>>>%@",urlStr);
//NSLog(@"request http post url>>>>>>>>>>参数是>>>>>>>>>%@", dataDict);

    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:url];
    [req addRequestHeader:@"token" value:GETUSER_INFO.tokenOfOBS];
    [req addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
    [req setRequestMethod:@"POST"];
    
    NSArray *keys = dataDict.allKeys;
    for (id key in keys){
        [req setPostValue:[dataDict objectForKey:key] forKey:key];
    }
    
    [req setDelegate:httpDelegate];
    [req addRequestHeader:@"ClientType" value:@"1"];
    [req startAsynchronous];
}


//post request data
+ (void) sendAsyncHttpPostRequest:(NSString *)urlStr withStringData: (NSString *)stringData withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    //NSLog(@"request http post url>>>>>>>>>%@",urlStr);
    //NSLog(@"request http post url>>>>>>>>>>参数是>>>>>>>>>%@", dataDict);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:url];
    [req addRequestHeader:@"token" value:GETUSER_INFO.tokenOfOBS];
    [req addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
    [req setRequestMethod:@"POST"];
    [req appendPostData:[stringData dataUsingEncoding:NSUTF8StringEncoding]];
    [req setDelegate:httpDelegate];
    [req addRequestHeader:@"ClientType" value:@"1"];
    [req startAsynchronous];
}




//post request with request userInfo
+(void) sendAsyncHttpPostRequest:(NSString *)urlStr withData: (NSDictionary *)dataDict
                    withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserInfo:(NSDictionary *)userInfo
{
//NSLog(@"request http post <<set request userinfo>> url>>>>>>>>>%@",urlStr);
//NSLog(@"request http post << post data >>>>>>>>>%@", dataDict);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:url];
    [req addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
    if(GETUSER_INFO.tokenOfOBS !=nil){
       [req addRequestHeader:@"token" value:GETUSER_INFO.tokenOfOBS];
    }
    [req setRequestMethod:@"POST"];
    
    NSArray *keys = dataDict.allKeys;
    for (id key in keys){
        [req setPostValue:[dataDict objectForKey:key] forKey:key];
    }
    
    [req setDelegate:httpDelegate];
    [req addRequestHeader:@"ClientType" value:@"1"];
    [req setUserInfo:userInfo];
    [req startAsynchronous];
}


//post request with request userInfo with block
+(void) sendAsyncHttpPostRequestWithBlock:(NSString *)urlStr
                                 withData: (NSDictionary *)dataDict
                             withComBlock: ( void ( ^ )( NSString * ) )handler
                            withFailBlock: failBlock
{
//    NSLog(@"request http post >>block<<set request userinfo>> url>>>>>>>>>%@",urlStr);
//    NSLog(@"request http post >>block<< post data >>>>>>>>>%@", dataDict);
//    NSLog(@"request http post >>block<< token >>>>>>>>>%@", GETUSER_INFO.tokenOfOBS);
    
    __block ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSArray *keys = dataDict.allKeys;
    for (id key in keys){
        [req setPostValue:[dataDict objectForKey:key] forKey:key];
    }
    
    [req addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
    [req addRequestHeader:@"token" value:GETUSER_INFO.tokenOfOBS];
    [req addRequestHeader:@"ClientType" value:@"1"];
    [req setRequestMethod:@"POST"];
    
    [req setCompletionBlock:^{
        NSString *responseString = [req responseString];
        handler(responseString);
    }];
    
    [req setFailedBlock:failBlock];
    [req startAsynchronous];
}


+(void) sendAsyncHttpPostRequestWithBlock:(NSString *)urlStr
                                 withPostData: (NSString *)postData
                             withComBlock: ( void ( ^ )( NSString * ) )handler
                            withFailBlock: failBlock
{
    //    NSLog(@"request http post >>block<<set request userinfo>> url>>>>>>>>>%@",urlStr);
    //    NSLog(@"request http post >>block<< post data >>>>>>>>>%@", dataDict);
    //    NSLog(@"request http post >>block<< token >>>>>>>>>%@", GETUSER_INFO.tokenOfOBS);
    
    __block ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    [req addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
    if (GETUSER_INFO.tokenOfOBS.length>0) {
        [req addRequestHeader:@"token" value:GETUSER_INFO.tokenOfOBS];
    }
    
    [req addRequestHeader:@"ClientType" value:@"1"];
    [req setRequestMethod:@"POST"];
    
    [req appendPostData:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [req setCompletionBlock:^{
        NSString *responseString = [req responseString];
        handler(responseString);
    }];
    
    [req setFailedBlock:failBlock];
    [req startAsynchronous];
}






//上传一个文件
+ (void) sendAsyncHttpPostFileRequest:(NSString *)urlStr withData: (NSDictionary *)dataDict
                         withFilePath:(NSString *)filePath withFileName:(NSString *)fileName withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
//NSLog(@"request http post file url>>>>>>>>>%@",urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:url];

    NSArray *keys = dataDict.allKeys;
    for (id key in keys){
        [req setPostValue:[dataDict objectForKey:key] forKey:key];
    }
    
    [req setFile:filePath forKey:fileName];
    
    [req setDelegate:httpDelegate];
    [req startAsynchronous];
}


//同时上传多个文件
+ (void) sendAsyncHttpPostFilesRequest:(NSString *)urlStr withData: (NSDictionary *)dataDict
                         withFilePaths:(NSDictionary *)filePathDict  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
//NSLog(@"request http post filesss url>>>>>>>>>%@",urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:url];
    
    NSArray *keys = dataDict.allKeys;
    for (id key in keys){
        [req setPostValue:[dataDict objectForKey:key] forKey:key];
    }
    
    //多个上传文件
    [req setFile:[filePathDict objectForKey:@"oldImagePath"] forKey:@"oldImageName"];
    [req setFile:[filePathDict objectForKey:@"newImagePath"] forKey:@"newImageName"];
    
    [req setDelegate:httpDelegate];
    [req startAsynchronous];
}

+(NSString *)getServiceAddress
{
    NSString *env = NSLocalizedString(@"app_envis", @"testABC");
    NSString *prefix = nil;
    
    if([env isEqual:@"test"]){
        prefix = NSLocalizedString(@"testPrefixHttp", nil);
    }else{
        prefix = NSLocalizedString(@"productPrefixHttp", nil);
    }
    
    return prefix;
}

+(NSString *)getMqttServiceAddress
{
    NSString *envs = NSLocalizedString(@"app_envis", @"testABC");
    NSString *prefixs = nil;
    
    if([envs isEqual:@"test"]){
        prefixs = NSLocalizedString(@"testMqttService", nil);
    }else{
        prefixs = NSLocalizedString(@"productMqttService", nil);
    }
    
    return prefixs;
}




#pragma mark interface methords

//获取主题分类列表
+(void)getThemeCategoryList:(ASIHTTPRequestDelegate *)httpDelegate{
    NSString *requestPath = NSLocalizedString(@"url_get_theme_category_list", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrl withDelegate:httpDelegate];
}


// 主题列表
+(void) getThemeList:(NSString *)token withuserID:(NSString *)userID withuserBaseId:(NSString *)userBaseID withstudentCode:(NSString *)studentCode withCategory:(NSString*) category withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
       withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
//    NSString *requestPath = NSLocalizedString(@"url_get_theme_list", nil);
//    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
//    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userId=%@&createTimeOrder=%@&pageIndex=%@&pageSize=%@", strUrl,
//                           userBaseID, orderType, pageIndex, pageSize];
//    
//    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = NSLocalizedString(@"url_get_oes_teheme_list_by_category", nil);
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<token>%@</token>\n"
                                     "<userID>%@</userID>\n"
                                     "<userBaseID>%@</userBaseID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<category>%@</category>\n"
                                     "<orderByField>%@</orderByField>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, token,userID,userBaseID,studentCode,category,orderByType, orderType, pageIndex, pageSize, action];
    //    NSLog(@"-------------------action====%@", action);
    //    NSLog(@"-------------------urlService====%@", urlService);
    //    NSLog(@"-------------------parameterNoteString====%@", parameterNoteString);
    [OMDataServiceHttp sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                          withParameterNote:parameterNoteString withDelegate: httpDelegate];
    
}


// 主题列表
+(void) getThemeList:(NSString *)token withuserID:(NSString *)userID withuserBaseId:(NSString *)userBaseID withstudentCode:(NSString *)studentCode withCategory:(NSString*) category withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
       withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate  withRequestUserinfo:(NSDictionary *)userInfo
{
    //    NSString *requestPath = NSLocalizedString(@"url_get_theme_list", nil);
    //    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    //    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userId=%@&createTimeOrder=%@&pageIndex=%@&pageSize=%@", strUrl,
    //                           userBaseID, orderType, pageIndex, pageSize];
    //
    //    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
//    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
//    NSString *action = NSLocalizedString(@"url_get_oes_teheme_list_by_category", nil);
//    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
//    
//    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
//                                     "<token>%@</token>\n"
//                                     "<userID>%@</userID>\n"
//                                     "<userBaseID>%@</userBaseID>\n"
//                                     "<studentCode>%@</studentCode>\n"
//                                     "<category>%@</category>\n"
//                                     "<orderByField>%@</orderByField>\n"
//                                     "<orderType>%@</orderType>\n"
//                                     "<PageIndex>%@</PageIndex>\n"
//                                     "<PageSize>%@</PageSize>\n"
//                                     "</%@>", action, actionName, token,userID,userBaseID,studentCode,category,orderByType, orderType, pageIndex, pageSize, action];
//    //    NSLog(@"-------------------action====%@", action);
//    //    NSLog(@"-------------------urlService====%@", urlService);
//    //    NSLog(@"-------------------parameterNoteString====%@", parameterNoteString);
//    
//    [OMDataServiceHttp sendAsyncHttpPostRequest:urlService withData:parameterNoteString withDelegate:httpDelegate withRequestUserInfo:userInfo];
//
//    [OMDataServiceHttp sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
//                              withParameterNote:parameterNoteString withDelegate: httpDelegate withRequestUserInfo:userInfo];
    
}



// 主题列表
+(void) getThemeRecomendList:(NSString *)token withuserID:(NSString *)userID withuserBaseId:(NSString *)userBaseID withstudentCode:(NSString *)studentCode withCategory:(NSString*) category withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
       withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    //    NSString *requestPath = NSLocalizedString(@"url_get_theme_list", nil);
    //    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    //    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userId=%@&createTimeOrder=%@&pageIndex=%@&pageSize=%@", strUrl,
    //                           userBaseID, orderType, pageIndex, pageSize];
    //
    //    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = NSLocalizedString(@"url_get_oes_teheme_list_course_teacher", nil);
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<token>%@</token>\n"
                                     "<userID>%@</userID>\n"
                                     "<userBaseID>%@</userBaseID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<category>%@</category>\n"
                                     "<orderByField>%@</orderByField>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, token,userID,userBaseID,studentCode,category,orderByType, orderType, pageIndex, pageSize, action];
    //    NSLog(@"-------------------action====%@", action);
    //    NSLog(@"-------------------urlService====%@", urlService);
    //    NSLog(@"-------------------parameterNoteString====%@", parameterNoteString);
    [OMDataServiceHttp sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                              withParameterNote:parameterNoteString withDelegate: httpDelegate];
    
}


// 我关注的 主题列表
+(void) getThemeListByUserID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo

{
    NSString *requestPath = NSLocalizedString(@"url_get_theme_list_by_userID", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?createTimeOrder=2&user=%@", strUrl, userBaseID];
    
//    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}


// 我关注的 主题列表
+(void) getThemeListByUserID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate

{
    NSString *requestPath = NSLocalizedString(@"url_get_theme_list_by_userID", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?createTimeOrder=2&user=%@", strUrl, userBaseID];
    
    //    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate ];
}



//绑定手机号
+(void)getThemeList:(NSString *)token withuserID:(NSString *)userID withuserBaseId:(NSString *)userBaseID withstudentCode:(NSString *)studentCode withCategory:(NSString*) category withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
      withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
       withComBlock: ( void ( ^ )( NSString * ) )handler
      withFailBlock: failBlock{
    
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = NSLocalizedString(@"url_get_oes_teheme_list_by_category", nil);
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<token>%@</token>\n"
                                     "<userID>%@</userID>\n"
                                     "<userBaseID>%@</userBaseID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<category>%@</category>\n"
                                     "<orderByField>%@</orderByField>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, token,userID,userBaseID,studentCode,category,orderByType, orderType, pageIndex, pageSize, action];
    
//    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:urlService withPostData:parameterNoteString withComBlock:handler withFailBlock:failBlock];
    [OMDataServiceHttp sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                              withParameterNote:parameterNoteString withComBlock:handler withFailBlock:failBlock];
}




//绑定手机号
+(void)getThemeRecomendList:(NSString *)token withuserID:(NSString *)userID withuserBaseId:(NSString *)userBaseID withstudentCode:(NSString *)studentCode withCategory:(NSString*) category withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
              withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize                    withComBlock: ( void ( ^ )( NSString * ) )handler
              withFailBlock: failBlock{
    
    NSString *urlService = [OMDataUtil getUrlForKey:DISCUSS_SERVICE];
    NSString *action = NSLocalizedString(@"url_get_oes_teheme_list_by_category", nil);
    NSString *actionName = [OMDataUtil getUrlForKey:SOPE_ACTION_DISCUSS_NAME];
    
    NSString *parameterNoteString = [NSString stringWithFormat:@"<%@ xmlns=\"http://learningbar.open.com.cn/%@/\">\n"
                                     "<token>%@</token>\n"
                                     "<userID>%@</userID>\n"
                                     "<userBaseID>%@</userBaseID>\n"
                                     "<studentCode>%@</studentCode>\n"
                                     "<category>%@</category>\n"
                                     "<orderByField>%@</orderByField>\n"
                                     "<orderType>%@</orderType>\n"
                                     "<PageIndex>%@</PageIndex>\n"
                                     "<PageSize>%@</PageSize>\n"
                                     "</%@>", action, actionName, token,userID,userBaseID,studentCode,category,orderByType, orderType, pageIndex, pageSize, action];
    
//     [OMDataServiceHttp sendAsyncHttpPostRequest:urlService withPostData:parameterNoteString withComBlock:handler withFailBlock:failBlock];
//    
    [OMDataServiceHttp sendAsyncHttpPostRequest:urlService withAction:action withActionName:actionName
                              withParameterNote:parameterNoteString withComBlock:handler withFailBlock:failBlock];
}


//绑定手机号
+(void)getThemeListByUserID:(NSString *)userBaseID withComBlock: ( void ( ^ )( NSString * ) )handler
                 withFailBlock: failBlock{
    
    NSString *requestPath = NSLocalizedString(@"url_get_theme_list_by_userID", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
//    NSString *strUrlAll = [NSString stringWithFormat:@"%@?createTimeOrder=2&user=%@", strUrl, userBaseID];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%d",2], @"createTimeOrder",
                              userBaseID, @"user",
                              nil];
    
    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrl withData:paraDict withComBlock:handler withFailBlock:failBlock];
}






//添加对主题的关注
+(void) addAttentionOfThemeByuserBaseID:(NSString *)userBaseID withThemeID:(NSString*)themeID
                           withDelegate: (ASIHTTPRequestDelegate *)httpDelegate  withRequestUserinfo:(NSDictionary *)userInfo
{
    NSString *requestPath = NSLocalizedString(@"url_add_attention_oftheme", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userId=%@&topicId=%@", strUrl, userBaseID, themeID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}

//取消对主题的关注
+(void) cancleAttentionOfThemeByuserBaseID:(NSString *)userBaseID withThemeID:(NSString*)themeID
                              withDelegate: (ASIHTTPRequestDelegate *)httpDelegate  withRequestUserinfo:(NSDictionary *)userInfo
{
    NSString *requestPath = NSLocalizedString(@"url_cancle_attention_oftheme", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userId=%@&topicId=%@", strUrl, userBaseID, themeID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}

//主题详情
+(void)getThemeDetailByThemeID:(NSString *)themeID withUserBaseID:(NSString *)userBaseID
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    //http://10.96.142.93:17000/learnbar/topic/get.json?id=1&userID=1883
    NSString *requestPath = NSLocalizedString(@"url_get_themedetail_by_themeid", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?id=%@&userId=%@", strUrl, themeID, userBaseID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
}

//主题详情  url_get_themedetail_by_themeid_user
+(void)getThemeDetailByThemeIDUserID:(NSString *)themeID withUserBaseID:(NSString *)userBaseID
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    //http://10.96.142.93:17000/learnbar/topic/get.json?id=1&userID=1883
    NSString *requestPath = NSLocalizedString(@"url_get_themedetail_by_themeid_user", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?id=%@&user=%@", strUrl, themeID, userBaseID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
}


//主题的发言列表
+(void)getSpeakListByThemeID:(NSString *)themeID
            withOrderByField:(NSString *)orderByField
               withOrderType:(NSString *)orderType //按创建时间排序 0 不排序（默认），1升序 2降序
               withPageIndex:(NSString *)pageIndex
                withPageSize:(NSString *)pageSize
               withGreaterThanId:(NSString *)greaterThanId //获取最新的数据
                withLessThanId:(NSString *)lessThanId   //获取历史数据
                withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
         withRequestUserinfo:(NSDictionary *)userInfo
{
    //10.96.142.93:17000/learnbar/speak/find.json?topic=1&pageIndex=2&pageSize=2
    //10.96.142.93:17000/learnbar/speak/find.json?createTimeOrder=2&topic=1&pageNumber=1&pageSize=2&lessThanId=9
    NSString *requestPath = NSLocalizedString(@"url_getspeak_list_by_themeid", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?createTimeOrder=%@&topic=%@&pageNumber=%@&pageSize=%@&lessThanId=%@&greaterThanId=%@",
                           strUrl, orderType, themeID, pageIndex, pageSize, lessThanId, greaterThanId];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}


//主题的发言列表 + userbaseID
+(void)getSpeakListByThemeID:(NSString *)themeID
            withOrderByField:(NSString *)orderByField
               withOrderType:(NSString *)orderType //按创建时间排序 0 不排序（默认），1升序 2降序
               withPageIndex:(NSString *)pageIndex
                withPageSize:(NSString *)pageSize
           withGreaterThanId:(NSString *)greaterThanId //获取最新的数据
              withLessThanId:(NSString *)lessThanId   //获取历史数据
                withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
         withRequestUserinfo:(NSDictionary *)userInfo
              withUserbaseID:(NSString *)userbaseID
{
    //10.96.142.93:17000/learnbar/speak/find.json?topic=1&pageIndex=2&pageSize=2
    //10.96.142.93:17000/learnbar/speak/find.json?createTimeOrder=2&topic=1&pageNumber=1&pageSize=2&lessThanId=9
    NSString *requestPath = NSLocalizedString(@"url_getspeak_list_by_themeid_userid", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?createTimeOrder=%@&topic=%@&pageNumber=%@&pageSize=%@&lessThanId=%@&greaterThanId=%@&userId=%@",
                           strUrl, orderType, themeID, pageIndex, pageSize, lessThanId, greaterThanId, userbaseID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}


//参与发言
+(void)addSpeakContentByUserID:(NSString *)userID withThemeID:(NSString *)themeID withSpeakContent:(NSString *)speakContent
           withOriginalSpeakID:(NSString *)originalSpeakID withParentSpeakId:(NSString *)parentSpeakId withIsReplay:(NSString *)isReplay
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:requestUserinfo;
{
//    //10.96.142.93:17000/learnbar/speak/add.json?userId=1981&topicId=40&content=laomaaaaaaaa&originalId=0&parentSpeakId=0&isReply=0
    NSString *requestPath = NSLocalizedString(@"url_add_speak_content", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
//    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userId=%@&topicId=%@&content=%@&originalId=%@&parentSpeakId=%@&isReply=%@",
//                           strUrl, userID, themeID, speakContent, originalSpeakID, parentSpeakId, isReplay];
//    
//    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              userID, @"userId",
                              themeID, @"topicId",
                              speakContent, @"content",
                              parentSpeakId, @"parentSpeakId",
                              originalSpeakID, @"originalId",
                              isReplay, @"isReply",
                              nil];
    
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:requestUserinfo];
}

//发言条目详情
+(void)getSpeakDetailBySpeakID:(NSString *)speakID
                    withUserID:(NSString *)userID
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
           withRequestUserinfo:(NSDictionary *)userInfo
{
    //http://10.96.142.93:17000/learnbar/speak/getAboutUser.json?id=114&userId=1982
    NSString *requestPath = NSLocalizedString(@"url_get_speakdetail_by_speakid", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?id=%@&userId=%@",
                           strUrl, speakID, userID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
  
}


//发言条目评论列表
+(void)getReviewListBySpeakID:(NSString *)speakID
             withOrderByField:(NSString *)orderByField
                withOrderType:(NSString *)orderType    //按创建时间排序 0 不排序（默认），1升序 2降序
                withPageIndex:(NSString *)pageIndex
                 withPageSize:(NSString *)pageSize
            withGreaterThanId:(NSString *)greaterThanId //获取最新的数据
               withLessThanId:(NSString *)lessThanId   //获取历史数据
                 withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
          withRequestUserinfo:(NSDictionary *)userInfo
{
    //按创建时间排序 0 不排序（默认），1升序 2降序
    //int createTimeOrder = 0;
    //http://10.96.142.93:17000/learnbar/comment/find.json?speak=40&pageNumber=1&pageSize=4
    NSString *requestPath = NSLocalizedString(@"url_get_reviewlist_by_speakid", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];

    NSString *strUrlAll = [NSString stringWithFormat:@"%@?createTimeOrder=%@&speak=%@&pageNumber=%@&pageSize=%@&greaterThanId=%@&lessThanId=%@",
                           strUrl, orderType, speakID, pageIndex, pageSize, greaterThanId, lessThanId];

    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}


//发言条目评论列表 + userbaseID
+(void)getReviewListBySpeakID:(NSString *)speakID
             withOrderByField:(NSString *)orderByField
                withOrderType:(NSString *)orderType    //按创建时间排序 0 不排序（默认），1升序 2降序
                withPageIndex:(NSString *)pageIndex
                 withPageSize:(NSString *)pageSize
            withGreaterThanId:(NSString *)greaterThanId //获取最新的数据
               withLessThanId:(NSString *)lessThanId   //获取历史数据
                 withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
          withRequestUserinfo:(NSDictionary *)userInfo
               withUserbaseID:(NSString *)userbaseID
{
    //按创建时间排序 0 不排序（默认），1升序 2降序
    //int createTimeOrder = 0;
    //http://10.96.142.93:17000/learnbar/comment/find.json?speak=40&pageNumber=1&pageSize=4
    NSString *requestPath = NSLocalizedString(@"url_get_reviewlist_by_speakid_userid", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?createTimeOrder=%@&speak=%@&pageNumber=%@&pageSize=%@&greaterThanId=%@&lessThanId=%@&userId=%@",
                           strUrl, orderType, speakID, pageIndex, pageSize, greaterThanId, lessThanId, userbaseID];
    
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}


//删除发言
+(void)deleteSpeakBySpeakID:(NSString *)speakID
               withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
        withRequestUserinfo:(NSDictionary *)userInfo
{
    NSString *requestPath = NSLocalizedString(@"url_delete_speak_by_speakid", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?id=%@", strUrl, speakID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate  withRequestUserInfo:userInfo];
}

//删除发言
+(void)deleteSpeakBySpeakID:(NSString *)speakID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{
    NSString *requestPath = NSLocalizedString(@"url_delete_speak_by_speakid", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userBaseID=%@&id=%@", strUrl, userID, speakID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}

//赞发言
+(void)addSupportSpeakByUserID:(NSString *)userID
                   withSpeakID:(NSString *)speakID
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
           withRequestUserinfo:(NSDictionary *)userInfo
{
    //10.96.142.93:17000/learnbar/speak/like.json?speak=14&user=1982
    NSString *requestPath = NSLocalizedString(@"url_add_support_speak", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?user=%@&speak=%@",strUrl,userID, speakID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}


//赞发言
+(void)addSupportSpeakByUserID:(NSString *)userID
               withStudentCode:(NSString *)studentCode
                   withSpeakID:(NSString *)speakID
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{
    //10.96.142.93:17000/learnbar/speak/like.json?speak=14&user=1982
    NSString *requestPath = NSLocalizedString(@"url_add_support_speak", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?user=%@&speak=%@",strUrl,userID, speakID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}



//收藏发言
+(void)addFavoriteSpeakByUserID:(NSString *)userID
                withSpeakID:(NSString *)speakID
                   withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
            withRequestUserinfo:(NSDictionary *)userInfo
{
    //10.96.142.93:17000/learnbar/speak/collect.json?speak=14&user=1982
    NSString *requestPath = NSLocalizedString(@"url_add_favorite_speak", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?user=%@&speak=%@",strUrl,userID, speakID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}

//删除收藏发言
+(void)deleteFavoriteSpeakByUserID:(NSString *)userID
                       withSpeakID:(NSString *)speakID
                      withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
               withRequestUserinfo:(NSDictionary *)userInfo
{
    //10.96.142.93:17000/learnbar/speak/uncollect.json?speak=14&user=1982
    NSString *requestPath = NSLocalizedString(@"url_delete_favorite_speak", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?user=%@&speak=%@",strUrl,userID, speakID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}


//我收藏的发言
+(void)myFavoritedSpeakListByUserBaseID:(NSString *)userBaseID
                          withOrderType:(NSString *)orderType    //按创建时间排序 0 不排序（默认），1升序 2降序
                          withPageIndex:(NSString *)pageIndex
                           withPageSize:(NSString *)pageSize
                           withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    ////10.96.142.93:17000/learnbar/collect/findFavoriteList.json?userBaseID=1982&orderType=2&PageIndex=1&PageSize=1
    NSString *requestPath = NSLocalizedString(@"url_user_favorited_speaks", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userBaseID=%@&orderType=%@&PageIndex=%@&PageSize=%@",
                           strUrl, userBaseID, orderType, pageIndex, pageSize];
    
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
}


//添加发言评论
+(void)addReviewOfSpeakByUserID:(NSString *)userID
                    withSpeakID:(NSString *)speakID
withPid:(NSString *)pid  //上一级评论的 ID
withSid:(NSString *)sid  //该评论的 根 ID
              withReviewContent:(NSString *)reviewContent
                   withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
            withRequestUserinfo:(NSDictionary *)userInfo
{
    //10.96.142.93:17000/learnbar/comment/add.json?speak=98&pid=0&sid=0&content=gggggggggggggggggg&user=1983
    NSString *requestPath = NSLocalizedString(@"url_add_review_ofspeak", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              userID, @"user",
                              speakID, @"speak",
                              reviewContent, @"content",
                              pid, @"pid",
                              sid, @"sid",
                              nil];
    
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}

//回复评论
+(void)addRevertOfReviewByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCommentPId:(NSString *)pID withCommentSId:(NSString *)sID withSpeakID:(NSString *)speakID withRevertContent:(NSString *)revertContent withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
             withRequestUserinfo:(NSDictionary *)userInfo
{
    
    NSString *requestPath = NSLocalizedString(@"url_add_revert_ofreview", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              userID, @"user",
                              speakID, @"speak",
                              revertContent, @"content",
                              pID, @"pid",
                              sID, @"sid",
                              nil];
    
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}

//发布个人主页（教师主页）
+(void)getThemeAuthorDetailByThemeAuthorID:(NSString *)themeAuthorID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{
    
    NSString *requestPath = NSLocalizedString(@"url_get_themeauthor_detail_by_themeauthorid", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userBaseID=%@&friendID=%@", strUrl, userID, themeAuthorID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}

//发布人的主题
+(void)getThemeListByAuthorID:(NSString *)themeAuthorID withuserBaseID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{
    NSString *requestPath = NSLocalizedString(@"url_get_themelist_by_authorid", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userId=%@&createUser=%@", strUrl, userBaseID, themeAuthorID];
//    NSString *strUrlAll = [NSString stringWithFormat:@"%@?createUser=%@", strUrl, themeAuthorID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}


//用户禁言信息
+(void)getUserNoSpeakInfoByUserBaseID:(NSString *)userBaseID
                     withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
                withRequestUserinfo:(NSDictionary *)userInfo
{

    
    NSString *requestPath = NSLocalizedString(@"url_get_user_nospeakinfo_by_userid", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?id=%@", strUrl, userBaseID];
    
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}


//编辑发言
+(void)editSpeakContentByUserID:(NSString *)userID
                    withSpeakID:(NSString *)speakID
               withSpeakContent:(NSString *)speakContent
                   withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{
    NSString *requestPath = NSLocalizedString(@"url_edit_speak_content", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    //    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userId=%@&topicId=%@&content=%@&originalId=%@&parentSpeakId=%@&isReply=%@",
    //                           strUrl, userID, themeID, speakContent, originalSpeakID, parentSpeakId, isReplay];
    //
    //    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              userID, @"user",
                              speakContent, @"content",
                              speakID, @"id",
                              nil];
    
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate];
}

//编辑发言
+(void)editSpeakContentByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withThemeID:(NSString *)themeID withSpeakContent:(NSString *)speakContent withOriginalSpeakID:(NSString *)originalSpeakID withIsTranspond:(NSString *)isTranspond withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:requestUserinfo
{
    NSString *requestPath = NSLocalizedString(@"url_edit_speak_content", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              userID, @"user",
                              speakID, @"id",
                              speakContent, @"content",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:requestUserinfo];
}





//编辑发言评论
+(void)editReviewOfSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withReviewID:(NSString *)reviewID withReviewContent:(NSString *)reviewContent withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:requestUserinfo
{
    NSString *requestPath = NSLocalizedString(@"url_edit_review_ofspeak", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              userID, @"user",
                              speakID, @"id",
                              reviewContent, @"content",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:requestUserinfo];
//    NSString *strUrlAll = [NSString stringWithFormat:@"%@?user=%@&id=%@&content=%@",strUrl,userID, speakID,reviewContent];
//    
//    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
}




//编辑发言评论
+(void)editReviewOfSpeakByUserID:(NSString *)userID
                    withReviewID:(NSString *)reviewID
               withReviewContent:(NSString *)reviewContent
                    withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
             withRequestUserinfo:(NSDictionary *)userInfo
{
    NSString *requestPath = NSLocalizedString(@"url_edit_review_ofspeak", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              userID, @"user",
                              reviewID, @"id",
                              reviewContent, @"content",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
}





//我的发言
+(void)getSpeakListByUserID:(NSString *)UserID withPageNum:(NSString *)pageNum withPageSize:(NSString *)pageSize
        withcreateTimeOrder:(NSString *)createTimeOrder
          withgreaterThanId:(NSString *)greaterThanId
             withlessThanId:(NSString *)lessThanId
               withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"url_get_speaklist_with_me", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userId=%@&pageNumber=%@&pageSize=%@", strUrl, UserID,pageNum,pageSize];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}




//我d的评论
+(void)getCommentListByUserID:(NSString *)UserID withcreateTimeOrder:(NSString *)createTimeOrder withPageNum:(NSString *)pageNum withPageSize:(NSString *)pageSize withgreaterThanId:(NSString *)greaterThanId
               withlessThanId:(NSString *)lessThanId withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"url_get_commentlist_with_me", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userId=%@&pageNumber=%@&pageSize=%@", strUrl, UserID,pageNum,pageSize];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}





//我的赞
+(void)getFavorteListByUserID:(NSString *)UserID withPageNum:(NSString *)pageNum withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"url_get_support_speaklist_with_me", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userId=%@&pageNumber=%@&pageSize=%@", strUrl, UserID, pageNum,pageSize];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}




//添加好友
+(void)addFriendInfoReqUserID:(NSString *)UserID withFriendID:(NSString *)friendID withMyInfo:(NSString *)myInfo withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"url_add_friend_info_request", nil);
//    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
//    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userBaseID=%@&FriendID=%@&MyInfo=%@", strUrl, UserID, friendID,myInfo];
//    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"userBaseID",
                              friendID, @"FriendID",
                              myInfo, @"MyInfo",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}





//好友个人主页
+(void)getHomePageInfoWithUserID:(NSString *)UserID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{

    NSString *requestPath = NSLocalizedString(@"url_learningbar_sdk_getHomePageInfo", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userBaseID=%@", strUrl, UserID];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
    
}




//个人主页
+(void)getPersonalDetailwithUserID:(NSString *)UserID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"url_learningbar_sdk_url_getPersonalDetail", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userBaseID=%@", strUrl, UserID];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}




//个人主页
+(void)getPersonalDetailwithUserID:(NSString *)UserID
                      withComBlock: ( void ( ^ )( NSString * ) )handler
                     withFailBlock: failBlock
{
    
    NSString *requestPath = NSLocalizedString(@"url_learningbar_sdk_url_getPersonalDetail", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"userBaseID",
                              nil];
    
    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrl withData:paraDict withComBlock:handler withFailBlock:failBlock];
    
}




//删除评论
+(void)deleteReviewByUserID:(NSString *)UserID withReviewID:(NSString *)ReviewID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
{

    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_deleteReviewByReviewID", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userBaseID=%@&id=%@", strUrl, UserID,ReviewID];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate];
}




//删除评论
+(void)deleteReviewByUserID:(NSString *)UserID withReviewID:(NSString *)ReviewID
               withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
        withRequestUserinfo:(NSDictionary *)userInfo
{
    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_deleteReviewByReviewID", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userBaseID=%@&id=%@", strUrl, UserID,ReviewID];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}





//获取个人资料
+(void)getPersonalDetailInfowithUserID:(NSString *)UserID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{
    NSString *requestPath = NSLocalizedString(@"url_sdk_learning_getDetail_personInfo", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userBaseID=%@", strUrl, UserID];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}





//获取个人资料
+(void)getPersonalDetailInfowithUserID:(NSString *)UserID
                          withComBlock: ( void ( ^ )( NSString * ) )handler
                         withFailBlock: failBlock
{
    NSString *requestPath = NSLocalizedString(@"url_sdk_learning_getDetail_personInfo", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"userBaseID",
                              nil];
    
    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrl withData:paraDict withComBlock:handler withFailBlock:failBlock];
}





//修改名字
+(void)updateUserNamewithUserID:(NSString *)UserID
                   withUserName:(NSString *)userName
                   withComBlock: ( void ( ^ )( NSString * ) )handler
                  withFailBlock: failBlock
{
    
    NSString *requestPath = NSLocalizedString(@"url_learningbar_sdk_url_editUserName", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"userBaseID",
                              userName, @"UserName",
                              nil];
    
    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrl withData:paraDict withComBlock:handler withFailBlock:failBlock];
    
    
//    __block ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strUrl]];
//    [req setPostValue:[NSString stringWithFormat:@"%@", UserID] forKey:@"userBaseID"];
//     [req setPostValue:[NSString stringWithFormat:@"%@", userName] forKey:@"UserName"];
//    [req addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
//    [req addRequestHeader:@"token" value:GETUSER_INFO.tokenOfOBS];
//    [req setRequestMethod:@"POST"];
//
//    [req setCompletionBlock:^{
//        NSString *responseString = [req responseString];
//        handler(responseString);
//    }];
//    
//    [req setFailedBlock:failBlock];
//    [req startAsynchronous];
}

//修改性别
+(void)updateUserSexwithUserID:(NSString *)UserID withUserSex:(NSString *)userSex withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"url_learningbar_sdk_url_editUserSex", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"userBaseID",
                              userSex, @"UserSex",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
}
//修改所在地
+(void)updateUserAddresswithUserID:(NSString *)UserID withUserPlace:(NSString *)userPlace withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"url_learningbar_sdk_url_editUserAddress", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"userBaseID",
                              userPlace, @"UserLocal",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
}
//修改邮箱
+(void)updateUserEmailwithUserID:(NSString *)UserID withUserEmail:(NSString *)userEmail withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"url_learningbar_sdk_url_editUserEmail", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"userBaseID",
                              userEmail, @"UserEmail",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
}
//修改手机号
+(void)updateUserPhoneNumberwithUserID:(NSString *)UserID withUserPhoneNum:(NSString *)userPhoneNum withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"url_learningbar_sdk_url_editUserPhoneNumber", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"userBaseID",
                              userPhoneNum, @"UserPhoneNumber",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
}
//修改简介
+(void)updateUserIntroducewithUserID:(NSString *)UserID withUserIntroduce:(NSString *)userIntro withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"url_learningbar_sdk_url_editUserIntroduce", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"userBaseID",
                              userIntro, @"UserIntroduce",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
}
//修改头像
+(void)updateUserIconwithUserID:(NSString *)UserID withUserIconPath:(NSString *)iconPath withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"url_learningbar_sdk_url_editIcon", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSURL *urlStr=[NSURL URLWithString: strUrl];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:urlStr];
    [request setPostValue:UserID forKey:@"userBaseID"];
    if (iconPath!=NULL) {
        [request setFile:iconPath forKey:@"uploadFile"];
    }
    [request setDelegate:httpDelegate];
    [request startAsynchronous];
}

//提交积分
+(void)subMitPersonUserScore:(NSString *)UserID withScoreType:(NSString *)ScoreType withUserScore:(NSString *)UserScore withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
         withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_addPersonalUserScore", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"user",
                              ScoreType, @"type",
                              UserScore, @"delta",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}



//提交积分
+(void)subMitPersonUserScoreWithBlock:(NSString *)UserID withScoreType:(NSString *)ScoreType withUserScore:(NSString *)UserScore  withComBlock: ( void ( ^ )( NSString * ) )handler
        withFailBlock: failBlock
{
    
    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_addPersonalUserScore", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"user",
                              ScoreType, @"type",
                              UserScore, @"delta",
                              nil];
//    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrl withData:paraDict withComBlock:handler withFailBlock:failBlock];

    
}


//得到积分
+(void)getPersonalUserScore:(NSString *)UserID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
        withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_getUserScoreList", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"user",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}


//处理通过验证
+(void)setFriendRelationUserID:(NSString *)UserID withAskFirendID:(NSString *)askFriendID withisFriend:(NSString *)isFriend withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
           withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_setFriendRelation", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"userBaseID",
                              askFriendID, @"AskUserID",
                              isFriend, @"IsFriend",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}

//删除好友
+(void)deleteFriendRequestInfo:(NSString *)UserID withFriendID:(NSString *)friendID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
           withRequestUserinfo:(NSDictionary *)userInfo
{

    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_deleteFriendRequestInfo", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              UserID, @"userBaseID",
                              friendID, @"FriendID",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}

//添加好友
+(void)addFriendRequestInfo:(NSString *)userID withFriendID:(NSString *)friendID wirhMyInfo:(NSString *)myInfo withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
        withRequestUserinfo:(NSDictionary *)userInfo
{
    
    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_addFriendRequestInfo", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              userID, @"userBaseID",
                              friendID, @"FriendID",
                              myInfo, @"MyInfo",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}

//获取好友个人信息
+(void)getFriendDetailByUserId:(NSString *)userID withFriendID:(NSString *)friendID
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
           withRequestUserinfo:(NSDictionary *)userInfo
{
    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_getFriendDetailByUserId", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    //NSString *strUrlAll = [NSString stringWithFormat:@"%@?userBaseID=%@&friendID=%@", strUrl, userID,friendID];
    
    //[OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              userID, @"userBaseID",
                              friendID, @"friendID",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}

//获取好友按姓名
+(void)getFriendListByName:(NSString *)userName withorderByField:(NSString *)orderByField withcreateTimeOrder:(NSString *)createTimeOrder withpageNumber:(NSString *)pageNumber withpageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
       withRequestUserinfo:(NSDictionary *)userInfo
{
    
    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_getFriendListByName", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userName=%@&orderByField=%@&createTimeOrder=%@&pageNumber=%@&pageSize=%@", strUrl, userName,orderByField,createTimeOrder,pageNumber,pageSize];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}

//获取当前用户的好友列表
+(void)getFriendListByUserId:(NSString *)UserID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
         withRequestUserinfo:(NSDictionary *)userInfo
{
    
//    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_getFriendListByUserId", nil);
//    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
//    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                              UserID, @"userBaseID",
//                              nil];
//    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
    
    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_getFriendListByUserId", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@?userBaseID=%@", strUrl, UserID];
    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
}



//获取未读消息
+(void)getNewMessge:(NSString *)user withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
withRequestUserinfo:(NSDictionary *)userInfo
{
    
    NSString *requestPath = NSLocalizedString(@"learningbar_message_facade_indUnreadMessage", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getMqttServiceAddress], requestPath];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              user, @"toUser",
                              pageSize, @"pageSize",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}

//发送文本消息
+(void)sendMessage:(NSString *)fromUser withtoUser:(NSString *)toUser withcontent:(NSString *)content withcheckTime:(NSString *)checkTime withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
withRequestUserinfo:(NSDictionary *)userInfo
{
    
    NSString *requestPath = NSLocalizedString(@"learningbar_message_api_sendMessage", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getMqttServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              fromUser, @"fromUser",
                              toUser, @"toUser",
                              content, @"content",
                              checkTime, @"checkTime",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
}

//发送文件
+(void)sendFile:(NSString *)fromUser withtoUser:(NSString *)toUser withcheckTime:(NSString *)checkTime withFilePath:(NSString *)filePath withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
withRequestUserinfo:(NSDictionary *)userInfo
{
    NSString *requestPath = NSLocalizedString(@"learningbar_message_api_sendImageFile", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getMqttServiceAddress], requestPath];
    
    NSURL *urlStr=[NSURL URLWithString: strUrl];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:urlStr];
    [request setPostValue:fromUser forKey:@"fromUser"];
    [request setPostValue:toUser forKey:@"toUser"];
    [request setPostValue:checkTime forKey:@"checkTime"];
    if (filePath!=NULL) {
        [request setFile:filePath forKey:@"uploadFile"];
    }
    [request setDelegate:httpDelegate];
    [request startAsynchronous];
    
}




//后台系统（OBS） 的登录接口，老马 那边 的基础服务系统；
+(void)loginOBS:(NSString *)userName withPassward:(NSString *)passward
   withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{
    //    NSString *strUrlAll = @"http://10.96.142.93:17000/api/login/appUserApilogin.json?k=2&sec=a8c362c9ff954bb1a91ac6941ed02b30&u=laoli123&p=a11111111";
    NSString *requestPath = NSLocalizedString(@"learningbar_obs_login_url", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              NSLocalizedString(@"learningbar_obs_app_code", nil), @"k",
                              NSLocalizedString(@"learningbar_obs_secret", nil), @"sec",
                              userName, @"u",
                              passward, @"p",
                              nil];
    
    //    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
    //
    //    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:para   Dict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
    //NSLog(@"login obs url====%@", strUrl);
    
    NSURL *url = [NSURL URLWithString:strUrl];
    ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:url];
    [req addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
    [req setRequestMethod:@"POST"];
    
    NSArray *keys = paraDict.allKeys;
    for (id key in keys){
        [req setPostValue:[paraDict objectForKey:key] forKey:key];
    }
    
    [req setDelegate:httpDelegate];
    [req addRequestHeader:@"ClientType" value:@"1"];
    [req setUserInfo:userInfo];
    [req startAsynchronous];
    
}

//后台系统（OBS） 的登录接口，老马 那边 的基础服务系统；
+(void)loginOBSWithBlock:(NSString *)userName withPassward:(NSString *)passward
            withComBlock: ( void ( ^ )( NSString * ) )handler
           withFailBlock: failBlock;{
    
    
    NSString *requestPath = NSLocalizedString(@"learningbar_obs_login_url", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              NSLocalizedString(@"learningbar_obs_app_code", nil), @"k",
                              NSLocalizedString(@"learningbar_obs_secret", nil), @"sec",
                              userName, @"u",
                              passward, @"p",
                              nil];
    
    //    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
    //
    //    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:para   Dict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
    //NSLog(@"login obs url====%@", strUrl);
    
    NSURL *url = [NSURL URLWithString:strUrl];
    __block ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:url];
    [req addRequestHeader:@"Content-Type" value: @"text/xml; charset=utf-8"];
    [req setRequestMethod:@"POST"];
    
    NSArray *keys = paraDict.allKeys;
    for (id key in keys){
        [req setPostValue:[paraDict objectForKey:key] forKey:key];
    }
    
    [req addRequestHeader:@"ClientType" value:@"1"];
    [req setCompletionBlock:^{
        NSString *responseString = [req responseString];
        handler(responseString);
    }];
    [req setFailedBlock:failBlock];

   
    [req startAsynchronous];

}



//添加访问记录
+(void)addFriendVisitRecord:(NSString*)friendBaseId withUserBaseID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
        withRequestUserinfo:(NSDictionary *)userInfo
{
    
    
//    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_add_liulan_record", nil);
//    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
//    NSString *strUrlAll = [NSString stringWithFormat:@"%@?FriendID=%@?userBaseID=%@", strUrl, friendBaseId,userBaseID];
//    [OMDataServiceHttp sendAsyncHttpRequest:strUrlAll withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
    
    
    NSString *requestPath = NSLocalizedString(@"learningbar_sdk_url_add_liulan_record", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              userBaseID, @"FriendID",
                              friendBaseId, @"userBaseID",
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
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



/////////////////////////以下是与通讯录有关的接口；
//上传通讯录
+(void)sendContacts:(NSString*)contacts withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo
{
    NSString *requestPath = @"/facade/contact/uploadcontact.json";
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrl withStringData:contacts withDelegate:httpDelegate];
}


//绑定手机号
+(void)bandPhoneNumberwithUserID:(NSString *)UserBaseID withPhoneNumber:(NSString *)phoneNumber
                      withComBlock: ( void ( ^ )( NSString * ) )handler
                     withFailBlock: failBlock
{
    
    NSString *requestPath = @"facade/contact/bindPhone.json";
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              GETUSER_INFO.appIndex, @"app",
                              UserBaseID, @"user",
                              phoneNumber, @"phone",
                              nil];
    
    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrl withData:paraDict withComBlock:handler withFailBlock:failBlock];
    
}


//得到 当前用户 与 通讯录中的朋友的关系的状态；
+(void)getRelationOfUserAndContacterWithPhoneNumber:(NSString *)phoneNumber
                                   withComBlock: ( void ( ^ )( NSString * ) )handler
                                  withFailBlock: failBlock
{
    NSString *requestPath = @"facade/contact/getPhoneStatus.json";
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              GETUSER_INFO.appIndex, @"app",
                              phoneNumber, @"phone",
                              nil];
    
    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrl withData:paraDict withComBlock:handler withFailBlock:failBlock];

}


//得到 当前用户 使用 本app时的地理位置；
+(void)saveCurrentGPSWithUserBaseID:(NSString *)userBaseID withLatitude:(NSString *)latitude withLongitude:(NSString *)longitude withAddress:(NSString *)address
                                       withComBlock: ( void ( ^ )( NSString * ) )handler
                                      withFailBlock: failBlock
{
    NSString *requestPath = @"facade/contact/uploadgps.json";
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              GETUSER_INFO.appIndex, @"app",
                              userBaseID, @"user",
                              longitude, @"longitude",
                              latitude, @"latitude",
                              address, @"address",
                              nil];
    
    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrl withData:paraDict withComBlock:handler withFailBlock:failBlock];
    
}


//得到 当前用户 使用 本app时的地理位置；
+(void)saveCurrentGPSWithPostDataString:(NSString *)postData
                       withComBlock: ( void ( ^ )( NSString * ) )handler
                      withFailBlock: failBlock
{
    NSString *requestPath = @"facade/contact/uploadgps.json";
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrl withPostData:postData withComBlock:handler withFailBlock:failBlock];
    
}



//获取设备的ID，该ID是在 服务端记录的，通过 设备的唯一标识 来获取的；
+(void)getDeviceDBIDWithDeviceInfo:(NSString*)deviceInfo
                      withComBlock: ( void ( ^ )( NSString * ) )handler
                     withFailBlock: failBlock
{
    NSString *requestPath = @"facade/driver/uploadDriver.json";
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    
    
    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrl withPostData:deviceInfo withComBlock:handler withFailBlock:failBlock];
}


+(void)sendTerminalBigData:(NSString*)requestPrara withDelegate:(ASIHTTPRequestDelegate *)httpDelegate{
    NSString *requestPath = @"http://pv.open.com.cn/mobileinfo.php?";
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",requestPath,requestPrara];
    //http://pv.open.com.cn/mobileinfo.php?logChannel=域名&logBtsVal=
    //手机端的唯一标记&logUserid=用户名&logUrl=用户打开的页面&Title=页面标题&logOsType=手机操作系统
    
   
    [OMDataServiceHttp sendAsyncHttpRequest:strUrl withDelegate:httpDelegate];
}

// 获取主题分类
+(void)getThemeCategory:(ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo{
    
    
    NSString *requestPath = NSLocalizedString(@"url_get_theme_category_list", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@",
                           strUrl];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              GETUSER_INFO.appIndex, @"app",
                              
                              nil];
    [OMDataServiceHttp sendAsyncHttpPostRequest:strUrlAll withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];

}


// 获取主题分类
+(void)getThemeCategoryBlock:( void ( ^ )( NSString * ) )handler
          withFailBlock: failBlock{
    
    
    NSString *requestPath = NSLocalizedString(@"url_get_theme_category_list", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@",
                           strUrl];
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              GETUSER_INFO.appIndex, @"app",nil];

    [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrlAll withData:paraDict withComBlock:handler withFailBlock:failBlock];
    
}



// 获取推荐的主题
+(void)getRecommendThemeList:(NSString*)recommend withDelegate:(ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo{
    
    NSString *requestPath = NSLocalizedString(@"url_get_theme_list", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@",
                           strUrl];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              GETUSER_INFO.appIndex, @"app",
                              GETUSER_INFO.userBaseID, @"userId",
                              recommend , @"weight",
                              nil]; 
  [OMDataServiceHttp sendAsyncHttpPostRequest:strUrlAll withData:paraDict withDelegate:httpDelegate withRequestUserInfo:userInfo];
    
}


//
+(void)getRecommendThemeListBlock:(NSString *)recommend withComBlock:(void (^)(NSString *))handler withFailBlock:(id)failBlock{
    
    NSString *requestPath = NSLocalizedString(@"url_get_theme_list", nil);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [OMDataServiceHttp getServiceAddress], requestPath];
    NSString *strUrlAll = [NSString stringWithFormat:@"%@",
                           strUrl];
    
    NSDictionary *paraDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              GETUSER_INFO.appIndex, @"app",
                              GETUSER_INFO.userBaseID, @"userId",
                              recommend , @"weight",
                              nil];
  [OMDataServiceHttp sendAsyncHttpPostRequestWithBlock:strUrlAll withData:paraDict withComBlock:handler withFailBlock:failBlock];
    
}

// 获取版本更新信息
+(void)getVersionUpdateInfoWithBlock: ( void ( ^ )( NSString * ) )handler
              withFailBlock: failBlock
{

    NSString *urlString = [NSString stringWithFormat:@"%@",@"http://itunes.apple.com/lookup?id=791469319"];
    __block ASIFormDataRequest* request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setRequestMethod:@"POST"];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        handler(responseString);
    }];
    [request setFailedBlock:failBlock];

    [request startAsynchronous];
}


@end
