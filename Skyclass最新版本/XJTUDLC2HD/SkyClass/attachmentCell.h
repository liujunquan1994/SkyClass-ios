//
//  attachmentCell.h
//  skyclass
//
//  Created by skyclass on 15/12/1.
//
//

#import <UIKit/UIKit.h>
#import "AFDownloadRequestOperation.h"
@interface attachmentCell : UIView<UIDocumentInteractionControllerDelegate>

//导学资料列表
@property(nonatomic,strong)NSMutableArray * attachmentList;
@property(nonatomic,strong)NSMutableArray * articleID;
@property(nonatomic,strong)NSMutableArray * attachmentPath;
@property(nonatomic,strong)NSMutableArray * attachmentStatus;  //0 表示没下载，1表示已下载
//导学资料下载cell控件
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIButton * openBtn;
@property(nonatomic,strong)UIButton * deleteBtn;
@property(nonatomic,strong)UIButton * downloadBtn;
@property(nonatomic,assign)BOOL isDownload;
@property(nonatomic,strong)UIProgressView * progress;
@property(strong,nonatomic)AFDownloadRequestOperation *operation;
@property(nonatomic,strong)NSString * oneAttachmentPath;
@property(nonatomic,strong)NSString * courseID;
//用于存储下载，删除，打开状态
@property(nonatomic,strong)NSUserDefaults *statusDefaults;
@property(nonatomic,strong,retain)UIDocumentInteractionController* documentController;
-(void)initWith:(NSString *)courseID tag:(NSInteger)tag;
@end
