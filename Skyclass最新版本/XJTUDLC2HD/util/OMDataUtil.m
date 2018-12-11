//
//  OMDataUtil.m
//  meos-i
//
//  Created by shadow ren on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OMDataUtil.h"

@interface OMDataUtil (PrivateMethods)

@end


@implementation OMDataUtil

#define kFromatUrl @"%@%@"
#define kHttp @"RemoteServer"
#define kString @"MeosString"
#define kAppEnv @"app_env_bar"


+ (NSString *) getUrlForKey: (Meos_b_url)key
{
    NSString *env = NSLocalizedString(@"app_envis", @"testABC");
    NSString *prefix = nil;

    if([env isEqual:@"test"]){
        prefix = NSLocalizedString(@"testPrefix", nil);
    }else{
        prefix = NSLocalizedString(@"productPrefix", nil);
    }
    /*
     USER_SERVICE,
     COURSE_SERVICE,
     USER_LOGIN,             //登陆
     GET_COURSE_LIST,   //用户的课程
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
     
     GET_EDUCATION_NOTICE_LIST, //教务公告 列表
     GET_EDUCATION_NOTICE_DETAIL, //教务公告 详情
     
     
     */
    switch (key) {
        case USER_SERVICE:  //用户登录
            return [NSString stringWithFormat:kFromatUrl, prefix, NSLocalizedString(@"url_user_service", nil)];
        case COURSE_SERVICE:
            return [NSString stringWithFormat:kFromatUrl, prefix, NSLocalizedString(@"url_course_service", nil)];
       
        case DISCUSS_SERVICE:
            return [NSString stringWithFormat:kFromatUrl, prefix, NSLocalizedString(@"url_discuss_service", nil)];
        case PERSONAL_HOMEPAGE_SERVICE:
            return [NSString stringWithFormat:kFromatUrl, prefix, NSLocalizedString(@"url_person_hompage_service", nil)];
        
        case SOPE_ACTION_COURSE_NAME:
            return NSLocalizedString(@"soap_action_course_name", nil);
        case SOPE_ACTION_DISCUSS_NAME:
            return NSLocalizedString(@"soap_action_discuss_name", nil);
        case SOPE_ACTION_PERSONAL_HOMEPAGE_NAME:
        return NSLocalizedString(@"soap_action_person_homepage_name", nil);
        case USER_REGISTER:
            return NSLocalizedString(@"url_user_register_action", nil);
        case USER_LOGIN:
            return NSLocalizedString(@"url_user_login_action", nil);
        case GET_COURSE_LIST:
            return NSLocalizedString(@"url_course_list_action", nil);
        case GET_OPEN_COURSE_LIST:
            return NSLocalizedString(@"url_course_open_list_action", nil);
        case GET_COURSE_EXAMTASK_LIST:
            return NSLocalizedString(@"url_course_examtask_list_action", nil);
        case GET_COURSE_VIDEO_LIST:
            return NSLocalizedString(@"url_course_video_list_action", nil);
        case GET_COURSE_PDF_DOC_LIST:
            return NSLocalizedString(@"url_course_doc_pdf_list_action", nil);
        case GET_COURSE_NOTICE_PDF_LIST:
            return NSLocalizedString(@"url_course_notice_pdf_list_action", nil);
        case GET_COURSE_EXAMTASK:
            return NSLocalizedString(@"url_course_examtask_action", nil);
        case GET_COURSE_EXAMTASK_ITEM:
            return NSLocalizedString(@"url_course_examtask_item_action", nil);
        case UPDATE_COURSE_WARE_STUDY_STATUS:
            return NSLocalizedString(@"url_set_courseware_study_status_action", nil);
        case UPDATE_COURSE_WARE_STUDY_POINT:
            return NSLocalizedString(@"url_set_courseware_study_point_action", nil);
        case SAVE_UNFINISH_EXAMTASK_RESULT:
            return NSLocalizedString(@"url_save_unfinish_examtask_result_action", nil);
        case SUBMIT_EXAM_RESULT:
            return NSLocalizedString(@"url_submit_objective_examtask_result_action", nil);
        case USER_FEEDBACK:
            return NSLocalizedString(@"url_add_feedback_action", nil);
        case DISCUSS_GET_THEME_CATEGORY:
            return NSLocalizedString(@"url_get_theme_category_list_action", nil);
        case DISCUSS_GET_THEME_LIST:
            return NSLocalizedString(@"url_get_theme_list_action", nil);
        case DISCUSS_GET_THEME_LIST_BYUSERID:
            return NSLocalizedString(@"url_get_theme_list_by_userID_action", nil);
        case DISCUSS_ADD_ATTENTION_OF_THEME:
            return NSLocalizedString(@"url_add_attention_oftheme_action", nil);
        case DISCUSS_CANCEL_ATTENTION_OF_THEME:
            return NSLocalizedString(@"url_cancle_attention_oftheme_action", nil);
        case DISCUSS_GET_THEME_DETAIL_BY_THEMEID:
            return NSLocalizedString(@"url_get_themedetail_by_themeid_action", nil);
        case DISCUSS_GET_GET_SPEAK_LIST_BY_THEMEID:
            return NSLocalizedString(@"url_getspeak_list_by_themeid_action", nil);
        case DISCUSS_ADD_SPEAK_CONTENT:
            return NSLocalizedString(@"url_add_speak_content_action", nil);
        case DISCUSS_GET_SPEAK_DETAIL_BY_SPEAKID:
            return NSLocalizedString(@"url_get_speakdetail_by_speakid_action", nil);
        case DISCUSS_GET_REVIEWLIST_BY_SPEAKID:
            return NSLocalizedString(@"url_get_reviewlist_by_speakid_action", nil);
        case DISCUSS_DELETE_SPEAK_BY_SPEAKID:
            return NSLocalizedString(@"url_delete_speak_by_speakid_action", nil);
        case DISCUSS_ADD_SUPPORT_SPEAK:
            return NSLocalizedString(@"url_add_support_speak_action", nil);
        case DISCUSS_ADD_FAVORITE_SPEAK:
            return NSLocalizedString(@"url_add_favorite_speak_action", nil);
        case DISCUSS_DELETE_FAVORITE_SPEAK:
            return NSLocalizedString(@"url_delete_favorite_speak_action", nil);
        case DISCUSS_ADD_REVIEW_OF_SPEAK:
            return NSLocalizedString(@"url_add_review_ofspeak_action", nil);
        case DISCUSS_ADD_REVERT_OF_REVIEW:
            return NSLocalizedString(@"url_add_revert_ofreview_action", nil);
        case DISCUSS_GET_THEME_AUTHORDETAIL_BY_THEMEAUTHORID:
            return NSLocalizedString(@"url_get_themeauthor_detail_by_themeauthorid_action", nil);
        case DISCUSS_GET_THEMELIST_BY_AUTHORID:
            return NSLocalizedString(@"url_get_themelist_by_authorid_action", nil);
        case DISCUSS_GET_SPEAKLIST_BY_USERID:
            return NSLocalizedString(@"url_get_speaklist_by_userid_action", nil);
        case DISCUSS_GET_USER_NOSPEAKINFO_BY_USERID:
            return NSLocalizedString(@"url_get_user_nospeakinfo_by_userid_action", nil);
        case DISCUSS_EDIT_SPEAK_CONTENT:
            return NSLocalizedString(@"url_edit_speak_content_action", nil);
        case DISCUSS_EDIT_REVIEW_OF_SPEAK:
            return NSLocalizedString(@"url_edit_review_ofspeak_action", nil);
        case DISCUSS_ADD_FRIEND_INFO_REQUEST:
            return NSLocalizedString(@"url_add_friend_info_request", nil);
        //
        case GET_EDUCATION_NOTICE_LIST:
        return NSLocalizedString(@"url_get_education_notice_list_action", nil);
        case GET_EDUCATION_NOTICE_DETAIL:
        return NSLocalizedString(@"url_get_education_notice_detail_action", nil);
        
        
        case MESSAGE_SDK_SENTFRIEND_RELATION:
        return NSLocalizedString(@"learningbar_sdk_url_setFriendRelation", nil);
        case MESSAGE_SDK_DELETEFRIEND_REQUEST:
        return NSLocalizedString(@"learningbar_sdk_url_deleteFriendRequestInfo", nil);
        case MESSAGE_ADD_FRIEND_REQUEST:
        return NSLocalizedString(@"learningbar_sdk_url_addFriendRequestInfo", nil);
        case MESSAGE_SDK_GETFRIEND_DETAIL:
        return NSLocalizedString(@"learningbar_sdk_url_getFriendDetailByUserId", nil);
        case MESSAGE_GETFRIENF_LIST_BYNAME:
        return NSLocalizedString(@"learningbar_sdk_url_getFriendListByName", nil);
        case MESSAGE_GETFRIENF_LIST_NYUSERID:
        return NSLocalizedString(@"learningbar_sdk_url_getFriendListByUserId", nil);
        case MESSAGE_FACADE_INDUNREAD_MESSAGE:
        return NSLocalizedString(@"learningbar_message_facade_indUnreadMessage", nil);
        case MESSAGE_API_SEND_MESSAGE:
        return NSLocalizedString(@"learningbar_message_api_sendMessage", nil);
        case MESSAGE_API_SEND_IMAGEFILE:
        return NSLocalizedString(@"learningbar_message_api_sendImageFile", nil);
        
        
        default:
            break;
    }
    return nil;
}


+ (NSString *)trim:(NSString *)srcString
{
    NSMutableString *mStr = [srcString mutableCopy];
    CFStringTrimWhitespace((CFMutableStringRef)mStr);
    NSString *result = [mStr copy];
    return result;
}

//去掉一段String中的HTML标签
+(NSString *)stripHtmlTags:(NSString *)html
{
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } // while //
    
    return html;
}


+(NSString *)getRandomStringWithNumber:(NSInteger)number
{
    NSString *alphabet  = @"-abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXZY-0123456789-";
    NSMutableString *client = [NSMutableString stringWithCapacity:number];
    for (NSUInteger i = 0; i < number; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [client appendFormat:@"%C", c];
    }
    
    return client;
}


@end
