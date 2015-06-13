//
//  ViewController.m
//  音视频Demo
//
//  Created by pangfuli on 14-10-11.
//  Copyright (c) 2014年 pflnh. All rights reserved.
//

#import "ViewController.h"
#import "MyPlayerView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ASIHTTPRequest.h"


@interface ViewController ()<ASIHTTPRequestDelegate,ASIProgressDelegate>
{
    MPMoviePlayerController *controller;
}
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *item;
@property (nonatomic, strong) MyPlayerView *playerView;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, assign) long long total;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, assign) long long curTime;
@property (nonatomic, strong) MPMoviePlayerViewController *controller1;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, assign) CGFloat tempValue;
@property (nonatomic, strong) UILabel *currenLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) MPVolumeView *volumeView;
@property (nonatomic, strong) ASIHTTPRequest *request;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) unsigned long long recordDull;
@property (nonatomic, strong) UISlider *label;
@property (nonatomic, strong)  UIButton *btn;
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
       // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinish) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    }
    return self;
}

- (void)playFinish
{
    [_request cancel];
    _request = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    NSString *str = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";//@"http://hot.vrs.sohu.com/ipad1340910.m3u8";
    NSURL *url = [NSURL URLWithString:str];
    _url = url;
   // [self addPlayer:_url];
    [self initUI];
    
}

- (void)addPlayer:(NSURL*)url
{
    if (self.item == nil) {
        self.item = [[AVPlayerItem alloc]initWithURL:url];
        self.player = [[AVPlayer alloc]initWithPlayerItem:self.item];
        self.playerView = [[MyPlayerView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:self.playerView];
        self.playerView.player = _player;
        _player.volume = 0.5f;
        [_player play];
        
        [self.view sendSubviewToBack:self.playerView];
        [self.item addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    }
    return ;
    
}
- (void)initUI
{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(80, self.view.frame.size.height - 104, self.view.frame.size.width - 160, 44)];
    _btn = btn;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"play" forState:(UIControlStateNormal)];
    
    UIProgressView *progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(20, btn.frame.origin.y - 60, self.view.frame.size.width - 40, 44)];
    progressView.progressTintColor = [UIColor redColor];
    progressView.trackTintColor = [UIColor purpleColor];
    self.progressView = progressView;
    [self.view addSubview:progressView];
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(40, progressView.frame.origin.y + progressView.frame.size.height, self.view.frame.size.width - 80, 44)];
    _slider = slider;
    slider.tag = 100;
    [slider addTarget:self action:@selector(sliderChangeValue:) forControlEvents:(UIControlEventValueChanged)];
    
    [self.view addSubview:_slider];
    
    self.currenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, slider.frame.origin.y, 40, slider.frame.size.height)];
    self.currenLabel.font = [UIFont systemFontOfSize:10];
    self.currenLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.currenLabel];
    
    self.totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(slider.frame.origin.x + slider.frame.size.width, slider.frame.origin.y, 40, slider.frame.size.height)];
    self.totalLabel.font = [UIFont systemFontOfSize:10];
    self.totalLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.totalLabel];
    
    UISlider *slideVolume = [[UISlider alloc]initWithFrame:CGRectMake(_slider.frame.origin.x, btn.frame.origin.y - 20, _slider.frame.size.width, 10)];
    slideVolume.tag = 200;
    [slideVolume addTarget:self action:@selector(sliderChangeValue:) forControlEvents:(UIControlEventValueChanged)];
    slideVolume.value = 0.5f;
    [self.view addSubview:slideVolume];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, btn.frame.origin.y + btn.frame.size.height + 10, self.view.frame.size.width - 80, 44)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = [UIColor redColor];
    timeLabel.backgroundColor = [UIColor greenColor];
    timeLabel.text = [NSString stringWithFormat:@"%02D:%02d",0,0];
    [self.view addSubview:timeLabel];
    self.timeLable = timeLabel;
    
     _label = [[UISlider alloc]initWithFrame:CGRectMake(20, 80, self.view.frame.size.width - 40, 44)];
    
    
   
}

- (void)sliderChangeValue:(UISlider*)slider
{
    if (slider.tag == 100) {
        CGFloat value = _total * slider.value;
        CMTime time = _item.currentTime;
        time.value = value * time.timescale;
        [_item seekToTime:time];
    }
    else
    {
        _player.volume = slider.value;
    }

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"status"])
    {
        if ([change[@"new"] integerValue] == AVPlayerStatusReadyToPlay)
        {
            // 解决循环引用
            ViewController *ctl = self;
            [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1,1) queue:nil usingBlock:^(CMTime time) {
                ctl.total = ctl.item.duration.value/ctl.item.duration.timescale;
                ctl.curTime = time.value/time.timescale;
               // ctl.curTime = ctl.item.currentTime.value / ctl.item.currentTime.timescale;
                ctl.progressView.progress = (CGFloat)ctl.curTime/ctl.total;
                
                ctl.slider.value = (CGFloat)ctl.curTime/ctl.total;
                ctl.currenLabel.text = [NSString stringWithFormat:@"%02lld:%02lld",ctl.curTime/60,ctl.curTime%60];
                ctl.totalLabel.text = [NSString stringWithFormat:@"%02lld:%02lld",ctl.total/60,ctl.total%60];
               // ctl.timeLable.text = [NSString stringWithFormat:@"%02lld:%02lld",ctl.curTime/60,ctl.curTime%60];
               // 倒计时
                ctl.timeLable.text = [NSString stringWithFormat:@"%02lld:%02lld",(ctl.total - ctl.curTime)/60,(ctl.total - ctl.curTime)%60];
            
            }];
            
            
        }
    }
    
    
}



