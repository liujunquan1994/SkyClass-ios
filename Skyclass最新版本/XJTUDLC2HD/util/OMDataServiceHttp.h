//
//  OMDataServiceHttp.h
//  LearningBar
//
//  Created by fenguo on 13-10-25.
//  Copyright (c) 2013年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMStaticContext.h"
#import "LBUserInfo.h"

@class ASIHTTPRequestDelegate;


@interface OMDataServiceHttp : NSObject


// 主题列表
+(void) getThemeList:(NSString *)token withuserID:(NSString *)userID withuserBaseId:(NSString *)userBaseID withstudentCode:(NSString *)studentCode withCategory:(NSString*) category  withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;


// 主题列表
+(void) getThemeList:(NSString *)token withuserID:(NSString *)userID withuserBaseId:(NSString *)userBaseID withstudentCode:(NSString *)studentCode withCategory:(NSString*) category withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
       withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate  withRequestUserinfo:(NSDictionary *)userInfo;

// 我关注的 主题列表
+(void) getThemeListByUserID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

// 我关注的 主题列表
+(void) getThemeListByUserID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate ;


//添加对主题的关注
+(void) addAttentionOfThemeByuserBaseID:(NSString *)userBaseID withThemeID:(NSString*)themeID
                           withDelegate: (ASIHTTPRequestDelegate *)httpDelegate  withRequestUserinfo:(NSDictionary *)userInfo;

//取消对主题的关注
+(void) cancleAttentionOfThemeByuserBaseID:(NSString *)userBaseID withThemeID:(NSString*)themeID
                              withDelegate: (ASIHTTPRequestDelegate *)httpDelegate  withRequestUserinfo:(NSDictionary *)userInfo;

//主题详情
+(void)getThemeDetailByThemeID:(NSString *)themeID withUserBaseID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//主题详情  url_get_themedetail_by_themeid_user
+(void)getThemeDetailByThemeIDUserID:(NSString *)themeID withUserBaseID:(NSString *)userBaseID
                        withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//主题的发言列表
+(void)getSpeakListByThemeID:(NSString *)themeID
            withOrderByField:(NSString *)orderByField
               withOrderType:(NSString *)orderType //按创建时间排序 0 不排序（默认），1升序 2降序
               withPageIndex:(NSString *)pageIndex
                withPageSize:(NSString *)pageSize
               withGreaterThanId:(NSString *)greaterThanId //获取最新的数据
                withLessThanId:(NSString *)lessThanId   //获取历史数据
                withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
         withRequestUserinfo:(NSDictionary *)userInfo;


//主题的发言列表 + 当前用户
+(void)getSpeakListByThemeID:(NSString *)themeID
            withOrderByField:(NSString *)orderByField
               withOrderType:(NSString *)orderType //按创建时间排序 0 不排序（默认），1升序 2降序
               withPageIndex:(NSString *)pageIndex
                withPageSize:(NSString *)pageSize
           withGreaterThanId:(NSString *)greaterThanId //获取最新的数据
              withLessThanId:(NSString *)lessThanId   //获取历史数据
                withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
         withRequestUserinfo:(NSDictionary *)userInfo
              withUserbaseID:(NSString *)userbaseID;


//参与发言
+(void)addSpeakContentByUserID:(NSString *)userID withThemeID:(NSString *)themeID withSpeakContent:(NSString *)speakContent
           withOriginalSpeakID:(NSString *)originalSpeakID withParentSpeakId:(NSString *)parentSpeakId withIsReplay:(NSString *)isReplay
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:requestUserinfo;

//发言条目详情
+(void)getSpeakDetailBySpeakID:(NSString *)speakID
                    withUserID:(NSString *)userID
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
           withRequestUserinfo:(NSDictionary *)userInfo;

//发言条目评论列表
+(void)getReviewListBySpeakID:(NSString *)speakID
             withOrderByField:(NSString *)orderByField
                withOrderType:(NSString *)orderType    //按创建时间排序 0 不排序（默认），1升序 2降序
                withPageIndex:(NSString *)pageIndex
                 withPageSize:(NSString *)pageSize
            withGreaterThanId:(NSString *)greaterThanId //获取最新的数据
               withLessThanId:(NSString *)lessThanId   //获取历史数据
                 withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
          withRequestUserinfo:(NSDictionary *)userInfo;


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
               withUserbaseID:(NSString *)userbaseID;



//删除发言
+(void)deleteSpeakBySpeakID:(NSString *)speakID
               withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
            withRequestUserinfo:(NSDictionary *)userInfo;

