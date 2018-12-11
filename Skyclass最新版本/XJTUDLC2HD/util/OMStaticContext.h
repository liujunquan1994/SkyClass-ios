//
//  OMStaticContext.h
//  meos-i
//
//  Created by mason ma on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define APPDELEGATE (LBAppDelegate *)[[UIApplication sharedApplication] delegate]

#define GETUSER_INFO ((LBAppDelegate *)[[UIApplication sharedApplication] delegate]).userInfo

//人气
#define POPULARITY @"Moods"
//价格
#define PRICE @"Price"
//销量
#define  TOTALSALESCOUNT @"TotalSalesCount"
//周销量
#define WEEK_SALES @"WeekSalesCount"
//月销量
#define MONTH_SALES @"MonthSalesCount"
//收藏数量
#define FAVORITE_COUNT @"FavoriteCount"
//产品
#define PRODUCT @"Product"
//产品名称
#define PRODUCT_NAME @"ProductName"
//收藏日期
#define FAVORITE_DATE @"FavoriteCreatedDate"
//店铺名称
#define STORE_NAME @"StoreName"
//店铺信用
#define STORE_CREDIT @"SellerGradeCode"
//创建时间
#define CREATE_DATE @"CreatedDate"
//产品数量
#define PRODUCT_COUNT @"GoodsCount"
//总金额
#define TOTALAMOUNT @"TotalAmount"
//状态
#define STATUS @"Status"


#define DESC @"Desc"
//升序
#define ASC @"asc"




//默认的 分页数量
#define PAGESIZE 15
//文本框默认的 可以输入的字符数量
#define SPEAK_WORD_SIZE 140

//搜索框中 默认可以 输入的字符的数量
#define SEARCH_BAR_TEXT_MAX_SIZE 20
//searchBar的默认高度
#define SEARCH_BAR_HEIGHT 50

//
typedef enum{
    COURSE_SHARE,
    APP_SHARE
}SHARE_TYPE;


//
typedef enum{
    USERTYPE_STUDENT=1,
    USERTYPE_TEACHER=2,
    USERTYPE_COMMON=3
}USER_TYPE;


//
typedef enum{
    MESSAGE_FRIEND_LIST_TYPE_SEND_MESSAGE,     //选择好友，到聊天界面；
    MESSAGE_FRIEND_LIST_TYPE_HOME_PAGE       //查找好友，到好友的 个人主页；
}MESSAGE_FRIEND_LIST_TYPE;


typedef enum{
    WATCH_VIDEO_ONLINE,     //在线观看课件（视频）；
    WATCH_VIDEO_LOCAL       //离线观看课件（视频）；
}WATCH_VIDEO_TYPE;


typedef enum{
    SPEAK_STATU_LOGICAL_DELETE=1,     //逻辑删除
    SPEAK_STATU_OPEN=2,     //开放
    SPEAK_STATU_BE_WAITED_CHECK=3,     //待审核
    SPEAK_STATU_OTHER_USER_NOT_SEE=4     //屏蔽
}SPEAK_STATA;


// 评论状态
typedef enum{
   COMMENT_STATU_DELETE=9,     //逻辑删除
   COMMENT_STATU_OPEN=2,     //开放
   COMMENT_STATU_AUDIT=3,     //待审核
   COMMENT_STATU_LOCK_AUDIT=6,     //审核锁定
   COMMENT_STATU_LOCK_BLOCK=7, // 屏蔽锁定
   COMMENT_STATU_BLOCK=4,   // 屏蔽
   COMMENT_STATU_COLSE=5,   // 关闭
}COMMENT_STATA;

//发言状态
typedef enum{
   SPEAK_STATE_DELETE=9,     //逻辑删除
   SPEAK_STATE_OPEN=2,     //开放
   SPEAK_STATE_AUDIT=3,     //待审核
   SPEAK_STATE_LOCK_AUDIT=6,     //审核锁定
   SPEAK_STATE_LOCK_BLOCK=7, // 屏蔽锁定
   SPEAK_STATE_BLOCK=4,   // 屏蔽
   SPEAK_STATE_COLSE=5,   // 关闭
}SPEAK_STATE;