- (void)btnClick:(UIButton*)btn
{
    
    ViewController *ctl = self;
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents/Temp"];
    NSString *dePath = [NSHomeDirectory() stringByAppendingString:@"/Library/Private Documents/Cache"];
    NSLog(@"path =%@",dePath);
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:dePath]) {
        [manager createDirectoryAtPath:dePath withIntermediateDirectories:YES attributes:nil error:nil];
    }

    if ([manager fileExistsAtPath:[dePath stringByAppendingPathComponent:[NSString stringWithFormat:@"video.mp4"]]]) {
#if 1
    [self addPlayer:[NSURL fileURLWithPath:[dePath stringByAppendingPathComponent:@"video.mp4"]]];
#endif
#if 0
         MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:[dePath stringByAppendingPathComponent:@"video.mp4"]]];
         [self presentMoviePlayerViewControllerAnimated:playerViewController];
#endif
    }
    else
    {
        if (_request == nil) {
            
        
           _request = [[ASIHTTPRequest alloc]initWithURL:_url];
         
            // 设置临时文件路径
            [_request setTemporaryFileDownloadPath:[path stringByAppendingPathComponent:[NSString stringWithFormat:@"video.mp4"]]];
            // 设置下载完成后的文件路径
            [_request setDownloadDestinationPath:[dePath stringByAppendingPathComponent:[NSString stringWithFormat:@"video.mp4"]]];
            
            [_request setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {
                _recordDull += size;
                     NSLog(@"record=%lld",_recordDull);
                if (_recordDull > 40000 && !_isPlay) {
                    [ctl addPlayer:[NSURL URLWithString:@"http://127.0.0.1:12345/video.mp4"]];
                    //[ctl play1];
                    _isPlay = !_isPlay;
                }

            }];
            
            // 开启断点续传
            [_request setAllowResumeForFileDownloads:YES];
            [_request startAsynchronous];
       }
    }
    if (self.isPlay)
    {
        [btn setTitle:@"play" forState:(UIControlStateNormal)];
        [self.player pause];
    }
    else
    {
        [btn setTitle:@"pause" forState:(UIControlStateNormal)];
        [self.player play];
    }
    self.isPlay = !self.isPlay;
//    NSLog(@"%d",self.isPlay);
    
    
}

- (void)videoPlay{
    NSString *webPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents/Temp"];
    NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents/Cache"];
    NSLog(@"%@",cachePath);
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:cachePath])
    {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([fileManager fileExistsAtPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]]) {
        NSLog(@"----%ld",[NSData dataWithContentsOfURL:[NSURL URLWithString:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]]].length);
        MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]]];
        
        [self presentMoviePlayerViewControllerAnimated:playerViewController];
        
        
    }else{
        ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:_url];
       
        //下载完存储目录
        [request setDownloadDestinationPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]];
        //临时存储目录
        [request setTemporaryFileDownloadPath:[webPath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]];
        [request setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {
          
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setDouble:total forKey:@"file_length"];
            _recordDull += size;//Recordull全局变量，记录已下载的文件的大小
            if (!_isPlay&&_recordDull > 400000) {
                _isPlay = !_isPlay;
                [self playVideo];
            }
            NSLog(@"%lld",_recordDull);
        }];
        //断点续载
        [request setAllowResumeForFileDownloads:YES];
        [request startAsynchronous];
        _request = request;
    }
}
- (void)playVideo{
    MPMoviePlayerViewController *playerViewController =[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://127.0.0.1:12345/vedio.mp4"]];
    [self presentMoviePlayerViewControllerAnimated:playerViewController];
}







- (void)setProgress:(float)newProgress
{
   
     NSLog(@"newProgress=%f",newProgress);
    _label.value = newProgress;
   
    [self.view addSubview:_label];
}
- (void)play1
{
    
    

    
    
#if 1
    //系统自带播放
    MPMoviePlayerViewController *playerViewController =[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://127.0.0.1:12345/video.mp4"]];
    [self presentMoviePlayerViewControllerAnimated:playerViewController];

    
//   
//    MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:_url];
//    [self presentMoviePlayerViewControllerAnimated:playerViewController];

    
    
  
#endif
}



@end








