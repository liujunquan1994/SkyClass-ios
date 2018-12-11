//
//  AdvertisingColumn.h
//  CustomTabBar
//
//  Created by shikee_app05 on 14-12-30.
//  Copyright (c) 2014年 chan kaching. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface AdvertisingColumn : UIView<UIScrollViewDelegate>{
    
    NSTimer *_timer;
}

//广告栏
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UILabel *imageNum;
@property (nonatomic) NSInteger totalNum;
@property(nonatomic ,strong)UIButton *btn;
@property(nonatomic)NSArray *slideText;
@property(nonatomic)NSArray *urlArray;
@property(nonatomic,strong) MPMoviePlayerViewController *movieplayer;
- (void)setArray:(NSArray *)imgArray textArray:(NSArray *)text urlArray:(NSArray *) url;

- (void)openTimer;
- (void)closeTimer;


@end