//删除发言
+(void)deleteSpeakBySpeakID:(NSString *)speakID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//赞发言
+(void)addSupportSpeakByUserID:(NSString *)userID
                   withSpeakID:(NSString *)speakID
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
           withRequestUserinfo:(NSDictionary *)userInfo;

//赞发言
+(void)addSupportSpeakByUserID:(NSString *)userID
               withStudentCode:(NSString *)studentCode
                   withSpeakID:(NSString *)speakID
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//收藏发言
+(void)addFavoriteSpeakByUserID:(NSString *)userID
                    withSpeakID:(NSString *)speakID
                   withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
            withRequestUserinfo:(NSDictionary *)userInfo;

//删除收藏发言
+(void)deleteFavoriteSpeakByUserID:(NSString *)userID
                       withSpeakID:(NSString *)speakID
                      withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
               withRequestUserinfo:(NSDictionary *)userInfo;

////10.96.142.93:17000/learnbar/collect/findFavoriteList.json?userBaseID=1982&orderType=2&PageIndex=1&PageSize=1
//我收藏的发言
+(void)myFavoritedSpeakListByUserBaseID:(NSString *)userBaseID
                          withOrderType:(NSString *)orderType    //按创建时间排序 0 不排序（默认），1升序 2降序
                          withPageIndex:(NSString *)pageIndex
                           withPageSize:(NSString *)pageSize
                   withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;


//添加发言评论
+(void)addReviewOfSpeakByUserID:(NSString *)userID
                    withSpeakID:(NSString *)speakID
                        withPid:(NSString *)pid  //上一级评论的 ID
                        withSid:(NSString *)sid  //该评论的 根 ID
              withReviewContent:(NSString *)reviewContent
                   withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
                withRequestUserinfo:(NSDictionary *)userInfo;

//回复评论
+(void)addRevertOfReviewByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withCommentPId:(NSString *)pID withCommentSId:(NSString *)sID withSpeakID:(NSString *)speakID withRevertContent:(NSString *)revertContent withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//发布个人主页（教师主页）
+(void)getThemeAuthorDetailByThemeAuthorID:(NSString *)themeAuthorID withUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//发布人的主题
+(void)getThemeListByAuthorID:(NSString *)themeAuthorID withuserBaseID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;



//用户禁言信息
+(void)getUserNoSpeakInfoByUserBaseID:(NSString *)userBaseID
                         withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
                  withRequestUserinfo:(NSDictionary *)userInfo;


//用户禁言信息
//+(void)getUserNoSpeakInfoByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;


//编辑发言
+(void)editSpeakContentByUserID:(NSString *)userID
                    withSpeakID:(NSString *)speakID
               withSpeakContent:(NSString *)speakContent
                   withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;


//编辑发言
+(void)editSpeakContentByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withThemeID:(NSString *)themeID withSpeakContent:(NSString *)speakContent withOriginalSpeakID:(NSString *)originalSpeakID withIsTranspond:(NSString *)isTranspond withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:requestUserinfo;

//编辑发言评论
+(void)editReviewOfSpeakByUserID:(NSString *)userID
                    withReviewID:(NSString *)reviewID
               withReviewContent:(NSString *)reviewContent
                    withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
             withRequestUserinfo:(NSDictionary *)userInfo;

//编辑发言评论
+(void)editReviewOfSpeakByUserID:(NSString *)userID withStudentCode:(NSString *)studentCode withSpeakID:(NSString *)speakID withReviewID:(NSString *)reviewID withReviewContent:(NSString *)reviewContent withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:requestUserinfo;

//我的发言
+(void)getSpeakListByUserID:(NSString *)UserID withPageNum:(NSString *)pageNum withPageSize:(NSString *)pageSize
        withcreateTimeOrder:(NSString *)createTimeOrder
          withgreaterThanId:(NSString *)greaterThanId
             withlessThanId:(NSString *)lessThanId
               withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//我d的评论
+(void)getCommentListByUserID:(NSString *)UserID withcreateTimeOrder:(NSString *)createTimeOrder withPageNum:(NSString *)pageNum withPageSize:(NSString *)pageSize withgreaterThanId:(NSString *)greaterThanId
               withlessThanId:(NSString *)lessThanId withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//我的赞