//
typedef enum{
    SPEAK_TYPE_ORIGINAL,    //原始发言
    SPEAK_TYPE_TRANSPOND,   //转发他人的发言
    SPEAK_TYPE_REVIEW,  //评论他人的 发言
    SPEAK_TYPE_REVIEW_OF_REVIEW ,    //回复他人的 评论
    SPEAK_TYPE_EDIT_SPRAK,   //编辑发言
    SPEAK_TYPE_EDIT_REVIEW   //编辑 评论
}SPEAK_TYPE;

/*
 //消息类型
 // 1（系统相关）
 // 2（私信相关）
 // 3（发言相关）
 // 4（评论相关）
 // 5（好友相关）
 int type=0; >>>>> messageType
 //消息编码
 // （系统相关）1  系统通知 2系统消息
 // （私信相关）20 文本 21 语音 22 视频 23图片
 // （发言相关）40 待审核发言（转发） 41 屏蔽发言（转发）
 // （评论相关）60 待审核评论（回复） 61 屏蔽评论（回复）
 // （好友相关）80 接收到好友申请  81 好友验证通过 82 好友验证不通过
 int code=0;  >>>>>>>>messageCode
 */
typedef enum{
    MESSAGE_TYPE_SYSTEM_MESSAGE=1,
    MESSAGE_TYPE_FRIEND_MESSAGE,
    MESSAGE_TYPE_SPEAK_MESSAGE,
    MESSAGE_TYPE_REVIEW_MESSAGE,
    MESSAGE_TYPE_GOOD_FRIEND_MESSAGE
}MESSAGE_TYPE;

typedef enum{
    MESSAGE_CODE_SYSTEM_NOTICE=1,
    MESSAGE_CODE_SYSTEM_MESSAGE=2,
    MESSAGE_CODE_FRIEND_MESSAGE_TEXT_TYPE=20,
    MESSAGE_CODE_FRIEND_MESSAGE_AUDIO_TYPE=21,
    MESSAGE_CODE_FRIEND_MESSAGE_VIDEO_TYPE=22,
    MESSAGE_CODE_FRIEND_MESSAGE_PICTURRE_TYPE=23,
    MESSAGE_CODE_SPEAK_MESSAGE_WAIT_CHECK=40,
    MESSAGE_CODE_SPEAK_MESSAGE_BE_SHIELDED=41,
    MESSAGE_CODE_REVIEW_MESSAGE_WAIT_CHECK=60,
    MESSAGE_CODE_REVIEW_MESSAGE_BE_SHIELDED=61,
    MESSAGE_CODE_GOOD_FRIEND_ADD_REQUEST=80,
    MESSAGE_CODE_GOOD_FRIEND_ADD_PASSED=81,
    MESSAGE_CODE_GOOD_FRIEND_ADD_NOT_PASSED=82
}MESSAGE_CODE;


//
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
//
#define currentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]


//屏幕的高度
#define mainScreenHeight (int)[UIScreen mainScreen].bounds.size.height
#define mainScreenSize [UIScreen mainScreen].bounds.size

//Log当前方法名
#define LOG_METHOD NSLog(@"%@:   %@", NSStringFromSelector(_cmd), self)

//导航条上分配按钮
#define BARBUTTON(TITLE, SELECTOR) [[[UIBarButtonItem alloc] initWithTitle: TITLE style: UIBarButtonItemStylePlain target: self action: SELECTOR] autorelease]


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//导航按钮色
#define kBarItemColor UIColorFromRGB(0x793D26)

//奇数格子背景
#define kLightCellColor UIColorFromRGB(0xD4C6A2)
//偶数数格子背景
#define kDepthCellColor UIColorFromRGB(0xE3D8BD)
//分段控件颜色
#define kSegmentColor UIColorFromRGB(0x521A0E)
//格子底部分割线背景
#define kCellBottomColor UIColorFromRGB(0x978E7E)
//格子大字的颜色
#define kCellFont1Color UIColorFromRGB(0x572C1B)
//格子选中时背景
#define kCellSelectedColor UIColorFromRGB(0xB0D374)
//描边颜色
#define kStrokeColor UIColorFromRGB(0x543E14)

#define kGraffitiDefaultColor UIColorFromRGB(0x4F870D)

/**
 更多应用
 */

