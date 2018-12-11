//
//  VideoPlayerVC.m
//  IphonePlayer
//
//  Created by skyclass on 15/10/25.
//  Copyright © 2015年 skyclass. All rights reserved.
//

#import "VideoPlayerVC.h"
#import "VideoPlayerView.h"
#import "MBProgressHUD.h"
@interface VideoPlayerVC (){

    BOOL _played;
    NSString *_totalTime;
    NSDateFormatter *_dateFormatter;   //格式化NSDate
    MBProgressHUD *HUD;

}

@property (weak, nonatomic) IBOutlet VideoPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UISlider *videoSlider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *videoProgress;
@property (weak, nonatomic) IBOutlet UIView *frontView;

@property (nonatomic ,strong) id playbackTimeObserver;
@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;

- (IBAction)closeVideo:(id)sender;
- (IBAction)videoStatusChange:(id)sender;

- (IBAction)videoSliderChangeValue:(id)sender;
- (IBAction)videoSliderChangeValueEnd:(id)sender;
@end

@implementation VideoPlayerVC
//隐藏电池状态栏
-(BOOL)prefersStatusBarHidden{

    return YES;
}
//懒加载 dateFormatter
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}



- (void)viewDidLoad {
    [super viewDidLoad];
   // http://202.117.16.190:8134/hls-live/livepkgr/_definst_/livestreamvideo8248/livestreamvideo8248.m3u8
   // NSURL *videoUrl = [NSURL URLWithString:@"http://kj.xjtudlc.com/YC/js005/45/screen.mp4"];
   // NSURL *videoUrl = self.url;
    NSLog(@"self.url %@",self.url);
    AVAsset * videoAsset = [AVURLAsset URLAssetWithURL:self.url options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:videoAsset];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.statusButton.enabled = NO;
    if([[UIDevice currentDevice] systemVersion].intValue>=10){
        //      增加下面这行可以解决iOS10兼容性问题了
        self.player.automaticallyWaitsToMinimizeStalling = NO;
    }
    NSLog(@"##iOS系统版本version = %@##",[[UIDevice currentDevice] systemVersion].intValue);
    
    // 添加视频播放结束通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
    
    [self.view bringSubviewToFront:self.frontView];
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"加载中";
    [HUD show:YES];
    //[HUD hide:YES afterDelay:30.0f];//防止出现一直在加载的情况出现


}

- (Boolean)isPlaying
{
    if([[UIDevice currentDevice] systemVersion].intValue>=10){
        return self.player.timeControlStatus == AVPlayerTimeControlStatusPlaying;
    }else{
        return self.player.rate==1;
    }
}

/**
 *  keyPath:被观察的属性，其不能为nil
 *  object:被观察者的对象
 *  change:属性值，根据上面提到的options设置，给出对应的属性值
 *  context:上面传递的context对象
 *
 *
 */
#pragma mark  KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    [HUD hide:YES];
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
           
            self.statusButton.enabled = YES;
            if (!self.isOnline) {
                CMTime duration = self.playerItem.duration;// 获取视频总长度
                CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
                _totalTime = [self convertTime:totalSecond];// 转换成播放时间
                [self customVideoSlider:duration];// 自定义UISlider外观
                NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));

            }
            
            [self monitoringPlayback:self.playerItem];// 监听播放状态
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"加载失败" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        
        NSLog(@"Time Interval:%f",timeInterval);
        
        CMTime duration = _playerItem.duration;//获取的视频总长度
        
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        //已加载的视频占的百分比
        [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
        //[self.videoProgress setProgress:timeInterval  animated:YES];
        
    }
}

#pragma mark 监听播放状态
- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    
    __weak typeof(self) weakSelf = self;
    //设置每隔一秒监控播放时间变化，利用kvo让进度条监听播放时间的变化
    self.playbackTimeObserver = [self.playerView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        [weakSelf.videoSlider setValue:currentSecond animated:YES];//slider设置值
        NSString *timeString = [self convertTime:currentSecond];
        //timelabel上显示的时间
        if (self.isOnline) {
           
            weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@",timeString];
        }else{
            
            weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeString,_totalTime];
        }
        
    }];
}


#pragma mark 计算已加载的缓存
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.playerView.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}
#pragma mark 默认的slider设置
- (void)customVideoSlider:(CMTime)duration {
    self.videoSlider.maximumValue = CMTimeGetSeconds(duration);
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //设置拖动条已完成部分的轨道图片
    [self.videoSlider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
    //设置拖动条未完成部分的轨道图片
    [self.videoSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
}

#pragma mark  设置显示时间格式
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}
#pragma mark 更新videoslider
- (void)updateVideoSlider:(CGFloat)currentSecond {
    [self.videoSlider setValue:currentSecond animated:YES];
}

#pragma mark 结束播放
- (void)moviePlayDidEnd:(NSNotification *)notification {
    NSLog(@"Play end");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
   }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark 点击按钮的方法

- (IBAction)closeVideo:(id)sender {
   
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

- (IBAction)videoStatusChange:(id)sender {
    
    if (!_played) {
        [self.playerView.player play];
        //[self.stateButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.statusButton setImage:[UIImage imageNamed:@"Play" ]  forState:UIControlStateNormal];
    } else {
        [self.playerView.player pause];
        //[self.stateButton setTitle:@"Play" forState:UIControlStateNormal];
        [self.statusButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
    }
    _played = !_played;

    
}
- (IBAction)videoSliderChangeValue:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSLog(@"value change:%f",slider.value);
    __weak typeof(self) weakSelf = self;
    [weakSelf.playerView.player pause];
    [weakSelf.statusButton setImage:[UIImage imageNamed:@"Pause" ]  forState:UIControlStateNormal];
     _played = NO;
    if (slider.value == 0.000000) {
            [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
            [weakSelf.playerView.player play];
        }];
    }

}

- (IBAction)videoSliderChangeValueEnd:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSLog(@"value end:%f",slider.value);
    CMTime changedTime = CMTimeMakeWithSeconds(slider.value, 1);
    
    //__weak typeof(self) weakSelf = self;
    [self.playerView.player seekToTime:changedTime completionHandler:^(BOOL finished) {
        //[weakSelf.playerView.player pause];
       // [weakSelf.statusButton setImage:[UIImage imageNamed:@"Pause" ]  forState:UIControlStateNormal];
    }];

}

#pragma mark 程序结束时的方法
/*
- (void)dealloc {
   // [super dealloc];
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [self.playerView.player removeTimeObserver:self.playbackTimeObserver];
    [self.playerView.player pause];
    self.playerView.player = nil;
    NSLog(@"%s--",__func__);
}

*/
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [self.playerView.player removeTimeObserver:self.playbackTimeObserver];
    [self.playerView.player pause];
    self.playerView.player = nil;
    NSLog(@"%s--",__func__);

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
