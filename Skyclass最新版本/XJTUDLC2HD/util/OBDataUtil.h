//
//  OBDataUtil.h
//  LearningBar
//
//  Created by zhe zhang on 14-7-22.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMUPDbutil.h"
#import "LBUserInfo.h"
@interface OBDataUtil : NSObject

// 添加数据到消息表
+(BOOL)insertMyMessage:(NSDictionary*) msgDic withDB:(FMDatabase*)db;
// 查询新通知数据
+(NSMutableArray*)getMyMessageListWithDB:(FMDatabase*)db;
// 查询新通知数据
+(NSMutableArray*)getMyNewsMessageListWithDB:(FMDatabase*)db;

// 更新通知查看状态
+(BOOL)updateMyNewsMessageReadState:(FMDatabase*)db  withMsgID:(int)msgID withState:(int)state;

//添加用户信息
+(BOOL)insertUserInfo:(FMDatabase *)db withUserInfo:(LBUserInfo*)userInfo;

//查询用户信息
+(LBUserInfo*)getLoginUserInfo:(FMDatabase *)db withUserId:(NSString*)userID;

// 删除用户信息
+(BOOL)deleteLoginUserInfo:(FMDatabase *)db withUserId:(NSString*)userID;

// 查询未读的私信
+(NSMutableArray*)getNewMessageListWithDB:(FMDatabase*)db withUserBaseID:(NSString*) currentUserbaseID;

 // 查询单个好友未读消息
+(NSMutableArray *)getNewMessageListWithDB:(FMDatabase *)db withUserBaseID:(NSString*) currentUserbaseID withFriendID:(NSString*)friendID;

// 删除消息
+(BOOL)deleteMessageWithDB:(FMDatabase *)db withUserBaseID:(NSString*) currentUserbaseID withMessageID:(NSString*) msgid;

@end