//快报详情页面标题区域
#define helpDetailTitieAreaColor UIColorFromRGB(0x643a24)
//快报详情文本字体颜色
#define helpDetailContentFontColor UIColorFromRGB(0x552d1a)
//快报详情标题
#define helpDetailTitleFontColor UIColorFromRGB(0xa30000)
//试题背景挡板颜色
#define stuQuestionBgColor UIColorFromRGB(0x562F1C)
#define stuQuestionTextColor UIColorFromRGB(0xEECD62)
#define stuQuestionStrokeColor UIColorFromRGB(0x61402C)


//控件中，字体默认颜色——白色；字体选中颜色——橙色
#define commonFontDefaultColor UIColorFromRGB(0xFFFFFF);
#define commonFontSelectedColor UIColorFromRGB(0xF6B45A);


#define kIntVal(dict, key) ((NSString *)[dict objectForKey:key]).intValue

#define locale(key) NSLocalizedString(key,nil)

#define kSetDdjBg  ((UIImageView *)self.view).image = [UIImage imageNamed:@"bg1Ddj.png"];

#define kSetWoodBg  ((UIImageView *)self.view).image = [UIImage imageFromDiskNamed:@"Register-view-background.png"];


#define urlStringMinLenght 8

// 主题列表中的按钮 “关注”字体颜色
#define discussButtonTextColorNormal [UIColor colorWithHexString:@"#666666" withAlpha:1]

//
#define tabBarTextColorSelected [UIColor colorWithHexString:@"#33B5E5" withAlpha:1]
#define tabBarTextColorUnSelected [UIColor colorWithHexString:@"#ffffff" withAlpha:1]
//
#define courseItemTitleLabelTextColor [UIColor colorWithHexString:@"#333333" withAlpha:1]
#define courseItemDescriptionLabelTextColor [UIColor colorWithHexString:@"#999999" withAlpha:1]
//
#define courseItemListTableCellSelectedBackGround [cell setSelectedBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSelectedBackground.png"]]]


//
#define LIST_SUBVIEWS(view)\
{\
    NSArray *subviews = [view subviews];\
    if ([subviews count] == 0) return;\
    for (UIView *subview in subviews) {\
//NSLog(@"subview class is =============%@", NSStringFromClass([subview class]));\
    }\
}


//
#define NAVIGATION_BAR_SHADOW_TAG_OF_OPENCOURSE 100005
#define NAVIGATION_BAR_SHADOW_TAG_OF_COURSE 100001
#define NAVIGATION_BAR_SHADOW_TAG_OF_DISCUSSGROUP 100002
#define NAVIGATION_BAR_SHADOW_TAG_OF_FRIENDMESSAGE 100003
#define NAVIGATION_BAR_SHADOW_TAG_OF_MYSELF 100004

//
#define NAVIGATION_BAR_BUTTON_FONT_SIZE 19
#define NAVIGATION_BAR_TITLE_FONT_SIZE 19

// 同时下载的数量
#define MAX_DOWNLOAD_COUNT 1

//课件 资源类型
typedef enum{
    RESOURCE_TYPE_VIDEO=1,
    RESOURCE_TYPE_DOC,
    RESOURCE_TYPE_NOTICE
}RESOURCE_TYPE;

//
//Rid 本地数据库的主键
#define RID @"rid"
//
#define USER_ID @"userID"
//资源ID
#define RESOURCE_ID @"resourceID"
//资源URL
#define RESOURCE_URL @"resourceUrl"
//资源类型
#define RESOURCE_STYLE @"resourceStyle"
//学生课程ID
#define STUDENT_COURSEID @"studentCourseID"
//课程名称
#define COURSE_NAME @"courseName"
//资源名称
#define RESOURCE_NAME @"resourceName"
//
#define PAGECOUNT @"pageCount"
//
#define ALREAD_SIZE @"alreadSize"
//
#define DOWNLOAD_STATUS @"status"
//
#define FILE_SIZE @"fileSize"
//
#define PAGE_ALREAD_SIZE @"pageAlreadSize"
//
#define PAGE_FILE_SIZE @"pageFileSize"
//
#define LOCALPATH @"localPath"
//
#define CREATEDATE @"createDate"
//
#define RESOURCE_PAGE_ID @"resourcePageID"
//
#define START_PLAY_TIME @"startPlayTime"
//
#define SHOW_FILE_SIZE @"showFileSize"

#define VIDEO_TYPE_OPEN @"openVideo"

#define VIDEO_TYPE_COURSE @"courseVideo"

