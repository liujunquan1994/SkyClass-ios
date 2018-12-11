//
//  OBDataUtil.m
//  LearningBar
//
//  Created by zhe zhang on 14-7-22.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "OBDataUtil.h"
#import "LBAppDelegate.h"

@implementation OBDataUtil


// 添加数据到消息表
+(BOOL)insertMyMessage:(NSDictionary *)dic withDB:(FMDatabase *)db{

    NSString *sqlStr2=@"INSERT INTO myMessage(userId,MsgBaseId,MsgId,msgtitle,msgContent,msgBeginDate,msgEndTime,status,source,sendDate,creater,createDate,toUser,fromUser,fromUserName,fromUserSmallFace,code,type,isRead) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    BOOL ret = [db executeUpdate:sqlStr2,[APPDELEGATE userInfo].userBaseID,[dic objectForKey:@"id"],[dic objectForKey:@"MsgId"],[dic objectForKey:@"MsgTitle"],[dic objectForKey:@"MsgContent"],[dic objectForKey:@"MsgBeginTime"],[dic objectForKey:@"MsgEndTime"],[dic objectForKey:@"status"],@"",[dic objectForKey:@"postTime"],[dic objectForKey:@"CreateMan"],[dic objectForKey:@"CreateDate"],[dic objectForKey:@"toUser"],[dic objectForKey:@"fromUser"],[dic objectForKey:@"fromUserName"],[dic objectForKey:@"fromUserSmallFace"],[dic objectForKey:@"code"] ,[dic objectForKey:@"type"],[NSString stringWithFormat:@"%d",0]];
    
    return ret;

}

// 查询消息表的数据
+(NSMutableArray*)getMyMessageListWithDB:(FMDatabase *)db {
    
   
    NSMutableArray *messageArray=[[NSMutableArray alloc] init];
    NSString *sqlString =[NSString stringWithFormat:@"select * from myMessage where userId = %@ order by sendDate DESC",[APPDELEGATE userInfo].userBaseID];
    FMResultSet *rs = [db executeQuery:sqlString];    
    while([rs next]){
        
        NSMutableDictionary *myMessageDic = [[NSMutableDictionary alloc] init];
        [myMessageDic setObject:[rs objectForColumnName:@"id"] forKey:@"id"];
        [myMessageDic setObject:[rs objectForColumnName:@"userId"] forKey:@"userId"];
        [myMessageDic setObject:[rs objectForColumnName:@"MsgBaseId"] forKey:@"MsgBaseId"];
        [myMessageDic setObject:[rs objectForColumnName:@"msgId"] forKey:@"msgId"];
        [myMessageDic setObject:[rs objectForColumnName:@"msgtitle"] forKey:@"msgtitle"];
        [myMessageDic setObject:[rs objectForColumnName:@"MsgBeginTime"] forKey:@"MsgBeginTime"];
        [myMessageDic setObject:[rs objectForColumnName:@"msgContent"] forKey:@"msgContent"];
        [myMessageDic setObject:[rs objectForColumnName:@"msgEndTime"] forKey:@"msgEndTime"];
        [myMessageDic setObject:[rs objectForColumnName:@"status"] forKey:@"status"];
        [myMessageDic setObject:[rs objectForColumnName:@"source"] forKey:@"source"];
        [myMessageDic setObject:[rs objectForColumnName:@"sendDate"] forKey:@"sendDate"];
        [myMessageDic setObject:[rs objectForColumnName:@"creater"] forKey:@"creater"];
        [myMessageDic setObject:[rs objectForColumnName:@"createDate"] forKey:@"createDate"];
        [myMessageDic setObject:[rs objectForColumnName:@"fromUser"] forKey:@"fromUser"];
        [myMessageDic setObject:[rs objectForColumnName:@"toUser"] forKey:@"toUser"];
        [myMessageDic setObject:[rs objectForColumnName:@"type"] forKey:@"type"];
        [myMessageDic setObject:[rs objectForColumnName:@"code"] forKey:@"code"];
        [myMessageDic setObject:[rs objectForColumnName:@"isRead"] forKey:@"isRead"];
        [myMessageDic setObject:[rs objectForColumnName:@"FromUserName"] forKey:@"FromUserName"];
        [myMessageDic setObject:[rs objectForColumnName:@"fromUserSmallFace"] forKey:@"fromUserSmallFace"];
        [messageArray addObject:myMessageDic];
        
    }
    [rs close];
    return messageArray;


}

