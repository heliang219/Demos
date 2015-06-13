//
//  RootViewController.m
//  CoreTextDemo
//
//  Created by pfl on 15/1/7.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "RootViewController.h"
#import "MyCoreTextView.h"
#import "DrawView.h"
#import "PieLayer.h"
#import "PieLayer1.h"
#import "AudioView.h"
#import "AudioLayer.h"
#import <AVFoundation/AVFoundation.h>
#import "VerifyRegexTool.h"

#define kAngle(degree) ((degree)*M_PI)/180
@interface RootViewController ()<AVAudioPlayerDelegate>
{
    DrawView *_drawView;
    NSArray *_itemsArr;
    NSArray *_colorArr;
    UIButton *_selectBtn;
    NSTimer *_timer;
}

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) AudioLayer *audioLayer;
@property (nonatomic, strong) UIProgressView *progress;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    MyCoreTextView *view = [[MyCoreTextView alloc]initWithFrame:CGRectMake(0, 164, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    

    view.text = @"下面主要讲，如何设置字体，间距，并计算（带特定段间距，行间距，字间距，字大小）文字的高度。";

    
    DrawView *drawView = [[DrawView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:drawView];
    
    
    
//    CATransition *transition = [CATransition animation];
//    
//    transition.type = kCATransitionPush;
//    transition.duration = .5;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [drawView.layer addAnimation:transition forKey:nil];
    
    
           
//    [self animateFromStartAngle:kAngle(0) toStartAngle:kAngle(0) fromEndAngle:kAngle(180) toEndAngle:kAngle(360)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(run1)];
    
//    AudioView *audio = [[AudioView alloc]initWithFrame:self.view.frame];
////    [self.view addSubview:audio];
//    
//    
//  
//    
//    self.audioLayer.volume = .1f;
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"黄沾 - 为自己当好汉.mp3" ofType:nil];
//    
//    self.audioLayer = [[AudioLayer alloc]initWithAudioFileURL:[NSURL fileURLWithPath:path]];
//    
//    
//    
//    [self.view.layer addSublayer:self.audioLayer];
//    
//    
//    self.audioLayer.player.delegate = self;
//    
//    [self.audioLayer callBackStateAudioState:^(AVAudioPlayer *play) {
//        NSLog(@"=======play====%f",play.duration);
//        _player = play;
//            }];
    
//    [self addSubviews];
    
    
    
//    [self addBtn];
    
    
    
    
//    [self savePictureFromCurrentontext];
    
}


- (void)savePictureFromCurrentontext
{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    btn.backgroundColor = [UIColor redColor];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    
    [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn setTitle:@"save" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(savePic:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}


- (void)savePic:(UIButton*)btn
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        

        
    });
    
    
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(NSDictionary*)info
{
    
    NSLog(@"error :%@",error.localizedDescription);
    
    
}

- (void)addBtn
{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 50, 12)];
    btn.center = self.view.center;
    [self.view addSubview:btn];
//    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"七十二变" forState:(UIControlStateNormal)];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [btn setTitleColor:[UIColor purpleColor] forState:(UIControlStateNormal)];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @(0);
    animation.toValue = @200;
    animation.duration = 10;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
//    [btn.layer addAnimation:animation forKey:nil];
    
    
    CABasicAnimation *scaleAnimationX = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleAnimationX.fromValue = @(.2);
    scaleAnimationX.toValue = @(5.9);
    scaleAnimationX.duration = 10.0;
    scaleAnimationX.fillMode = kCAFillModeForwards;
    
    
    CABasicAnimation *scaleAnimationY = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleAnimationY.fromValue = @(.2);
    scaleAnimationY.toValue = @(5.9);
    scaleAnimationY.duration = 10.0;
    scaleAnimationY.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotation.fromValue = @(0);
    rotation.toValue = @(M_PI * 6);
    rotation.duration = 10.0f;
    rotation.repeatCount = 1;
    rotation.fillMode = kCAFillModeForwards;
    
    
    
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animation];
    keyFrame.fillMode = kCAFillModeForwards;
    keyFrame.path = CFAutorelease(CGPathCreateWithEllipseInRect(CGRectMake(0, 0, 250, 250), NULL));
    keyFrame.duration = 10.0f;
    keyFrame.keyPath  = @"position";
    keyFrame.additive = YES;
    keyFrame.repeatCount = HUGE_VAL;
    keyFrame.rotationMode = kCAAnimationRotateAuto;
    keyFrame.calculationMode = kCAAnimationPaced;
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0; i < 10; i++) {
        [arr addObject:@(i)];
    }
    
    
    NSString *st =  [arr componentsJoinedByString:@","];
    NSLog(st);
    
    NSString *idCard = @"450324198403195518";
    BOOL isVerify = [VerifyRegexTool verifyIDCardNumber:idCard];
    
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animation];
    scaleAnimation.additive = YES;
    scaleAnimation.values = @[@.2,@2.9,@(5.9),@2.9,@.2];
    scaleAnimation.keyTimes = @[@0,@.2,@.5,@.7,@1];
    scaleAnimation.duration = 10;
    scaleAnimation.keyPath = @"transform.scale.x";
    
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[/*scaleAnimationX,rotation,scaleAnimationY,keyFrame,*/scaleAnimation];
    group.repeatCount = 10;
    group.duration = 10.0f;
    [btn.layer addAnimation:group forKey:nil];
    
    
    
    
    
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"===========");
    [_timer invalidate];
//    [_timer setNilValueForKey:nil];
    _timer = nil;

}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    
}



