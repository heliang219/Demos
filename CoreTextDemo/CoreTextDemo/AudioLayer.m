//
//  AudioLayer.m
//  CoreTextDemo
//
//  Created by pfl on 15/1/12.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "AudioLayer.h"




@interface AudioLayer ()


@property (nonatomic, copy) callBackStateBlock callBackStateBlock;
@end


@implementation AudioLayer

@dynamic volume;

- (instancetype)initWithAudioFileURL:(NSURL *)URL
{
    if (self = [self init]) {
        
        self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:URL error:NULL];
        
        [self setNeedsDisplay];
    }
    
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        self.volume = .1f;
        
    }
    return self;
}

- (instancetype)initWithLayer:(id)layer
{
    if (self = [super initWithLayer:layer]) {
        
    }
    return self;
}

- (void)play
{
    [self.player play];
    
}

- (void)stop
{
    [self.player stop];
}


- (BOOL)isPlaying
{
    if (_callBackStateBlock) {
        _callBackStateBlock(self.player);
    }
    return self.player.isPlaying;
}


- (void)pause
{
    [self.player pause];
}

- (void)display
{
    
    NSLog(@"volume: %f", [self.presentationLayer volume]);
    self.player.volume = [[self presentationLayer] volume];
    
}

- (id<CAAction>)actionForKey:(NSString *)event
{
    if ([event isEqualToString:@"volume"]) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:event];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        anim.fromValue = @([self.presentationLayer volume]);
        return anim;
    }
    
    
    return [super actionForKey:event];
}


+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"volume"]) {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}


- (void)callBackStateAudioState:(callBackStateBlock)block
{
    
    _callBackStateBlock = block;
    
}

@end

















