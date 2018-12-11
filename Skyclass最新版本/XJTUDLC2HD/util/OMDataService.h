//
//  OTDataService.h
//  MeosTrain
//
//  Created by fenguo on 13-5-31.
//  Copyright (c) 2013年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMStaticContext.h"
//#import "../userLogin/LBUserInfo.h"
//#import "LBAppDelegate.h"

@class ASIHTTPRequestDelegate;


@interface OMDataService : NSObject

// 注册
+(void)registerUser:(NSDictionary*)userinfo withUserName:(NSString *)userName withPassword: (NSString *)password withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//登录
+ (void) loginUserName: (NSString *)userName withPassword: (NSString *)password withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;


+(void)loginUserWithBlock:(NSString*)userName withPassword:(NSString*)password withComBlock: ( void ( ^ )( NSString * ) )handler
   withFailBlock: failBlock;



+(void)getOpenCourseVideoList:(NSString*) category withPageNumber:(NSString*)pageNumber withPageSize:(NSString*)pageSize withDelegate:(ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo;

// 公开课
+(void)getOpenCourseVideoListWithBlock:(NSString *)category withPageNumber:(NSString *)pageNumber withPageSize:(NSString *)pageSize withDelegate:(ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo  withComBlock: ( void ( ^ )( NSString * ) )handler  withFailBlock: failBlock;

//我的课程
+(void) getMyCourseListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode
                 withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
                   withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
                    withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo;




//我的课程
+(void) getMyCourseListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode
                 withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
                   withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
                    withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo withComBlock: ( void ( ^ )( NSString * ) )handler
                   withFailBlock: failBlock;




//获取课程的评测列表
+(void) getCourseExamTaskListForUserIDBlock:(NSString *)userID withStudentCode:(NSString *)studentCode
                          withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType
                         withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
                          withComBlock: ( void ( ^ )( NSString * ) )handler  withFailBlock: failBlock;;

//用户的课程的视频
+(void) getCourseVideoListForUserIDBlock:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID
                    withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex
                       withPageSize:(NSString *)pageSize
                       withComBlock: ( void ( ^ )( NSString * ) )handler  withFailBlock: failBlock;;

//获取 PDF 文档
+(void) getCourseDocPDFListForUserIDBlock:(NSString *)userID withStudentCode:(NSString *)studentCode
                        withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType
                       withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
                        withComBlock: ( void ( ^ )( NSString * ) )handler  withFailBlock: failBlock;;

//用户的课程的 PDF 公告
+(void) getCourseNoticePDFListForUserIDBlock:(NSString *)userID withStudentCode:(NSString *)studentCode
                           withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType
                          withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex
                           withPageSize:(NSString *)pageSize
                           withComBlock: ( void ( ^ )( NSString * ) )handler  withFailBlock: failBlock;;




//获取课程的评测列表
+(void) getCourseExamTaskListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode
                          withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType
                         withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
                          withDelegate: (ASIHTTPRequestDelegate *)httpDelegate  withUserinfo:(NSDictionary *)userinfo;

//用户的课程的视频
+(void) getCourseVideoListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID
                    withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex
                       withPageSize:(NSString *)pageSize
                       withDelegate: (ASIHTTPRequestDelegate *)httpDelegate  withUserinfo:(NSDictionary *)userinfo;

//获取 PDF 文档
+(void) getCourseDocPDFListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode
                        withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType
                       withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
                        withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo;

//用户的课程的 PDF 公告
+(void) getCourseNoticePDFListForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode
                           withCourseID:(NSString *)courseID withOrderByType:(NSString *)orderByType
                          withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex
                           withPageSize:(NSString *)pageSize
                           withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo;


//获取单个评测评测作业
+(void) GetCourseExamTaskForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withExamTaskID:(NSString *)examTaskID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo;

//更新课件状态（是否已为New）
+(void) setCoursewareStudyStatusForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withCoursewareID:(NSString *)coursewareID withCoursewareType:(NSString *)coursewareType withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//保存视频文档学习位置（断点续学保留接口）
+(void) setCoursewareStudyPointForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withCoursewareID:(NSString *)coursewareID withCoursewareType:(NSString *)coursewareType withCoursePoint:(NSString *)coursePoint withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//获取评测试题内容
+(void) getCourseExamTaskItemForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withExamItemID:(NSString *)examItemID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo;

//保存(未完成试题)   保存(未完成试题)saveUnFinishExamTaskResult
+(void) saveUnFinishExamTaskResultForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withExamTaskID:(NSString *)examTaskID withAnswerData:(NSString *)AnswerData withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo;

//交卷(完成试题)
+(void) submitObjectiveExamResultForUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCourseID:(NSString *)courseID withExamTaskID:(NSString *)examTaskID withAnswerData:(NSString *)AnswerData withObjectiveScore:(NSString *)objectiveScore withState:(NSString *)state withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withUserinfo:(NSDictionary *)userinfo;

//用户反馈  AddUserFeedback
+(void) addUserFeedbackForUserID:(NSString *)userID
             withFeedbackContent:(NSString *)feedbackContent
                   withUserEmail:(NSString *)userEmail
                    withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
                    withUserinfo:(NSDictionary *)userinfo;


// 主题列表
+(void) getThemeList:(NSString *)userBaseID withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

// 我关注的 主题列表
+(void) getThemeListByUserID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//添加对主题的关注
+(void) addAttentionOfThemeByuserBaseID:(NSString *)userBaseID withThemeID:(NSString*)themeID
                           withDelegate: (ASIHTTPRequestDelegate *)httpDelegate  withRequestUserinfo:(NSDictionary *)userInfo;

//取消对主题的关注
+(void) cancleAttentionOfThemeByuserBaseID:(NSString *)userBaseID withThemeID:(NSString*)themeID
                          withDelegate: (ASIHTTPRequestDelegate *)httpDelegate  withRequestUserinfo:(NSDictionary *)userInfo;

//主题详情
+(void)getThemeDetailByThemeID:(NSString *)themeID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//主题的发言列表
+(void)getSpeakListByThemeID:(NSString *)themeID withOrderByField:(NSString *)orderByField withOrderType:(NSString *)orederType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//参与发言
+(void)addSpeakContentByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withThemeID:(NSString *)themeID withSpeakContent:(NSString *)speakContent withOriginalSpeakID:(NSString *)originalSpeakID withIsTranspond:(NSString *)isTranspond withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//发言条目详情
+(void)getSpeakDetailBySpeakID:(NSString *)speakID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//发言条目评价列表
+(void)getReviewListBySpeakID:(NSString *)speakID withOrderByField:(NSString *)orderByField withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//删除发言
+(void)deleteSpeakBySpeakID:(NSString *)speakID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//赞发言
+(void)addSupportSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//收藏发言
+(void)addFavoriteSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//删除收藏发言
+(void)deleteFavoriteSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//添加发言评论
+(void)addReviewOfSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withReviewContent:(NSString *)reviewContent withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//回复评论
+(void)addRevertOfReviewByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withReviewID:(NSString *)reviewID withRevertContent:(NSString *)revertContent withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//发布个人主页（教师主页）
+(void)getThemeAuthorDetailByThemeAuthorID:(NSString *)themeAuthorID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//发布人的主题
+(void)getThemeListByAuthorID:(NSString *)themeAuthorID withuserBaseID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//我的发言
+(void)getSpeakListByUserID:(NSString *)UserID withStudentCode:(NSString *)studentCode withOrderByField:(NSString *)orderByField withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//用户禁言信息
+(void)getUserNoSpeakInfoByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//编辑发言
+(void)editSpeakContentByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withThemeID:(NSString *)themeID withSpeakContent:(NSString *)speakContent withOriginalSpeakID:(NSString *)originalSpeakID withIsTranspond:(NSString *)isTranspond withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//编辑发言评论
+(void)editReviewOfSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withReviewID:(NSString *)reviewID withReviewContent:(NSString *)reviewContent withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//获取教务公告列表
+(void)getEducationNoticeListByUserID:(NSString *)userID
                      withStudentCode:(NSString *)studentCode
                      withOrderByType:(NSString *)orderByType
                        withOrderType:(NSString *)orderType
                        withPageIndex:(NSString *)pageIndex
                         withPageSize:(NSString *)pageSize
                         withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//获取教务公告详情
+(void)getEducationNoticeDetailByUserID:(NSString *)userID
                      withStudentCode:(NSString *)studentCode
                         withEducationNoticeID:(NSString *)educationNoticeID
                         withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//
/* OES 积分 在线时长积分规则
"url_add_user_total_time_action"="AddOBUserCourseTotalTime";
 OES 积分 课件点击积分规则
"url_add_user_course_click_time_action"="AddOBUserCourseClickTime";*/

//OES 积分 在线时长积分规则
+(void)addOBUserCourseTotalTimeWithUserID:(NSString *)userID
                      withCourseID:(NSString *)CourseID
                      withTotalTime:(NSString *)TotalTime
                         withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//OES 积分 课件点击积分规则
+(void)addOBUserCourseClickTimeWithUserID:(NSString *)userID
                      withStudentCode:(NSString *)studentCode
                        withCourseID:(NSString *)CourseID
                    withCourseWareID:(NSString *)CourseWareID
                      withLoadDate:(NSString *)loadDate
                        withUnloadDate:(NSString *)unloadDate
                         withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//同专业的好友列表
+(void)getFriendListBySameSpecialty:(NSString *)UserID withstudentCode:(NSString *)studentCode withuserType:(NSString *)userType withorderByField:(NSString *)orderByField withorderType:(NSString *)orderType withpageIndex:(NSString *)pageIndex withpageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
                withRequestUserinfo:(NSDictionary *)userInfo  withComBlock: ( void ( ^ )( NSString * ) )handler
                      withFailBlock: failBlock;

//
+(void) sendAsyncHttpPostRequestss:(NSString *)urlService withAction:(NSString *)action withActionName:(NSString *)actionName
                 withParameterNote:(NSString *)parameterNote withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
               withRequestUserInfo:(NSDictionary *)userInfo  withComBlock: ( void ( ^ )( NSString * ) )handler
                     withFailBlock: failBlock;

+(void)addOBUserCourseClickTimeWithUserIDWithBlock:(NSString *)userID
                                   withStudentCode:(NSString *)studentCode
                                      withCourseID:(NSString *)CourseID
                                  withCourseWareID:(NSString *)CourseWareID
                                      withLoadDate:(NSString *)loadDate
                                    withUnloadDate:(NSString *)unloadDate
                                      withComBlock: ( void ( ^ )( NSString * ) )handler
                                     withFailBlock: failBlock;

// 获取主题分类
+(void)getThemeCategoryList:(NSString*)userID withType:(NSString*)userType withToken:(NSString*) token withDelegate:(ASIHTTPRequestDelegate *)httpDelegate;


@end