+(NSMutableArray*)getMyNewsMessageListWithDB:(FMDatabase*)db{
    
    NSMutableArray *messageArray=[[NSMutableArray alloc] init];
    NSString *sqlString =[NSString stringWithFormat:@"select * from myMessage where isRead = 0 and userId = %@",[APPDELEGATE userInfo].userBaseID];
    FMResultSet *rs = [db executeQuery:sqlString];
    
    while([rs next]){
        
        NSMutableDictionary *myMessageDic = [[NSMutableDictionary alloc] init];
        [myMessageDic setObject:[rs objectForColumnName:@"id"] forKey:@"id"];
        [myMessageDic setObject:[rs objectForColumnName:@"userId"] forKey:@"userId"];
        [myMessageDic setObject:[rs objectForColumnName:@"MsgBaseId"] forKey:@"MsgBaseId"];
        [myMessageDic setObject:[rs objectForColumnName:@"msgId"] forKey:@"msgId"];
        [myMessageDic setObject:[rs objectForColumnName:@"msgtitle"] forKey:@"msgtitle"];
        [myMessageDic setObject:[rs objectForColumnName:@"MsgBeginTime"] forKey:@"MsgBeginTime"];
        [myMessageDic setObject:[rs objectForColumnName:@"msgContent"] forKey:@"msgContent"];
        [myMessageDic setObject:[rs objectForColumnName:@"msgEndTime"] forKey:@"msgEndTime"];
        [myMessageDic setObject:[rs objectForColumnName:@"status"] forKey:@"status"];
        [myMessageDic setObject:[rs objectForColumnName:@"source"] forKey:@"source"];
        [myMessageDic setObject:[rs objectForColumnName:@"sendDate"] forKey:@"sendDate"];
        [myMessageDic setObject:[rs objectForColumnName:@"creater"] forKey:@"creater"];
        [myMessageDic setObject:[rs objectForColumnName:@"createDate"] forKey:@"createDate"];
        [myMessageDic setObject:[rs objectForColumnName:@"fromUser"] forKey:@"fromUser"];
        [myMessageDic setObject:[rs objectForColumnName:@"toUser"] forKey:@"toUser"];
        [myMessageDic setObject:[rs objectForColumnName:@"type"] forKey:@"type"];
        [myMessageDic setObject:[rs objectForColumnName:@"code"] forKey:@"code"];
        [myMessageDic setObject:[rs objectForColumnName:@"isRead"] forKey:@"isRead"];
        [myMessageDic setObject:[rs objectForColumnName:@"FromUserName"] forKey:@"FromUserName"];
        [myMessageDic setObject:[rs objectForColumnName:@"fromUserSmallFace"] forKey:@"fromUserSmallFace"];
        [messageArray addObject:myMessageDic];
        
    }
    [rs close];
    return messageArray;
}

+(BOOL)updateMyNewsMessageReadState:(FMDatabase *)db withMsgID:(int)msgID withState:(int)state{
    
    NSString *sqlString =@"update myMessage set isRead = ? where id =? and userId =?";
    return [db executeUpdate:sqlString,[NSString stringWithFormat:@"%d",state],[NSString stringWithFormat:@"%d",msgID],[APPDELEGATE userInfo].userBaseID];
}


//#define kTableMyUser @" userInfo (u_id text,u_base_id text, u_role text, u_name text,u_pwd text,u_studentcode text,u_professionName text, u_professionState text,u_issaved text,u_icon text, u_nick text,u_token text);"


