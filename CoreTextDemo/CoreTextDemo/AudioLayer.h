//
//  AudioLayer.h
//  CoreTextDemo
//
//  Created by pfl on 15/1/12.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>


typedef void(^callBackStateBlock)(AVAudioPlayer *play);

@interface AudioLayer : CALayer

- (instancetype)initWithAudioFileURL:(NSURL*)URL;


@property (nonatomic,assign)  float volume;
@property (nonatomic, strong) AVAudioPlayer *player;

- (void)play;
- (void)stop;
- (void)pause;
- (BOOL)isPlaying;


- (void)callBackStateAudioState:(callBackStateBlock)block;

@end


















