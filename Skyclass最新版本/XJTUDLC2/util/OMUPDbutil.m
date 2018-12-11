//
//  OMUPDbutil.m
//  meos-i
//
//  Created by shadow ren on 12-5-22.
//  Copyright (c) 2012Âπ?__MyCompanyName__. All rights reserved.
//

#import "OMUPDbutil.h"
#import "FMDatabase.h"
#import "LBBaseViewController.h"
#import "OMCourseItem.h"

#define kPageItemCount 16
#define kDBName @"meosup.db"
#define kTable1Str @"userCourse(id text, folderId text, title text, imgUrl text, pageNo integer, pageIndex integer, type integer, hasCheck integer, isFolder integer, studyStatus integer, userId text)"

#define kNum(x) [NSNumber numberWithInt:x]

//资源下载
//文本资源：alreadSize=下载到的页数；fileSize=总页数；
//音频视频：alreadSize=已经下载的字节数；fileSize=文件总的字节数；
//stutas=下载状体：1=等待下载（自动开始下载）； 2=正在下载； 3=暂停（不能自动开始）； 4=完成；
//showFileSize:从服务器取回的json数据中的文件尺寸；
#define kTableDownloadStr @"userDownloadInfo ( rid INTEGER PRIMARY KEY, userID text, resourceID text, resourceUrl text, resourceStyle integer, studentCourseID text, courseName text, resourceName text, pageCount integer, alreadSize integer, status integer, fileSize integer, pageAlreadSize integer, pageFileSize integer, localPath text, createDate text, resourcePageID text, startPlayTime integer, showFileSize integer) "

//
#define kTableCurrentUserBgImage @"currentUserBjImage ( rid INTEGER PRIMARY KEY, userID text, imageUrl text, isChange text) "

#define kTableExamRecord @"examRecord ( rid INTEGER PRIMARY KEY, record text) "

//mqtt 相关的数据
/*
 smid INTEGER PRIMARY KEY  本地数据表的主键
 messageType text, 消息类型
 messageCode text, 消息编码
 
 isRead integer, 是否阅读：0：未读；1：已读；
 messageContent text, 消息内容
 messageSendDateTime text   消息发送时间
 
 messageReceiveDateTime text   消息本地接收时间
 messageResourceURL text 消息资源（音频、图片）的URL （原始图片的URL）
 messageLocalPath text    消息资源（音频、图片）的本地路径
 
 imageSize text    图片尺寸
 audioDurationTime text   音频时长
 
 senderUserbaseID text    消息发送者的 ID
 senderNickName text    消息发送者的 昵称
 
 receiveUserbaseID text    消息 接收 者的 ID
 receiveNickName text    消息 接收 者的 昵称
 originalID text   原始消息ID， 服务器数据库上的 消息ID
 currentUserbaseID text   当前用户的ID

 senderSmallFace text   消息发送者的 头像 的URL
 myMessageSendStatus text  自己发送消息的 发送状态：1：成功；0：失败；-1：发送中；
 friendUserBaseID text  当前这个消息与 哪个 好友 有关
 
 messageSmallResourceURL text 消息资源（音频、图片）的URL （缩略图 图片的URL）
 messageWidth text   消息字符串的 宽度
 messageHeight text 消息字符串的 高度
 */
#define kTableMqttData @"mqttSendedMessage ( id INTEGER PRIMARY KEY, messageType text, messageCode text, isRead text, messageContent text, messageSendDateTime text, messageReceiveDateTime text, messageResourceURL text, messageLocalPath text,  imageSize text, audioDurationTime text, senderUserbaseID text, senderNickName text, receiveUserbaseID text, receiveNickName text, originalID text, currentUserbaseID text, senderSmallFace text, myMessageSendStatus text, friendUserBaseID text, messageSmallResourceURL text, messageWidth text, messageHeight text) "

#define kTablefriendList @"mqttfriendList ( id INTEGER PRIMARY KEY, friendUserBaseID text, friendIconUrl text, friendName text) "