+(BOOL)insertUserInfo:(FMDatabase *)db withUserInfo:(LBUserInfo *)userInfo{
    
    NSString *sqlStr2=@"INSERT INTO userInfo(u_id,u_base_id,u_appid,u_role,u_name,u_pwd,u_studentcode,u_professionName,u_professionState,u_issaved,u_icon,u_nick,u_token) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";

    
    BOOL ret = [db executeUpdate:sqlStr2,userInfo.userID,userInfo.userBaseID,userInfo.appIndex,userInfo.studentRole,userInfo.userName,userInfo.password,userInfo.studentCode,userInfo.professionName,userInfo.professionStatus,[NSString stringWithFormat:@"%d",0],userInfo.userHeadImageURLString,userInfo.userNickname,userInfo.tokenOfOBS];
    return ret;

    

}


+(LBUserInfo*)getLoginUserInfo:(FMDatabase *)db withUserId:(NSString *)userID{
    
    
    LBUserInfo *userInfo;
    NSString *sqlString =[NSString stringWithFormat:@"select * from userInfo"];
    FMResultSet *rs = [db executeQuery:sqlString];
    
    while([rs next]){
        userInfo = [[LBUserInfo alloc] init];
        userInfo.userID = [rs objectForColumnName:@"u_id"];
        userInfo.userBaseID =[rs objectForColumnName:@"u_base_id"];
        userInfo.appIndex = [rs objectForColumnName:@"u_appid"];
        NSString *role =[rs objectForColumnName:@"u_role"] ;
        if([role isEqualToString:@"student"]){
            userInfo.userType = USERTYPE_STUDENT;
        }else if([role isEqualToString:@"teacher"]){
            userInfo.userType = USERTYPE_TEACHER;
        }else if([role isEqualToString:@"common"]){
            userInfo.userType = USERTYPE_COMMON;
        }
        userInfo.userName=[rs objectForColumnName:@"u_name"] ;
        userInfo.password =[rs objectForColumnName:@"u_pwd"];
        userInfo.studentCode=[rs objectForColumnName:@"u_studentcode"];
        userInfo.professionName =[rs objectForColumnName:@"u_professionName"];
        userInfo.professionStatus =[rs objectForColumnName:@"u_professionState"];
        userInfo.isSaveUser =[[rs objectForColumnName:@"u_issaved"] integerValue];
        userInfo.userHeadImageURLString =[rs objectForColumnName:@"u_icon"] ;
        userInfo.userNickname =[rs objectForColumnName:@"u_nick"] ;
        userInfo.tokenOfOBS =[rs objectForColumnName:@"u_token"];
    }
    [rs close];
    return userInfo;


}

+(BOOL)deleteLoginUserInfo:(FMDatabase *)db withUserId:(NSString *)userID{

    NSString *sqlString =@"delete from userInfo";
    return [db executeUpdate:sqlString];
}


