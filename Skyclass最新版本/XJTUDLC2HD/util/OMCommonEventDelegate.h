//
//  OMCommonEventDelegate.h
//  meos-i
//
//  Created by mason ma on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#define CMD_PLAY_PAUSE 100
#define CMD_PLAY_STOP 101
#define CMD_PLAY_RUN 102
#define CMD_PLAY_START 103
#define CMD_GOBACK_COURSE 104
#define CMD_DELAY_HIDE 105        //延时隐藏
#define CMD_SHOW_PLAYLAYER 106
#define CMD_SLIDER_MOVED 107
#define CMD_SLIDER_DONE 108
#define CMD_NEW_VIDEO 109
#define CMD_NEW_VIDEO_DONE 110
#define CMD_NEW_LABEL 111
#define CMD_NEW_LABEL_DONE 112

#define CMD_SHOW_TEACHER_LABEL 113
#define CMD_SHOW_TEACHER_VIDEO 114
#define CMD_CLOSE_TEACHER_LABEL 115
#define CMD_CLOSE_TEACHER_VIDEO 116

#define CMD_SHOW_STUDENT_LABEL 117
#define CMD_SHOW_STUDENT_VIDEO 118
#define CMD_CLOSE_STUDENT_LABEL 119
#define CMD_CLOSE_STUDENT_VIDEO 120

#define CMD_SHOW_ATTENTION_LIST 121
#define CMD_CLOSE_ATTENTION_LIST 122

#define CMD_ALL_VIEW_PLAY_MOVIE 123 //使用标准播放器 播放视频
#define CMD_ALL_VIEW_PLAY_MOVIE_DONE 124

#define CMD_PLAY_START_NOTE_VIDEO 125
//在剪辑的播放列表中，“结束”播放视频；
#define CMD_END_CUTTING_PLAY 126
//在剪辑的播放列表中，“开始”播放视频；
#define CMD_START_CUTTING_PLAY 127
//新建截图
#define CMD_NEW_SNAPSHOT 128
//新建截图 完成
#define CMD_NEW_SNAPSHOT_DONE 129
//编辑截图
#define CMD_EDIT_SNAPSHOT 130



@protocol OMCommonEventDelegate <NSObject>

@optional
@required
-(void)evented:(NSObject *)sender command:(NSInteger)command paras:(NSArray *)paras;

@end