+(void)getFavorteListByUserID:(NSString *)UserID withPageNum:(NSString *)pageNum withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//添加好友
+(void)addFriendInfoReqUserID:(NSString *)UserID withFriendID:(NSString *)friendID withMyInfo:(NSString *)myInfo withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//好友个人主页
+(void)getHomePageInfoWithUserID:(NSString *)UserID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//删除评论
+(void)deleteReviewByUserID:(NSString *)UserID withReviewID:(NSString *)ReviewID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

//删除评论
+(void)deleteReviewByUserID:(NSString *)UserID withReviewID:(NSString *)ReviewID
               withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
        withRequestUserinfo:(NSDictionary *)userInfo;

//获取个人资料
+(void)getPersonalDetailInfowithUserID:(NSString *)UserID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//获取个人资料
+(void)getPersonalDetailInfowithUserID:(NSString *)UserID
                          withComBlock: ( void ( ^ )( NSString * ) )handler
                         withFailBlock: failBlock;



//修改名字
+(void)updateUserNamewithUserID:(NSString *)UserID
                   withUserName:(NSString *)userName
                   withComBlock: ( void ( ^ )( NSString * ) )handler
                  withFailBlock: failBlock;

//修改性别
+(void)updateUserSexwithUserID:(NSString *)UserID withUserSex:(NSString *)userSex withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//修改所在地
+(void)updateUserAddresswithUserID:(NSString *)UserID withUserPlace:(NSString *)userPlace withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//修改邮箱
+(void)updateUserEmailwithUserID:(NSString *)UserID withUserEmail:(NSString *)userEmail withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//修改手机号
+(void)updateUserPhoneNumberwithUserID:(NSString *)UserID withUserPhoneNum:(NSString *)userPhoneNum withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//修改简介
+(void)updateUserIntroducewithUserID:(NSString *)UserID withUserIntroduce:(NSString *)userIntro withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//修改头像
+(void)updateUserIconwithUserID:(NSString *)UserID withUserIconPath:(NSString *)iconPath withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//个人主页
+(void)getPersonalDetailwithUserID:(NSString *)UserID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;


//个人主页
+(void)getPersonalDetailwithUserID:(NSString *)UserID
                      withComBlock: ( void ( ^ )( NSString * ) )handler
                     withFailBlock: failBlock;


//提交积分
+(void)subMitPersonUserScore:(NSString *)UserID withScoreType:(NSString *)ScoreType withUserScore:(NSString *)UserScore withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
         withRequestUserinfo:(NSDictionary *)userInfo;
//得到积分
+(void)getPersonalUserScore:(NSString *)UserID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
        withRequestUserinfo:(NSDictionary *)userInfo;

//处理通过验证
+(void)setFriendRelationUserID:(NSString *)UserID withAskFirendID:(NSString *)askFriendID withisFriend:(NSString *)isFriend withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
           withRequestUserinfo:(NSDictionary *)userInfo;

//删除好友
+(void)deleteFriendRequestInfo:(NSString *)UserID withFriendID:(NSString *)friendID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
           withRequestUserinfo:(NSDictionary *)userInfo;

//添加好友
+(void)addFriendRequestInfo:(NSString *)userID withFriendID:(NSString *)friendID wirhMyInfo:(NSString *)myInfo withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
        withRequestUserinfo:(NSDictionary *)userInfo;

//获取好友个人信息
+(void)getFriendDetailByUserId:(NSString *)userID withFriendID:(NSString *)friendID
                  withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
           withRequestUserinfo:(NSDictionary *)userInfo;

//获取好友按姓名
+(void)getFriendListByName:(NSString *)userName withorderByField:(NSString *)orderByField withcreateTimeOrder:(NSString *)createTimeOrder withpageNumber:(NSString *)pageNumber withpageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
withRequestUserinfo:(NSDictionary *)userInfo;

//获取当前用户的好友列表
+(void)getFriendListByUserId:(NSString *)UserID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
         withRequestUserinfo:(NSDictionary *)userInfo;

//获取未读消息
+(void)getNewMessge:(NSString *)user withPageSize:(NSString *)pageSize withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
withRequestUserinfo:(NSDictionary *)userInfo;

//发送文本消息
+(void)sendMessage:(NSString *)fromUser withtoUser:(NSString *)toUser withcontent:(NSString *)content withcheckTime:(NSString *)checkTime withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
withRequestUserinfo:(NSDictionary *)userInfo;

//发送文件
+(void)sendFile:(NSString *)fromUser withtoUser:(NSString *)toUser withcheckTime:(NSString *)checkTime withFilePath:(NSString *)filePath withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
withRequestUserinfo:(NSDictionary *)userInfo;

