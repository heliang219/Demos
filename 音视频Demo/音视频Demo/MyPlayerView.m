//
//  MyPlayerView.m
//  音视频Demo
//
//  Created by pangfuli on 14-10-11.
//  Copyright (c) 2014年 pflnh. All rights reserved.
//

#import "MyPlayerView.h"

@implementation MyPlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


+(Class)layerClass
{
    return [AVPlayerLayer class];
}

- (void)setPlayer:(AVPlayer *)player
{
    AVPlayerLayer *layer = (AVPlayerLayer*)self.layer;
    layer.player = player;
    
}

- (AVPlayer*)player
{
    AVPlayerLayer *layer = (AVPlayerLayer*)self.layer;
    return layer.player;
}

@end













