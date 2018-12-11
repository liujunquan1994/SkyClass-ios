//
//  getIndexData.h
//  skyclass
//
//  Created by skyclass on 15/6/3.
//
//

#import <Foundation/Foundation.h>
@class ASIHTTPRequestDelegate;

@interface getIndexData : NSObject
+(void) sendAsyncHttpPostRequestss:(NSString *)urlService withAction:(NSString *)action withActionName:(NSString *)actionName
                 withParameterNote:(NSString *)parameterNote withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
               withRequestUserInfo:(NSDictionary *)userInfo  withComBlock: ( void ( ^ )( NSString * ) )handler
                     withFailBlock: failBlock;
+(void)getOpenCourseVideoList:(NSString*) category withPageNumber:(NSString*)pageNumber withPageSize:(NSString*)pageSize withDelegate:(ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo;

// 公开课
+(void)getOpenCourseVideoListWithBlock:(NSString *)category withPageNumber:(NSString *)pageNumber withPageSize:(NSString *)pageSize withDelegate:(ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo  withComBlock: ( void ( ^ )( NSString * ) )handler  withFailBlock: failBlock;

@end