//后台系统（OBS） 的登录接口，老马 那边 的基础服务系统；
+(void)loginOBS:(NSString *)userName withPassward:(NSString *)passward
   withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

//后台系统（OBS） 的登录接口，老马 那边 的基础服务系统；
+(void)loginOBSWithBlock:(NSString *)userName withPassward:(NSString *)passward
   withComBlock: ( void ( ^ )( NSString * ) )handler
  withFailBlock: failBlock;


//添加访问记录
+(void)addFriendVisitRecord:(NSString*)friendBaseId withUserBaseID:(NSString *)userBaseID withDelegate: (ASIHTTPRequestDelegate *)httpDelegate
        withRequestUserinfo:(NSDictionary *)userInfo;



/////////////////////////以 下 是与通讯录有关的接口；
//上传通讯录
+(void)sendContacts:(NSString*)contacts withDelegate: (ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;


//绑定手机号
+(void)bandPhoneNumberwithUserID:(NSString *)UserBaseID withPhoneNumber:(NSString *)phoneNumber
                    withComBlock: ( void ( ^ )( NSString * ) )handler
                   withFailBlock: failBlock;

//得到 当前用户 与 通讯录中的朋友的关系的状态；
+(void)getRelationOfUserAndContacterWithPhoneNumber:(NSString *)phoneNumber
                                       withComBlock: ( void ( ^ )( NSString * ) )handler
                                      withFailBlock: failBlock;

//得到 当前用户 使用 本app时的地理位置；
+(void)saveCurrentGPSWithUserBaseID:(NSString *)userBaseID withLatitude:(NSString *)latitude withLongitude:(NSString *)longitude withAddress:(NSString *)address
                       withComBlock: ( void ( ^ )( NSString * ) )handler
                      withFailBlock: failBlock;

+(void)saveCurrentGPSWithPostDataString:(NSString *)postData
                           withComBlock: ( void ( ^ )( NSString * ) )handler
                          withFailBlock: failBlock;


//获取设备的ID，该ID是在 服务端记录的，通过 设备的唯一标识 来获取的；
+(void)getDeviceDBIDWithDeviceInfo:(NSString*)deviceInfo 
                      withComBlock: ( void ( ^ )( NSString * ) )handler
                     withFailBlock: failBlock;
/////////////////////////以 上 是与通讯录有关的接口；

+(void)sendTerminalBigData:(NSString*)requestPrara withDelegate: (ASIHTTPRequestDelegate *)httpDelegate;

// 获取主题分类
+(void)getThemeCategory:(ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;


// 获取推荐主题
+(void)getRecommendThemeList:(NSString*)recommend withDelegate:(ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;

// 获取推荐主题
+(void)getRecommendThemeListBlock:(NSString*)recommend  withComBlock: ( void ( ^ )( NSString * ) )handler  withFailBlock: failBlock;

// 获取版本更新
+(void)getVersionUpdateInfo:(ASIHTTPRequestDelegate *)httpDelegate withRequestUserinfo:(NSDictionary *)userInfo;



//绑定手机号
+(void)getThemeList:(NSString *)token withuserID:(NSString *)userID withuserBaseId:(NSString *)userBaseID withstudentCode:(NSString *)studentCode withCategory:(NSString*) category withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
      withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
       withComBlock: ( void ( ^ )( NSString * ) )handler
      withFailBlock: failBlock;



//绑定手机号
+(void)getThemeRecomendList:(NSString *)token withuserID:(NSString *)userID withuserBaseId:(NSString *)userBaseID withstudentCode:(NSString *)studentCode withCategory:(NSString*) category withOrderByType:(NSString *)orderByType withOrderType:(NSString *)orderType
              withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize                    withComBlock: ( void ( ^ )( NSString * ) )handler
              withFailBlock: failBlock;


//绑定手机号
+(void)getThemeListByUserID:(NSString *)userBaseID withComBlock: ( void ( ^ )( NSString * ) )handler  withFailBlock: failBlock;


+(void)getVersionUpdateInfoWithBlock:( void ( ^ )( NSString * ) )handler
                       withFailBlock: failBlock;

// 获取主题分类
+(void)getThemeCategoryBlock:( void ( ^ )( NSString * ) )handler
               withFailBlock: failBlock;

+(void)subMitPersonUserScoreWithBlock:(NSString *)UserID withScoreType:(NSString *)ScoreType withUserScore:(NSString *)UserScore  withComBlock: ( void ( ^ )( NSString * ) )handler
                        withFailBlock: failBlock;



@end