//在同一个页面中，有多个请求时，区分不同的 请求。
#define REQUEST_TYPE @"requestType"
#define REQUEST_TYPE_DELETE_SPEAK_BY_MYSELF @"requestTypeDeleteSpeakByMyself"
#define REQUEST_TYPE_DELETE_REVIEW_BY_MYSELF @"requestTypeDeleteReviewByMyself"
#define REQUEST_TYPE_THEME_LIST @"requestThemeList"
#define REQUEST_TYPE_ATTENTION @"requestAttention"
#define REQUEST_TYPE_CANCEL_ATTENTION @"requestCancelAttention"
#define REQUEST_TYPE_THEME_DETAIL @"requestThemeDetail"
#define REQUEST_TYPE_THEME_SPEAK_LIST @"requestThemeSpeakList"
#define REQUEST_TYPE_THEME_SPEAK_REVIEW_LIST @"requestThemeSpeakReviewList"
#define REQUEST_TYPE_THEME_SPEAK_REVIEW_LIST_NEWDATA @"requestThemeSpeakReviewListNewData"
#define REQUEST_TYPE_THEME_SPEAK_REVIEW_LIST_OLDDATA @"requestThemeSpeakReviewListOldData"
#define REQUEST_TYPE_LIST_DATA_TYPE @"requestTypeListDataType"
#define REQUEST_TYPE_THEME_SPEAK_LIST_NEW_DATA @"requestThemeSpeakListNewData"
#define REQUEST_TYPE_THEME_SPEAK_LIST_OLD_DATA @"requestThemeSpeakListOldData"
#define REQUEST_TYPE_ADD_REVIEW @"requestTypeAddReview"
#define REQUEST_TYPE_EDIT_SPEAK @"requestTypeEditSpeak"
#define REQUEST_TYPE_SPEAK_DETAIL @"requestTypeSpeakDetail"
#define REQUEST_TYPE_SUPPORT_SPEAK @"requestTypeSupportSpeak"
#define REQUEST_TYPE_SPEAK_ADD_FAVORITE @"requestTypeSpeakAddFavorite"
#define REQUEST_TYPE_SPEAK_DELETE_FAVORITE @"requestTypeSpeakDeleteFavorite"
#define REQUEST_TYPE_GET_NOT_SPEAK_INFO @"requestTypeGetNotSpeakInfo"
//LBCoursesViewController
#define REQUEST_TYPE_COURSE_VIEW_CONTROLLER @"requestTypeLBCoursesViewController"
//REQUEST_TYPE_ADD_FEED_BACK
#define REQUEST_TYPE_ADD_FEED_BACK @"requestTypeAddUserFeedBack"
//LBExamTaskListViewController
#define REQUEST_TYPE_EXAM_TASK_LIST_CONTROLLER @"requestTypeLBExamTaskListViewController"
#define REQUEST_TYPE_LOGIN_OBS @"longin_obs"
//
#define REQUEST_TYPE_REGISTER @"registerUser"

#define REQUEST_EXAM_TASK_CONTROLLER @"requestTyoeExamTaskController"
#define REQUEST_SUBMIT_OBJECT_EXAMRESULT @"submitObjectiveExamResult"
#define REQUEST_SAVE_FINISH_EXAMRESULT @"saveUnFinishExamTaskResultForUserID"
#define REQUEST_GETEXAM_TASK_ITEM_FORUSER @"getCourseExamTaskItemForUserID"
#define REQUEST_GETTHEME_AUTHORDETAIL_BYTHEME @"getThemeAuthorDetailByThemeAuthorID"
#define REQUEST_GETTHEME_LIST_BYAUTHORID @"SPEAK"

