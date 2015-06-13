//
//  AudioView.m
//  CoreTextDemo
//
//  Created by pfl on 15/1/12.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "AudioView.h"
#import "AudioLayer.h"

@interface AudioView ()
@property (nonatomic, strong) AudioLayer *audioLayer;
@end

@implementation AudioView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.audioLayer.volume = .1f;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"黄沾 - 为自己当好汉.mp3" ofType:nil];
        
        self.audioLayer = [[AudioLayer alloc]initWithAudioFileURL:[NSURL fileURLWithPath:path]];
        
        
        [self addSubviews];
        
    }
    return self;
}

+ (Class)layerClass
{
    return [AudioLayer class];
}

- (void)addSubviews
{
    UIButton *playBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 150, 100, 44)];
    [playBtn setTitle:@"play" forState:UIControlStateNormal];
    playBtn.backgroundColor = [UIColor redColor];
    [playBtn addTarget:self action:@selector(playMusic:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:playBtn];
    
    UIButton *addVolume = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(playBtn.frame), CGRectGetMinY(playBtn.frame), 100, 44)];
    [addVolume addTarget:self action:@selector(addVolume:) forControlEvents:(UIControlEventTouchUpInside)];
    [addVolume setBackgroundColor:[UIColor purpleColor]];
    [addVolume setTitle:@(self.audioLayer.volume).stringValue forState:(UIControlStateNormal)];
    
    [self addSubview:addVolume];
    
    
    
    
}

- (void)playMusic:(UIButton*)btn
{
    if (self.audioLayer.isPlaying) {
        [self.audioLayer stop];
        [btn setTitle:@"play" forState:(UIControlStateNormal)];
    }else
    {
        [self.audioLayer play];
        [btn setTitle:@"stop" forState:(UIControlStateNormal)];
    }
    

}

- (void)addVolume:(UIButton*)btn
{
    self.audioLayer.volume = .8f;
    [btn setTitle:@(self.audioLayer.volume).stringValue forState:(UIControlStateNormal)];
    
}



@end