/*
 
*/
#define UserID "userId"  // 用户ID
#define msgBaseId "MsgBaseId"  // 消息基础后台ID
#define msgId "MsgId"  // 消息ID
#define MsgTitle "msgtitle" // 消息的标题
#define MsgBeginTime "msgBeginDate" // 有效期开始
#define MsgContent "msgContent" // 消息内容

#define MsgEndTime "msgEndTime"// 有效期结束时间
#define MsgStatus "status" // 消息状态
#define MsgSource "source" //消息来源
#define CreateSendName "sendDate" // 发送时间
#define CreateMan "creater"  // 创建人
#define CreateDate "createDate" // 创建时间
#define FromUser "fromUser" // 消息来源
#define FromUserName "fromUserName" // 消息来源
#define MsgSamllFaceUrl "fromUserSmallFace"// 信息发送人图像地址
#define ToUser "toUser" // 消息去向
#define MsgType "type" // 消息类型
#define MsgCode "code" // 消息编码
#define IsRead "isRead" //是否已被用户读取  isRead integer, 是否阅读：0：未读；1：已读；

#define kTableMyMessage @"myMessage ( id INTEGER PRIMARY KEY,userId text,MsgBaseId text, MsgId Integer,  msgtitle text,  msgBeginDate text, msgContent text, msgEndTime text,status Integer, source text, sendDate text,creater text,createDate text,toUser text,fromUser text,FromUserName text,fromUserSmallFace text,code Integer,type Integer,isRead Integer) "


/*
public static final String TABLE_NAME = "logininfo";
public static final String USER_ID = "u_id";
public static final String USER_BASE_ID = "u_base_id";
public static final String USER_ROLE = "u_role";
public static final String USER_NAME = "u_name";
public static final String USER_PWD = "u_pwd";
public static final String USER_STUDENT_CODE = "u_studentcode";
public static final String USER_PROFESSION_NAME = "u_professionName";
public static final String USER_PROFESSION_STATE = "u_professionState";
public static final String USER_ISSAVED = "u_issaved";
public static final String USER_ICON = "u_icon";
public static final String USER_NICENAME = "u_nick";
public static final String USER_TOKEN = "u_token";
 */

#define kTableMyUser @" userInfo (u_id text,u_base_id text, u_appid text,u_role text, u_name text,u_pwd text,u_studentcode text,u_professionName text, u_professionState text,u_issaved text,u_icon text, u_nick text,u_token text);"







@implementation OMUPDbutil

+(void)getInsertMyMessageSql{
    

    
}