//
+(NSMutableArray *)getNewMessageListWithDB:(FMDatabase *)db withUserBaseID:(NSString*) currentUserbaseID{
    
    
    NSString *sql =  @"select * from mqttSendedMessage where 1=1  ";
    sql =[NSString stringWithFormat: @" %@  and isRead=0 and currentUserbaseID = %@",
          sql,currentUserbaseID];

    NSMutableArray *arrray = [NSMutableArray array];
    
    FMResultSet *rs = [db executeQuery:sql];
    while([rs next]){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[rs objectForColumnName:@"id"] forKey:MQTT_MESSAGE_KEY_SMID];
        
        [dic setObject:[rs objectForColumnName:@"messageType"] forKey:MQTT_MESSAGE_KEY_TYPE];
        
        [dic setObject:[rs objectForColumnName:@"messageCode"] forKey:MQTT_MESSAGE_KEY_CODE];
        [dic setObject:[rs objectForColumnName:@"isRead"] forKey:MQTT_MESSAGE_KEY_IS_READ];
        [dic setObject:[rs objectForColumnName:@"messageContent"] forKey:MQTT_MESSAGE_KEY_CONTENT];
        [dic setObject:[rs objectForColumnName:@"messageSendDateTime"] forKey:MQTT_MESSAGE_KEY_SEND_DATE_TIME];
        
        [dic setObject:[rs objectForColumnName:@"messageReceiveDateTime"] forKey:MQTT_MESSAGE_KEY_RECEIVE_DATE_TIME];
        [dic setObject:[rs objectForColumnName:@"messageResourceURL"] forKey:MQTT_MESSAGE_KEY_RESOURCE_URL];
        [dic setObject:[rs objectForColumnName:@"messageLocalPath"] forKey:MQTT_MESSAGE_KEY_LOCAL_PATH];
        [dic setObject:[rs objectForColumnName:@"imageSize"] forKey:MQTT_MESSAGE_KEY_IMAGE_SIZE];
        
        [dic setObject:[rs objectForColumnName:@"audioDurationTime"] forKey:MQTT_MESSAGE_KEY_AUDIO_DURATION_TIME];
        [dic setObject:[rs objectForColumnName:@"senderUserbaseID"] forKey:MQTT_MESSAGE_KEY_SENDER_USER_BASEID];
        [dic setObject:[rs objectForColumnName:@"senderNickName"] forKey:MQTT_MESSAGE_KEY_SENDER_NICK_NAME];
        [dic setObject:[rs objectForColumnName:@"receiveUserbaseID"] forKey:MQTT_MESSAGE_KEY_RECEIVE_USER_BASEID];
        
        [dic setObject:[rs objectForColumnName:@"receiveNickName"] forKey:MQTT_MESSAGE_KEY_RECEIVE_NICK_NAME];
        [dic setObject:[rs objectForColumnName:@"originalID"] forKey:MQTT_MESSAGE_KEY_ORIGINAL_MESSAGE_ID];
        [dic setObject:[rs objectForColumnName:@"currentUserbaseID"] forKey:MQTT_MESSAGE_KEY_CURRENT_USERBASE_ID];
        [dic setObject:[rs objectForColumnName:@"senderSmallFace"] forKey:MQTT_MESSAGE_KEY_SENDER_SMALL_FACE];
        
        [dic setObject:[rs objectForColumnName:@"myMessageSendStatus"] forKey:MQTT_MESSAGE_KEY_MY_MESSAGE_SEND_STATUS];
        [dic setObject:[rs objectForColumnName:@"friendUserBaseID"] forKey:MQTT_MESSAGE_KEY_FRIEND_USER_BASEID];
        [dic setObject:[rs objectForColumnName:@"messageSmallResourceURL"] forKey:MQTT_MESSAGE_KEY_SMALL_RESOURCE_URL];
        
        [dic setObject:[rs objectForColumnName:@"messageWidth"] forKey:MQTT_MESSAGE_KEY_MESSAGE_WIDTH];
        [dic setObject:[rs objectForColumnName:@"messageHeight"] forKey:MQTT_MESSAGE_KEY_MESSAGE_HEIGHT];
        [arrray addObject:dic];

    }
    [rs close];
    [OMUPDbutil closeDB:db];
    
    //NSLog(@"本地数据中 获得的新消息是===%@", arrray);
    return arrray;
}


