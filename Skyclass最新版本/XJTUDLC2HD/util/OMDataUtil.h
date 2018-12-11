//
//  OMDataUtil.h
//  meos-i
//
//  Created by shadow ren on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kPRO_RANK_WEEK @""

/** 课程学习 **/
#define SEC_TYPE_KCJJ  1
#define SEC_TYPE_JSFC  2
#define SEC_TYPE_KQCS  3
#define SEC_TYPE_KCNR  4
#define SEC_TYPE_KHCS  5
#define SEC_TYPE_ZYKJ  6

//是否支持学习
#define RES_SUP_Y  1
#define RES_SUP_N  0

/**	资源学习类型 **/
#define STUDY_RESOURCE_TXT  1
#define STUDY_RESOURCE_MP3  2
#define STUDY_RESOURCE_MOV  3
#define STUDY_RESOURCE_SWF  4
#define STUDY_RESOURCE_PIC  5
#define STUDY_RESOURCE_OTHER  10


//课程类型(0:Null ,1:资源学习、3:实时课堂、2:自主学习、4:互动学习)
#define COURSE_TYPE_NULL  0
#define COURSE_TYPE_RESOURSE  1
#define COURSE_TYPE_ONLINEROOM  3
#define COURSE_TYPE_OWN  2
#define COURSE_TYPE_INTERACT  4
    
// 学习状态 
#define COURSE_STUDY_END  2 //学习完成
#define COURSE_STUDY_NO_START  0 //未开始
#define COURSE_STUDYING  1 //未开始


typedef enum{
    USER_SERVICE,
    COURSE_SERVICE,
    DISCUSS_SERVICE,
    PERSONAL_HOMEPAGE_SERVICE,
    SOPE_ACTION_COURSE_NAME,   //SOAPAction 中的 course 服务的名称
    SOPE_ACTION_DISCUSS_NAME,   //SOAPAction 中的 discuss group 服务的名称
    SOPE_ACTION_PERSONAL_HOMEPAGE_NAME,
    USER_REGISTER,             //注册
    USER_LOGIN,             //登陆
    GET_COURSE_LIST,   //用户的课程
    GET_OPEN_COURSE_LIST,   //用户的课程
    GET_COURSE_VIDEO_LIST,   //用户的课程的视频
    GET_COURSE_DOC_LIST,   //用户的课程的文档
    GET_COURSE_NOTICE_LIST,   //用户的课程的公告
    GET_COURSE_EXAMTASK_LIST,   //用户的课程的评测作业
    GET_COURSE_PDF_DOC_LIST,   //获取 PDF 文档
    GET_COURSE_NOTICE_PDF_LIST,   //PDF附件公告
    GET_COURSE_EXAMTASK,   //获取单个评测评测作业
    UPDATE_COURSE_WARE_STUDY_STATUS,   //更新课件状态（是否已为New）
    UPDATE_COURSE_WARE_STUDY_POINT,     //保存视频文档学习位置（断点续学保留接口）
    GET_COURSE_EXAMTASK_ITEM,    //获取评测试题内容
    SAVE_UNFINISH_EXAMTASK_RESULT,  //保存(未完成试题)   保存(未完成试题)saveUnFinishExamTaskResult
    SUBMIT_EXAM_RESULT,  // 交卷
    USER_FEEDBACK,          // 用户反馈
    DISCUSS_GET_THEME_CATEGORY,//主题分类
    DISCUSS_GET_THEME_LIST,    //主题列表
    DISCUSS_GET_THEME_LIST_BYUSERID,    //我关注的主题
    DISCUSS_ADD_ATTENTION_OF_THEME,     //添加对主题的关注
    DISCUSS_CANCEL_ATTENTION_OF_THEME,     //取消对主题的关注
    DISCUSS_GET_THEME_DETAIL_BY_THEMEID,    //主题详情
    DISCUSS_GET_GET_SPEAK_LIST_BY_THEMEID,      //主题的发言列表
    
    DISCUSS_ADD_SPEAK_CONTENT,//参与发言
    DISCUSS_GET_SPEAK_DETAIL_BY_SPEAKID,//发言条目详情
    DISCUSS_GET_REVIEWLIST_BY_SPEAKID,//发言条目评价列表
    DISCUSS_DELETE_SPEAK_BY_SPEAKID,//删除发言
    DISCUSS_ADD_SUPPORT_SPEAK,//赞发言
    DISCUSS_ADD_FAVORITE_SPEAK,//收藏发言
    DISCUSS_DELETE_FAVORITE_SPEAK,//删除收藏发言
    DISCUSS_ADD_REVIEW_OF_SPEAK,//添加发言评论
    DISCUSS_ADD_REVERT_OF_REVIEW,//回复评论
    DISCUSS_GET_THEME_AUTHORDETAIL_BY_THEMEAUTHORID,//发布个人主页（教师主页）
    DISCUSS_GET_THEMELIST_BY_AUTHORID,//发布人的主题
    DISCUSS_GET_SPEAKLIST_BY_USERID,//我的发言
    DISCUSS_GET_USER_NOSPEAKINFO_BY_USERID,//用户禁言信息
    DISCUSS_EDIT_SPEAK_CONTENT,//编辑发言
    DISCUSS_EDIT_REVIEW_OF_SPEAK,//编辑发言评论
    DISCUSS_ADD_FRIEND_INFO_REQUEST,
    
    GET_EDUCATION_NOTICE_LIST, //教务公告 列表
    GET_EDUCATION_NOTICE_DETAIL, //教务公告 详情
    
    MESSAGE_SDK_SENTFRIEND_RELATION,//处理通过验证
    MESSAGE_SDK_DELETEFRIEND_REQUEST,//删除好友
    MESSAGE_ADD_FRIEND_REQUEST,//添加好友
    MESSAGE_SDK_GETFRIEND_DETAIL,//获取好友的个人信息
    MESSAGE_GETFRIENF_LIST_BYNAME,//获取好友按姓名
    MESSAGE_GETFRIENF_LIST_NYUSERID,//获取当前用户d的好友列表
    MESSAGE_FACADE_INDUNREAD_MESSAGE,//获取未读消息
    MESSAGE_API_SEND_MESSAGE,//发送文本消息
    MESSAGE_API_SEND_IMAGEFILE,//发送文件
    
}Meos_b_url;


typedef enum {
    NetWork3G =1,
    NetWorkWIFI =2,
    NetWorkNONE = 3 ,
} NetWorkStyle;



@interface OMDataUtil : NSObject

+(NSString *) getUrlForKey:(Meos_b_url)key;

+(NSString *) trim: (NSString *)srcString;

//去掉一段String中的HTML标签
+(NSString *)stripHtmlTags:(NSString *)html;


+(NSString *)getRandomStringWithNumber:(NSInteger)number;


@end