#define REQUEST_ADDFRIEND_INFOREQUEST @"addFriendInfoReqUserID"
#define REQUEST_EDIT_SPEAKCONTENT_USERID @"editSpeakContentByUserID"
#define  REQUEST_ADDREVIEW_SPEAK_USERID @"addReviewOfSpeakByUserID"
#define REQUEST_ADDSPEAK_CONTENT_USERID @"addSpeakContentByUserID"
#define REQUEST_ADDREVIEW_OFSPEAK_USERID @"addReviewOfSpeakByUserIDSS"
#define REQUEST_EDITREVIEW_OFSPEAK_USERID @"editReviewOfSpeakByUserID"
#define REQUEST_ADDREVERT_OFREVIEW_USERID @"addRevertOfReviewByUserID"
#define REQUEST_ADDSUPPORT_SPEAK_USERID @"addSupportSpeakByUserID"
#define REQUEST_DELETE_SPEAK_SPEAKID @"deleteSpeakBySpeakID"
#define REQUEST_GETSPEAK_LIST_SPEAKID @"getSpeakListByUserID"
#define REQUEST_DELETE_REVIEW_BYUSERID @"deleteReviewByUserID"
#define REQUEST_GETCOMMENT_LIST_BYUSERID @"getCommentListByUserID"
#define REQUEST_GETFAVORTELIST_USERID @"getFavorteListByUserID"

#define REQUEST_GETPERSON_USERSCORE @"getPersonalUserScore"
#define REQUEST_GETPERSON_TEACBERSCORE @"getPersonalTeacherScore"
#define REQUEST_GETPERSONAL_DETAILINFO @"getPersonalDetailInfowithUserID"

#define REQUEST_UPDATA_USERNAME @"updateUserNamewithUserID"
#define REQUEST_UPDATA_USEREMAIL @"updateUserEmailwithUserID"
#define REQUEST_UPDATA_USERPHONENUM @"updateUserPhoneNumberwithUserID"
#define REQUEST_UPDATA_USERINTRODUCE @"updateUserIntroducewithUserID"
#define REQUEST_UPDATA_USERSEX @"updateUserSexwithUserID"
#define REQUEST_UPDATA_USERADDRESS @"updateUserAddresswithUserID"
#define REQUEST_GETPERSONAL_DETAIL_WITHUSERID @"getPersonalDetailwithUserID"
#define REQUEST_UPDATA_USERICON @"updateUserIconwithUserID"


#define REQUEST_GETFRIENDLIST_USERID @"getFriendListByUserId"
#define REQUESTGET_FIRENDLIST_SAMESPECIALTY @"getFriendListBySameSpecialty"
#define REQUEST_GETFRIENDLIST_BYNAM @"LBSearchFirendResultViewController"
#define REQUEST_FRIEND_HOMEPAGE @"LBFriendHomepageViewController"
#define REQUEST_GETSPEAKLIET_HOMEPAGE @"getSpeakListByUserIDhome"
#define REQUEST_ADDSUPPORT_SPEAK_USERIDSS @"addSupportSpeakByUserIDSS"
#define REQUEST_ADDFRIEND_INFOREQUESTSS @"addFriendInfoReqUserIDSS"
#define REQUEST_FRIENDS_FRIENDLIST @"LBFriendisFriendsViewController"
#define REQUEST_FRIEND_AGREEREQUEST @"LBHandleVerificationViewController"
#define REQUEST_FRIEND_DISAGREEREQUEST @"DisLBHandleVerificationViewController"
#define REQUEST_DELETE_FIRENDIFOREQUEST @"deleteFriendRequestInfo"
#define REQUEST_ADDVISIT_RECORD @"addFriendVisitRecord"
#define REQUEST_VERSION_INFO @"getVersionUpdateInfo"

//Mqtt messageDictionary key
#define MQTT_MESSAGE_KEY_SMID @"messageSMID"
#define MQTT_MESSAGE_KEY_TYPE @"messageType"
#define MQTT_MESSAGE_KEY_CODE @"messageCode"

#define MQTT_MESSAGE_KEY_IS_READ @"messageIsRead"
#define MQTT_MESSAGE_KEY_CONTENT @"messageContent"
#define MQTT_MESSAGE_KEY_SEND_DATE_TIME @"messageSendDateTime"

#define MQTT_MESSAGE_KEY_RECEIVE_DATE_TIME @"messageReceiveDateTime"
#define MQTT_MESSAGE_KEY_RESOURCE_URL @"messageResourceURL"
#define MQTT_MESSAGE_KEY_LOCAL_PATH @"messageLocalPath"

#define MQTT_MESSAGE_KEY_IMAGE_SIZE @"imageSize"
#define MQTT_MESSAGE_KEY_AUDIO_DURATION_TIME @"audioDurationTime"
#define MQTT_MESSAGE_KEY_SENDER_USER_BASEID @"senderUserbaseID"