//
+(NSMutableArray *)getNewMessageListWithDB:(FMDatabase *)db withUserBaseID:(NSString*) currentUserbaseID withFriendID:(NSString*)friendID{
    
    
    NSString *sql =  @"select * from mqttSendedMessage where 1=1  ";
    sql =[NSString stringWithFormat: @" %@  and isRead=0 and currentUserbaseID = %@ and friendUserBaseID = %@",
          sql,currentUserbaseID,friendID];
    
    NSMutableArray *arrray = [NSMutableArray array];
    
    FMResultSet *rs = [db executeQuery:sql];
    while([rs next]){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[rs objectForColumnName:@"id"] forKey:MQTT_MESSAGE_KEY_SMID];
        
        [dic setObject:[rs objectForColumnName:@"messageType"] forKey:MQTT_MESSAGE_KEY_TYPE];
        
        [dic setObject:[rs objectForColumnName:@"messageCode"] forKey:MQTT_MESSAGE_KEY_CODE];
        [dic setObject:[rs objectForColumnName:@"isRead"] forKey:MQTT_MESSAGE_KEY_IS_READ];
        [dic setObject:[rs objectForColumnName:@"messageContent"] forKey:MQTT_MESSAGE_KEY_CONTENT];
        [dic setObject:[rs objectForColumnName:@"messageSendDateTime"] forKey:MQTT_MESSAGE_KEY_SEND_DATE_TIME];
        
        [dic setObject:[rs objectForColumnName:@"messageReceiveDateTime"] forKey:MQTT_MESSAGE_KEY_RECEIVE_DATE_TIME];
        [dic setObject:[rs objectForColumnName:@"messageResourceURL"] forKey:MQTT_MESSAGE_KEY_RESOURCE_URL];
        [dic setObject:[rs objectForColumnName:@"messageLocalPath"] forKey:MQTT_MESSAGE_KEY_LOCAL_PATH];
        [dic setObject:[rs objectForColumnName:@"imageSize"] forKey:MQTT_MESSAGE_KEY_IMAGE_SIZE];
        
        [dic setObject:[rs objectForColumnName:@"audioDurationTime"] forKey:MQTT_MESSAGE_KEY_AUDIO_DURATION_TIME];
        [dic setObject:[rs objectForColumnName:@"senderUserbaseID"] forKey:MQTT_MESSAGE_KEY_SENDER_USER_BASEID];
        [dic setObject:[rs objectForColumnName:@"senderNickName"] forKey:MQTT_MESSAGE_KEY_SENDER_NICK_NAME];
        [dic setObject:[rs objectForColumnName:@"receiveUserbaseID"] forKey:MQTT_MESSAGE_KEY_RECEIVE_USER_BASEID];
        
        [dic setObject:[rs objectForColumnName:@"receiveNickName"] forKey:MQTT_MESSAGE_KEY_RECEIVE_NICK_NAME];
        [dic setObject:[rs objectForColumnName:@"originalID"] forKey:MQTT_MESSAGE_KEY_ORIGINAL_MESSAGE_ID];
        [dic setObject:[rs objectForColumnName:@"currentUserbaseID"] forKey:MQTT_MESSAGE_KEY_CURRENT_USERBASE_ID];
        [dic setObject:[rs objectForColumnName:@"senderSmallFace"] forKey:MQTT_MESSAGE_KEY_SENDER_SMALL_FACE];
        
        [dic setObject:[rs objectForColumnName:@"myMessageSendStatus"] forKey:MQTT_MESSAGE_KEY_MY_MESSAGE_SEND_STATUS];
        [dic setObject:[rs objectForColumnName:@"friendUserBaseID"] forKey:MQTT_MESSAGE_KEY_FRIEND_USER_BASEID];
        [dic setObject:[rs objectForColumnName:@"messageSmallResourceURL"] forKey:MQTT_MESSAGE_KEY_SMALL_RESOURCE_URL];
        
        [dic setObject:[rs objectForColumnName:@"messageWidth"] forKey:MQTT_MESSAGE_KEY_MESSAGE_WIDTH];
        [dic setObject:[rs objectForColumnName:@"messageHeight"] forKey:MQTT_MESSAGE_KEY_MESSAGE_HEIGHT];
        [arrray addObject:dic];
        
    }
    [rs close];
    [OMUPDbutil closeDB:db];
    
    //NSLog(@"本地数据中 获得的新消息是===%@", arrray);
    return arrray;
}

// 删除消息
+(BOOL)deleteMessageWithDB:(FMDatabase *)db withUserBaseID:(NSString*) currentUserbaseID withMessageID:(NSString*) msgid{
    
    NSString *sqlString =[NSString stringWithFormat:@"delete from  myMessage where userId = '%@' and MsgBaseId = '%@'" ,[APPDELEGATE userInfo].userBaseID,msgid];
    return [db executeUpdate:sqlString];

}

@end
