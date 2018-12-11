//
//  VideoPlayerVC.h
//  IphonePlayer
//
//  Created by skyclass on 15/10/25.
//  Copyright © 2015年 skyclass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerVC : UIViewController
@property(nonatomic,strong)NSURL * url;
@property(nonatomic,assign)BOOL * isOnline;//是否时在线视频
@end