- (void)addSubviews
{
    UIButton *playBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 150, 100, 44)];
    [playBtn setTitle:@"play" forState:UIControlStateNormal];
    playBtn.backgroundColor = [UIColor redColor];
    [playBtn addTarget:self action:@selector(playMusic:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:playBtn];
    
    UIButton *addVolume = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(playBtn.frame), CGRectGetMinY(playBtn.frame), 100, 44)];
    [addVolume addTarget:self action:@selector(addVolume:) forControlEvents:(UIControlEventTouchUpInside)];
    [addVolume setBackgroundColor:[UIColor purpleColor]];
    [addVolume setTitle:@(self.audioLayer.volume).stringValue forState:(UIControlStateNormal)];
    _selectBtn = addVolume;
    
    
    [self.view addSubview:addVolume];
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(playBtn.frame) + 20, CGRectGetWidth(self.view.frame)-40, 10)];
    [self.view addSubview:slider];
    
    slider.value = .2;
    slider.minimumValue = 0.f;
    slider.maximumValue = 1.0f;
    [slider addTarget:self action:@selector(slider:) forControlEvents:(UIControlEventValueChanged)];
    
    UIProgressView *progress = [[UIProgressView alloc]initWithProgressViewStyle:(UIProgressViewStyleBar)];
    [self.view addSubview:progress];
    progress.frame = CGRectMake(20, CGRectGetMaxY(slider.frame) + 20, CGRectGetWidth(slider.frame), 20);
    progress.progressTintColor = [UIColor redColor];
    progress.trackTintColor = [UIColor yellowColor];
    _progress = progress;
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizer:)];
    [self.view addGestureRecognizer:pan];
    
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTime:) userInfo:nil repeats:YES];
    _timer = timer;
    [timer fire];
}


- (void)timerTime:(NSTimer*)timer
{
    _progress.progress = _player.currentTime/_player.duration;
//    if (_progress.progress == 1) {
//        [timer invalidate];
//    }
}


CGPoint tem ;

- (void)panGestureRecognizer:(UIPanGestureRecognizer*)pan
{
    CGPoint velocity = [pan velocityInView:pan.view];
    
//    if (velocity.x > 0 || velocity.y > 0) {
//        self.audioLayer.volume += .1;
//        if (self.audioLayer.volume > 1.0) {
//            self.audioLayer.volume = 1.0f;
//        }
//    }
//    else
//    {
//         self.audioLayer.volume -= .1;
//        if (self.audioLayer.volume < 0.0) {
//            self.audioLayer.volume = 0.0f;
//        }
//    }
//    tem = CGPointZero;
    
    CGPoint touch = [pan translationInView:pan.view];
     NSLog(@"touch = %@",NSStringFromCGPoint(touch));
    if (touch.x > tem.x || touch.y < tem.y) {
        self.audioLayer.volume += (touch.x - tem.x)/self.view.frame.size.width || (-touch.y + tem.y)/self.view.frame.size.height ;
        if (self.audioLayer.volume > 1.0) {
            self.audioLayer.volume = 1.0f;
        }
    }else
    {
        self.audioLayer.volume -= -(touch.x - tem.x)/self.view.frame.size.width || -(-touch.y + tem.y)/self.view.frame.size.height;
        if (self.audioLayer.volume < 0.0) {
            self.audioLayer.volume = 0.0f;
        }
    }
    tem = touch;
    
    NSLog(@"tem = %@",NSStringFromCGPoint(tem));
   
}

- (void)slider:(UISlider*)slider
{
    self.audioLayer.volume = slider.value;
    [_selectBtn setTitle:@(self.audioLayer.volume).stringValue forState:(UIControlStateNormal)];
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
    self.audioLayer.volume += .1f;
    [btn setTitle:@(self.audioLayer.volume).stringValue forState:(UIControlStateNormal)];
}


- (void)run1
{
    NSArray *itemArr = @[@4,@5,@6,@7,@8,@9,@10,@11,@12];
    
    
    NSArray *colorArr = @[[UIColor redColor],[UIColor greenColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor brownColor],[UIColor blueColor],[UIColor redColor],[UIColor greenColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor brownColor],[UIColor blueColor],[UIColor redColor],[UIColor greenColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor brownColor],[UIColor blueColor],[UIColor redColor],[UIColor greenColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor brownColor],[UIColor blueColor]];
    
    DrawView *drawView = [[DrawView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:drawView];
    
    drawView.pieCenter1 = CGPointMake(120, 100);
    drawView.pieCenter2 = CGPointMake(120, 300);
    drawView.layer.radius = 100;
    _drawView = drawView;
    drawView.layer.itemArr = itemArr;
    drawView.layer.corlorArr = colorArr;
    drawView.layer.endAngle = 360;
    drawView.layer.startAngle = 0;
    
    
//    drawView.pieCenter1 = CGPointMake(120, 100);
//    drawView.pieCenter2 = CGPointMake(120, 300);
//    drawView.radius = 100;
//
//    drawView.itemArr = itemArr;
//    drawView.corlorArr = colorArr;
//    drawView.endAngle = 360;
//    drawView.startAngle = 0;
//    _itemsArr = itemArr;
//    _colorArr = colorArr;
    
    
//    [_drawView.layer insertValues:itemArr atIndexes:colorArr animated:YES];
    
//    [_drawView.layer in];
//     [_drawView.layer startDrawItem:_itemsArr color:_colorArr];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [_drawView startDraw];
}





@end