+ (BOOL) initDB
{
    FMDatabase *db = [OMUPDbutil openDB];
    if (db) {
//        [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@", kTable1Str]];
        [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@", kTableDownloadStr]];
        [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@", kTableCurrentUserBgImage]];
        [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@", kTableMqttData]];
        [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@", kTableExamRecord]];
        [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@", kTablefriendList]];
        [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@", kTableMyMessage]];
        [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@", kTableMyUser]];
        [db close];
        return YES;
    }
    
    return NO;
}


+ (FMDatabase *)openDB
{
    FMDatabase *db= [OMUPDbutil getDB];
    if (![db open]) {  
        return nil;
    }
    return db;
}


+ (FMDatabase *)getDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *directory=[documentsDirectory stringByAppendingPathComponent:@"sqlite"];
    BOOL isDic;
    if (![fileManager fileExistsAtPath:directory isDirectory:&isDic]) {
        [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
        //////////
        [LBBaseViewController addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:directory isDirectory:YES]];
        //////////
    }
    
    
    
    
    NSString *dbPath = [directory stringByAppendingPathComponent:kDBName];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;

    return db;
}



+ (void) closeDB: (FMDatabase *)db
{
    [db close];
}





#define kBeforeCheck 0
#define kAfterCheck 1







//NSString *currentUserId;

/*+ (int) refreshServerItems: (NSArray *)items withCourseItem:(NSMutableArray *)userCourseArray
                withUserId: (NSString *)userId
{
    currentUserId = userId;

    
    FMDatabase *db = [OMUPDbutil openDB];
    
    
    FMResultSet *rs = [db executeQuery:@"SELECT COUNT(*) FROM userCourse WHERE userId=?", userId];
    int savedCount = 0;
    if ([rs next]) {
        savedCount = [rs intForColumnIndex:0];
    }
    int maxPageNo = [OMUPDbutil getMaxPageNo:db];
    
    if (savedCount) {
        //删除是Id重复的纪录
        [db executeUpdate:@"delete userCourse a where (select count(*) from userCourse where id = a.id) >= 2"];
        //删除没有课程的文件夹纪录
        [db executeUpdate:@"delete userCourse a where isFolder = 1 and not exists (select * from userCourse where folderId = a.id)"];
        [db executeUpdate:@"update userCourse set folderId = ? where isFolder = 0 and not exists (select * from userCourse b where b.id = userCourse.folderId)", kDefaultFolderId];
        
        
        //处理服务端和本地不一致的问题
        FMResultSet *brs = [db executeQuery:@"SELECT * FROM userCourse WHERE userId=? and isFolder=?", userId, kNum(kFile)];
        //    FMResultSet *brs = [db executeQuery:@"SELECT * FROM userCourse WHERE isFolder=?", kNum(kFile)];
        NSMutableArray *dbCourseArray = [[NSMutableArray alloc] init];
        [OMUPDbutil fillChildItem:dbCourseArray withDB:brs];
        int dbCourseCount = dbCourseArray.count;
        int serverCourseCount = items.count;
        //获取本地课程的最大pageIndex
        int courseIndex = 0;
        NSMutableArray *tempFolderIdArray = [[NSMutableArray alloc] init];
        for (int k=0; k<dbCourseCount; k++) {
            OMCourseItem *tempCourseItem = [dbCourseArray objectAtIndex:k];
            if ([tempCourseItem.folderId isEqualToString:kDefaultFolderId]) {
                courseIndex++;
            }else {
                if (![tempFolderIdArray containsObject:tempCourseItem.folderId]) {
                    [tempFolderIdArray addObject:tempCourseItem.folderId];
                    courseIndex++;
                }
                
            }
        }
        //本地没有的课程，则插入纪录
        for (int i=0; i<serverCourseCount; i++) {
            BOOL isDbExist = NO;    
            NSDictionary *serverCourseItem = [items objectAtIndex:i];
            NSString *serverItemId = [serverCourseItem objectForKey:@"StudentCourseID"];
            for (int j=0; j<dbCourseCount; j++) {
                OMCourseItem *dbCourseItem = [dbCourseArray objectAtIndex:j];
                NSString *dbItemId = dbCourseItem.itemId;
                if ([serverItemId isEqualToString:dbItemId]) {
                    isDbExist = YES;
                    break;
                }
            }
            if (!isDbExist) {
                //modified by zhangcz 2012/10/18
                //插入纪录
                int maxPageN = [self getMaxPageNo:db];
                
                for (int i =0; i<=maxPageN; i++) {
                  int pageIndex = [self getMaxPageIndexByPageNo:db withPageNo:i];
                   
                    if(pageIndex <15){
                        [OMUPDbutil insertData:serverCourseItem withDb:db withPageNo:i withPageIndex:pageIndex+1];
                        break;
                    }
                }

                //modified end
                courseIndex++;
            }
        }
        
        
        //判断一下是否有序号相同的课程，有的话，则全部删除，重新插入
        FMResultSet *r0 = [db executeQuery:@"select count(distinct a.id) from userCourse a inner join userCourse b on (a.folderId = b.folderId or (a.isFolder = 1 and b.folderId='' and b.isFolder = 0) or (b.isFolder = 1 and a.folderId='' and a.isFolder = 0)) and a.pageIndex = b.pageIndex where a.id != b.id and a.userId = b.userId "];
        int count0 = 0;
        if ([r0 next]) {
            //注释 只为测试重复纪录如何出现
            count0 = [r0 intForColumnIndex:0];
        
        }
        if (count0 >= 2) {
        
        }else {
            //本地多余的课程，则删除之
            for (int i=0; i<dbCourseCount; i++) {
                BOOL isDbExist = NO;
                OMCourseItem *dbCourseItem = [dbCourseArray objectAtIndex:i];
                NSString *dbItemId = dbCourseItem.itemId;
                for (int j=0; j<serverCourseCount; j++) {
                    NSDictionary *serverCourseItem = [items objectAtIndex:j];
                    NSString *serverItemId = [serverCourseItem objectForKey:@"StudentCourseID"];
                    if ([serverItemId isEqualToString:dbItemId]) {
                        isDbExist = YES;
                        break;
                    }
                }
                if (!isDbExist) {
                    //删除纪录
                    [db executeUpdate:@"DELETE FROM userCourse where id = ? and userId = ?", dbItemId, userId];
                    [db executeUpdate:@"UPDATE userCourse SET pageIndex=pageIndex-1 WHERE pageNo=? and folderId=? and pageIndex>? and userId=?", kNum(dbCourseItem.pageNo), dbCourseItem.folderId, kNum(dbCourseItem.pageIndex), userId];
                }
            }
            //-------------
            int curCount = 0;//error
            
            FMResultSet * rspageno = [db executeQuery:@"SELECT count(id) FROM userCourse WHERE pageNo=? and folderId=? and userId=?", kNum(maxPageNo), kDefaultFolderId, userId];
            if ([rspageno next]) {
                curCount = [rspageno intForColumnIndex:0];
            }
            curCount = maxPageNo*kPageItemCount+curCount;
            
            
            
            NSString *checkQStr = @"SELECT COUNT(id) from userCourse where id=? and userId=?";
            int checkCount = 0;
            

            for (int j=0; j<items.count; j++) {
                NSDictionary *itemData = [items objectAtIndex:j];
                NSString *itemId = [itemData objectForKey:@"StudentCourseID"];
                rs = [db executeQuery:checkQStr, itemId, userId];
                if ([rs next]) {
                    checkCount = [rs intForColumnIndex:0];
                }
                if (checkCount) {
                    [db executeUpdate:@"UPDATE userCourse SET hasCheck = ? WHERE id = ? and userId=?", kNum(kAfterCheck), itemId, userId];
                }else {
                    [OMUPDbutil insertData:itemData withDb:db withSumIndex:curCount];
                    [db executeUpdate:@"UPDATE userCourse SET hasCheck = ? WHERE id = ? and userId=?", kNum(kAfterCheck), itemId, userId];
                    curCount++;
                }
            }
            
            while ([rs next]) {
                NSString * itemId = [rs stringForColumn:@"id"];
                int pageNo = [rs intForColumn:@"pageNo"];
                NSString * folderId = [rs stringForColumn:@"folderId"];
                int itemPageIndex = [rs intForColumn:@"pageIndex"];

                [db executeUpdate:@"UPDATE userCourse SET pageIndex=pageIndex-1 WHERE pageNo=? and folderId=? and pageIndex>? and userId=?", kNum(pageNo), folderId, kNum(itemPageIndex), userId];
                [db executeUpdate:@"DELETE FROM userCourse where id = ? and userId=?", itemId, userId];
            }
            
            [db executeUpdate:@"UPDATE userCourse SET hasCheck = ? where userId=?", kNum(kBeforeCheck), userId];
            
            rs = [db executeQuery:@"SELECT id, pageNo, pageIndex, title from userCourse where isFolder=? and userId=?", kNum(kFolder), userId];
            while ([rs next]) {
                NSString *folderId = [rs stringForColumnIndex:0];
                int folderPageNo = [rs intForColumnIndex:1];
                int folderPageIndex = [rs intForColumnIndex:2];
                
                FMResultSet *checkFolderRs = [db executeQuery:@"SELECT COUNT(id) FROM userCourse WHERE folderId=? and userId=?", folderId, userId];
                if ([checkFolderRs next]) {
                    int childNum = [checkFolderRs intForColumnIndex:0];
                    if (childNum>0) {
                        continue;
                        
                    }else {
                        [db executeUpdate:@"UPDATE userCourse SET pageIndex=pageIndex-1 WHERE pageNo=? and folderId=? and pageIndex>? and userId=?", kNum(folderPageNo), kDefaultFolderId, kNum(folderPageIndex), userId];
                        [db executeUpdate:@"DELETE FROM userCourse where id = ? and userId=?", folderId, userId];
                    }
                }
            }
            
            for (int i=0; i<maxPageNo; i++) {
                FMResultSet *checkPageRs = [db executeQuery:@"SELECT COUNT(id) FROM userCourse WHERE pageNo=? and userId=?", kNum(i), userId];
                if ([checkPageRs next]){
                    int pageCount = [checkPageRs intForColumnIndex:0];
                    if (!pageCount) {
                        [db executeUpdate:@"UPDATE userCourse SET pageNo = pageNo-1 where userId=?", userId];
                    }
                }
            }
        }
    }else {
        [db executeUpdate:@"DELETE FROM userCourse"];
        for(int i=0; i<items.count; i++) {
            NSDictionary *itemData = [items objectAtIndex:i];
            [OMUPDbutil insertData:itemData withDb:db withSumIndex:i];
        }
    }

    [OMUPDbutil fillChildItem:userCourseArray withDB:db withFolderId:kDefaultFolderId];
    maxPageNo = [OMUPDbutil getMaxPageNo:db];
    
    [db close];
    return maxPageNo;
}*/


/*+ (int) getMaxPageNo: (FMDatabase *)db
{
    int maxPageNo = 0;

    FMResultSet *rspageno = [db executeQuery:@"SELECT MAX(pageNo) FROM userCourse where userId=?", currentUserId];
    if ([rspageno next]) {
        maxPageNo = [rspageno intForColumnIndex:0];
    }
    return maxPageNo;
}


+(int)getMaxPageIndexByPageNo:(FMDatabase *)db withPageNo:(int)pageNo{
    int pageIndex= 0;
    NSString *sql =[NSString stringWithFormat:@"SELECT MAX(pageIndex) FROM userCourse where userId='%@' and pageNo = %d and folderId = ''",currentUserId,pageNo];
    FMResultSet *rspageno = [db executeQuery:sql];
    if ([rspageno next]) {
        pageIndex = [rspageno intForColumnIndex:0];
    }
    
    return pageIndex;
}


+ (void) fillChildItem: (NSMutableArray *)childArray withDB: (FMDatabase *)db withFolderId: (NSString *)folderId
{
    FMResultSet *results = [db executeQuery:@"SELECT * FROM userCourse WHERE folderId=? and userId=? ORDER BY pageIndex ASC", folderId, currentUserId];
    [OMUPDbutil fillChildItem:childArray withDB:results];
}


+ (void) fillChildItem:(NSMutableArray *)childArray withDB:(FMResultSet *)results
{
    while([results next]) {
        NSString *itemId = [results stringForColumn:@"id"];
        NSString *title = [results stringForColumn:@"title"];
        NSString *imgUrl = [results stringForColumn:@"imgUrl"];
        NSString *folderId = [results stringForColumn:@"folderId"];
        
        int type = [results intForColumn:@"type"];
        int pageNo = [results intForColumn:@"pageNo"];
        int pageIndex = [results intForColumn:@"pageIndex"];
        int isFolder = [results intForColumn:@"isFolder"];
        int studyStatus = [results intForColumn:@"studyStatus"];
        

        OMCourseItem *cItem = [[OMCourseItem alloc] init];
        cItem.itemId = itemId;
        cItem.pageNo = pageNo;
        cItem.pageIndex = pageIndex;
        cItem.itemTitle = title;
        cItem.itemImgUrl = imgUrl;
        cItem.courseType = type;
        cItem.isFolder = isFolder;
        cItem.folderId = folderId;
        cItem.studyStatus = studyStatus;
        
        [childArray addObject:cItem];

    }
}

+(void)insertData:(NSDictionary*)itemData withDb:(FMDatabase*)db withPageNo:(int)pageN withPageIndex:(int)pageI{

    int type = ((NSString *)[itemData objectForKey:@"CourseType"]).intValue;
    
    NSString *itemId = [itemData objectForKey:@"StudentCourseID"];
    NSString *title = [itemData objectForKey:@"CourseName"];
    NSString *imgUrl = [itemData objectForKey:@"Imageurl"];
    int pageNo = pageN;
    int pageIndex = pageI;
    int studyStatus = ((NSString *)[itemData objectForKey:@"StudyStatus"]).intValue;
    
    FMResultSet *results = [db executeQuery:@"select count(id) from userCourse where id=? and folderId=? and userId=? and isFolder=0", itemId, kDefaultFolderId, currentUserId];
    if ([results next]) {
        if ([results intForColumnIndex:0] >= 1) {
            return;
        }
    }
        
    NSString *insertStr = @"INSERT INTO userCourse(id, folderId, title, imgUrl, type, pageNo, pageIndex, hasCheck, isFolder, studyStatus, userId) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    [db executeUpdate:insertStr, itemId, kDefaultFolderId, title, imgUrl, [NSNumber numberWithInt:type], [NSNumber numberWithInt:pageNo], [NSNumber numberWithInt:pageIndex], [NSNumber numberWithInt:kBeforeCheck], kNum(kFile), kNum(studyStatus), currentUserId];

}

+ (void) insertData: (NSDictionary *)itemData withDb: (FMDatabase *)db withSumIndex: (int) sumIndex
{
    int type = ((NSString *)[itemData objectForKey:@"CourseType"]).intValue;
    
    NSString *itemId = [itemData objectForKey:@"StudentCourseID"];
    NSString *title = [itemData objectForKey:@"CourseName"];
    NSString *imgUrl = [itemData objectForKey:@"Imageurl"];
    int pageNo = sumIndex/kPageItemCount;
    int pageIndex = sumIndex%kPageItemCount;
    int studyStatus = ((NSString *)[itemData objectForKey:@"StudyStatus"]).intValue;
    
    FMResultSet *results = [db executeQuery:@"select count(id) from userCourse where id=? and folderId=? and userId=? and isFolder=0", itemId, kDefaultFolderId, currentUserId];
    if ([results next]) {
        if ([results intForColumnIndex:0] >= 1) {

            return;
        }
    }
    
    
    NSString *insertStr = @"INSERT INTO userCourse(id, folderId, title, imgUrl, type, pageNo, pageIndex, hasCheck, isFolder, studyStatus, userId) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    [db executeUpdate:insertStr, itemId, kDefaultFolderId, title, imgUrl, [NSNumber numberWithInt:type], [NSNumber numberWithInt:pageNo], [NSNumber numberWithInt:pageIndex], [NSNumber numberWithInt:kBeforeCheck], kNum(kFile), kNum(studyStatus), currentUserId];
}


+ (void) dragToVacant: (FMDatabase *)db withCellIndex: (int)pageIndex withCellPageNo: (int) pageNo withFolderId:(NSString *)folderId
{
    FMResultSet *results = [db executeQuery:@"SELECT COUNT(id) FROM userCourse WHERE pageNo=? and folderId=? and userId=?", kNum(pageNo), folderId, currentUserId];
    int curpageCount = 0;
    if ([results next]) {
        curpageCount = [results intForColumnIndex:0];
    }
    [db executeUpdate:@"UPDATE userCourse set pageIndex=? where pageIndex=? and pageNo=? and folderId=? and userId=?", kNum(curpageCount), kNum(pageIndex), kNum(pageNo), folderId, currentUserId];
    [db executeUpdate:@"UPDATE userCourse set pageIndex=pageIndex-1 where pageIndex>? and pageNo=? and folderId=? and userId=?", kNum(pageIndex), kNum(pageNo), folderId, currentUserId];
    
}



+ (void) switchItem: (FMDatabase *)db withSrcItemId: (NSString *)srcId withTargetItemId: (NSString *) targetId
{
    int srcPageIndex = [OMUPDbutil getPageIndex:db withItemId:srcId];
    int tarPageIndex = [OMUPDbutil getPageIndex:db withItemId:targetId];
    [db executeUpdate:@"UPDATE userCourse set pageIndex=? where id=? and userId=?", kNum(tarPageIndex), srcId, currentUserId];
    [db executeUpdate:@"UPDATE userCourse set pageIndex=? where id=? and userId=?", kNum(srcPageIndex), targetId, currentUserId];
    
}

+ (void) updatePageIndex: (FMDatabase *)db withItemId: (NSString *)itemId withPageIndex:(int)pageIndex
{

    [db executeUpdate:@"UPDATE userCourse set pageIndex=? where id=? and userId=?", kNum(pageIndex), itemId, currentUserId];
}

+ (void) removeItemWhenPaging: (FMDatabase *)db 
                   withPageNo: (int)pageNo 
                withPageIndex: (int)pageIndex 
                 withFolderId: (NSString *)folderId
{

    [db executeUpdate:@"DELETE FROM userCourse WHERE pageNo=? and pageIndex=? and folderId=? and userId=?", kNum(pageNo), kNum(pageIndex), folderId, currentUserId];
    [db executeUpdate:@"UPDATE userCourse SET pageIndex=pageIndex-1 where pageNo=? and folderId=? and pageIndex>? and userId=?", kNum(pageNo), folderId, kNum(pageIndex), currentUserId];
}

+ (void) insertItem: (FMDatabase *)db withCourseItem: (OMCourseItem *)courseItem withIsCheck: (BOOL) isCheck withTotalPage: (int) totalPageNum
{
    //这个添加且移到前面，否则后面又将此cell的pageIndex＋1了
    if (!courseItem.isFolder) {
        //由于是从Folder中拖出来的课程，所以课程身上有FolderId不为空，要清空才行
        if (![courseItem.folderId isEqual:@""]) {
            courseItem.folderId = @"";
        }
    }

    if (isCheck) {
        for (int i=courseItem.pageNo; i<totalPageNum; i++) {
            if (i == courseItem.pageNo) {
              
                [db executeUpdate:@"UPDATE userCourse SET pageIndex=pageIndex+1 where pageNo=? and pageIndex>=? and folderId=? and userId=?", kNum(courseItem.pageNo), kNum(courseItem.pageIndex),  courseItem.folderId, currentUserId];
            }else {
                
                [db executeUpdate:@"UPDATE userCourse SET pageIndex=pageIndex+1 where pageNo=? and folderId=? and userId=?", kNum(i), kDefaultFolderId, currentUserId];
                [db executeUpdate:@"UPDATE userCourse SET pageNo=pageNo+1, pageIndex=0 where pageNo=? and pageIndex=16 and folderId=? and userId=?", kNum(i-1), courseItem.folderId, currentUserId];
            }
            FMResultSet *results = [db executeQuery:@"SELECT count(id) FROM userCourse WHERE pageNo=? and folderId=? and pageIndex=16", kNum(i), kDefaultFolderId];
            if ([results next]) {
                int temp = [results intForColumnIndex:0];
                if (temp == 0) {
                    break;
                }
            }  
        }
    }
    [OMUPDbutil insertItem:db withCourseItem:courseItem];
    if (courseItem.isFolder) {
        [db executeUpdate:@"UPDATE userCourse SET pageNo=? where folderId=? and userId=?", kNum(courseItem.pageNo), courseItem.itemId, currentUserId];
    }
}

+ (void) insertItem:(FMDatabase *)db withCourseItem:(OMCourseItem *)courseItem
{
    
    FMResultSet *results = [db executeQuery:@"select count(id) from userCourse where id=? and folderId=? and userId=?", courseItem.itemId, courseItem.folderId, currentUserId];

    if ([results next]) {
        if ([results intForColumnIndex:0] >= 1) {

            return;
        }
    }
    
    NSString *insertStr = @"INSERT INTO userCourse(id, folderId, title, imgUrl, type, pageNo, pageIndex, hasCheck, isFolder, studyStatus, userId) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    [db executeUpdate:insertStr, courseItem.itemId, 
     courseItem.folderId, 
     courseItem.itemTitle, 
     courseItem.itemImgUrl, 
     kNum(courseItem.courseType), 
     kNum(courseItem.pageNo), 
     kNum(courseItem.pageIndex), 
     kNum(kBeforeCheck), 
     kNum(courseItem.isFolder),
     kNum(courseItem.studyStatus),
     currentUserId];
}


+ (void) updateToFolder:(FMDatabase *)db withItem:(OMCourseItem *)courseItem
{
    
    FMResultSet *results = [db executeQuery:@"select count(id) from userCourse where id=? and folderId=? and userId=?", courseItem.itemId, courseItem.folderId, currentUserId];
    if ([results next]) {
        if ([results intForColumnIndex:0] >= 1) {

            return;
        }
    }
    
    NSString *updateStr = @"UPDATE userCourse set id=?, title=?, imgUrl=?, isFolder=? WHERE pageIndex=? and pageNo=? and folderId=? and userId=?";
    [db executeUpdate:updateStr, courseItem.itemId, courseItem.itemTitle, courseItem.itemImgUrl, kNum(kFolder), kNum(courseItem.pageIndex), kNum(courseItem.pageNo), courseItem.folderId, currentUserId];
}

+ (void) removeItem:(FMDatabase *)db withItem:(OMCourseItem *)courseItem
{

    //这里添加了对纪录是否存在的判断
    FMResultSet *results = [db executeQuery:@"SELECT count(id) FROM userCourse WHERE id=? and folderId=? and userId=?", courseItem.itemId, courseItem.folderId, currentUserId];
    int pageIndex = 0;
    if ([results next]) {
        pageIndex = [results intForColumnIndex:0];
    }
    if (pageIndex == 1) {
        
        NSString *updateStr = @"DELETE FROM userCourse WHERE id=? and folderId=? and userId=?";
        [db executeUpdate:updateStr, courseItem.itemId, courseItem.folderId, currentUserId];
        
        [db executeUpdate:@"UPDATE userCourse set pageIndex=pageIndex-1 where pageNo=? and folderId=? and pageIndex>? and userId=?", kNum(courseItem.pageNo), courseItem.folderId, kNum(courseItem.pageIndex), currentUserId];
        
    }else {

    }
    
    
}


+ (int) getPageIndex: (FMDatabase *)db withItemId: (NSString *)itemId
{
    FMResultSet *results = [db executeQuery:@"SELECT pageIndex FROM userCourse WHERE id=? and userId=?", itemId, currentUserId];
    int pageIndex = 0;
    if ([results next]) {
        pageIndex = [results intForColumnIndex:0];
    }
    return pageIndex;
}*/






/*+(BOOL)excuDB:(NSString*)stmt withDB:(FMDatabase*)db {
    
    BOOL isOK = [db executeUpdate:stmt];
    
    return isOK;
}



+ (BOOL) saveTitleForCourseItem: (OMCourseItem *)courseItem
{
    FMDatabase *db = [self openDB];
    [db executeUpdate:@"UPDATE userCourse set title=? where id=? and userid=?", courseItem.itemTitle, courseItem.itemId, currentUserId];
    [db close];
    return YES;
}

+(int)exceQueryMinId:(NSString *)stmt  withDB:(FMDatabase *)db{
    FMResultSet *set = [db executeQuery:stmt];
    int _id  = 0;
    while([set next]){
        _id = [[set objectForColumnIndex:0] intValue];
    }
    [set close];
    return _id;
}


+ (NSArray *) searchCourse: (FMDatabase *)db withText: (NSString *)searchText withArray: (NSMutableArray *)searchArray
{
    FMResultSet *results = [db executeQuery:@"SELECT * FROM userCourse WHERE title LIKE ? and userId=?", [NSString stringWithFormat:@"%%%@%%",searchText], currentUserId];
    [OMUPDbutil fillChildItem:searchArray withDB:results];
    return nil;
}


+ (void) log: (FMDatabase *)db withPageNo: (int) i
{
    FMResultSet *results = [db executeQuery:@"SELECT pageIndex, title FROM userCourse WHERE pageNo=? and folderId=? and userId=?", kNum(i), kDefaultFolderId, currentUserId];
    while([results next]) {

    }
}*/




@end