#define MQTT_MESSAGE_KEY_SENDER_NICK_NAME @"senderNickName"
#define MQTT_MESSAGE_KEY_RECEIVE_USER_BASEID @"receiveUserbaseID"
#define MQTT_MESSAGE_KEY_RECEIVE_NICK_NAME @"receiveNickName"

#define MQTT_MESSAGE_KEY_ORIGINAL_MESSAGE_ID @"originalMessageID"
#define MQTT_MESSAGE_KEY_CURRENT_USERBASE_ID @"currentUserbaseID"
#define MQTT_MESSAGE_KEY_SENDER_SMALL_FACE @"senderSmallFace"
#define MQTT_MESSAGE_KEY_MY_MESSAGE_SEND_STATUS @"myMessageSendStatus"
#define MQTT_MESSAGE_KEY_FRIEND_USER_BASEID @"friendUserBaseID"

#define MQTT_MESSAGE_KEY_SMALL_RESOURCE_URL @"messageSmallResourceURL"
#define MQTT_MESSAGE_KEY_MESSAGE_WIDTH @"messageWidth"
#define MQTT_MESSAGE_KEY_MESSAGE_HEIGHT @"messageHeight"


// 大数据PV数据定义
//事件ID
#define LEARNBAR_HOME_PV @"learnbar_home_pv"
#define LEARNBAR_COURSE_PV @"learnbar_course_pv"
#define LEARNBAR_GROUP_PV @"learnbar_group_pv"
#define LEARNBAR_PERSONAL_PV @"learnbar_personal_pv"
#define LEARNBAR_MORE_PV @"learnbar_more_pv"
#define LEARNBAR_VIDEO_PV @"pv_video"

// 二级窗体ID

typedef enum{
    WINDOW_PAGE_HOME=10100,
    WINDOW_PAGE_COURSE=10200,
    WINDOW_PAGE_GROUP_LIST=10301,
    WINDOW_PAGE_GROUP_MY_ATTENTION=10302,
    WINDOW_PAGE_GROUP_ABOUT_ME=10303,
    WINDOW_PAGE_GROUP=103000,
    WINDOW_PAGE_PEASONAL=10400,
    WINDOW_PAGE_MORE=10500,
    WINDOW_PAGE_MORE_NOTICE=10501,
    WINDOW_PAGE_MORE_FAVIRATE=10502,
    WINDOW_PAGE_MORE_FEEDBACK=10503,
    WINDOW_PAGE_MORE_NOTIFACTION=10504,
    WINDOW_PAGE_MORE_PROCTROL=10505,
    WINDOW_PAGE_MORE_ABOUT=10506,
    WINDOW_PAGE_MORE_CHECK_VERSION=10507,
    WINDOW_PAGE_MORE_CHANGE_USER=10508,
}WINDOW_PAGE_SECOND_TYPE;

//
////三级窗体ID
//typedef enum{
//
//    WINDOW_PAGE_COURSE_LIST=10201,
//    WINDOW_PAGE_GROUP_LIST=1,
//    WINDOW_PAGE_GROUP_MY_ATTENTIONS=2,
//    WINDOW_PAGE_GROUP_MY=3,
//    WINDOW_PAGE_MESSAGE_LIST=1,
//    WINDOW_PAGE_FRIEND_LIST=2,
//    WINDOW_PAGE_NOTICE_COENTE=18987,
//    WINDOW_PAGE_FAVIRITE_CONTENT=18987,
//
//}WINDOW_PAGE_THIRDLY_TYPE;
//
////四级窗体ID
//typedef enum{
//    
//    WINDOW_PAGE_VIDEO_LIST=10201,
//    WINDOW_PAGE_DOC_LIST=1,
//    WINDOW_PAGE_EXAM_LIST=2,
//    WINDOW_PAGE_NOTICE_LIST=3,
//    WINDOW_PAGE_PSRSONAL_HOME = 1
//    
//}WINDOW_PAGE_FOURTHLY_TYPE;
//
//
////五级窗体ID
//typedef enum{
//    
//    WINDOW_PAGE_GROUP_MY_LIST=1,
//    WINDOW_PAGE_FRINED=2,
//    
//}WINDOW_PAGE_FIFTH_TYPE;
//
//
////六级窗体ID
//typedef enum{
//    WINDOW_PAGE_COTENT=18987,
//}WINDOW_PAGE_SIXTH_TYPE;
































