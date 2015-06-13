//
//  CircleLayer.m
//  KVODemo
//
//  Created by pfl on 15/1/27.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "CircleLayer.h"

@interface CircleLayer ()

@property (nonatomic, assign) CGPoint circleCenter;
@property (nonatomic, strong) NSMutableArray *piontArr;
@property (nonatomic, strong) NSMutableArray *colorArr;
@property (nonatomic, strong) NSMutableArray *tempAngleArr;

@end


@implementation CircleLayer
@dynamic itemArr,radius,startAngle,endAngle;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.piontArr = [NSMutableArray array];
        self.colorArr = [NSMutableArray array];
        self.tempAngleArr = [NSMutableArray array];
        self.backgroundColor = [UIColor clearColor].CGColor;
        self.radius = 50.0f;
        self.startAngle = 0;
        self.endAngle = 360;
        
    }
    return self;
}

- (void)startAnimation
{
    [self animationStartAngleFrom:0 toStart:0 endAngleFrom:0 toEnd:self.endAngle];
}

- (void)drawInContext:(CGContextRef)ctx
{
    
    if (self.piontArr.count) {
        [self.piontArr removeAllObjects];
    }
    
    if (self.colorArr.count) {
        [self.colorArr removeAllObjects];
    }
    
    if (self.tempAngleArr.count) {
        [self.tempAngleArr removeAllObjects];
    }
    
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2-5);
    
    __block CGFloat sum = 0;
    [self.itemArr enumerateObjectsUsingBlock:^(CircleItem *item, NSUInteger idx, BOOL *stop) {
        sum += item.itemNum.floatValue;
    }];
    
    __block  CGFloat start_angle = self.startAngle;
    __block CGFloat interval = (self.endAngle - self.startAngle)*M_PI/180.0;
    
    [self.itemArr enumerateObjectsUsingBlock:^(CircleItem *item, NSUInteger idx, BOOL *stop) {
        
        CGFloat temAngle = item.itemNum.floatValue/sum*interval;
        
        CGFloat end_angle = start_angle + temAngle;
        
        [self addDrawpieChart:ctx center:center startAngle:start_angle endAngle:end_angle color:item.itemColor];
        
        CGFloat x = (cos(start_angle + temAngle/2)*self.radius/2 + center.x);
        CGFloat y = (sin(start_angle + temAngle/2)*self.radius/2 + center.y);
        CGPoint xy = CGPointMake(x, y);
        

        
        
        
        [self.piontArr addObject:[NSValue valueWithCGPoint:xy]];
        [self.colorArr addObject:item.itemColor];
        [self.tempAngleArr addObject:@(start_angle + temAngle/2)];
        if (idx == self.itemArr.count - 1) {
            
            [self addLines:sum];
            
        }
        
        start_angle = end_angle;
        
    }];
    
}


- (void)addLines:(CGFloat)sum
{
    
    [self.piontArr enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL *stop) {
        
        CGPoint xy = [value CGPointValue];
       
        CGFloat detlaX = 44,detlaY = 11, x,y,x1,x2,x3,x4,y1,y2,y3,y4,rectX,rectY = 0.0;
      
        CGFloat tempAngle = [self.tempAngleArr[idx] floatValue];
        NSLog(@"temAngle = %f",tempAngle);
        
        
        if (tempAngle > 0 && tempAngle < M_PI_2*2) {
            
            y = xy.y + 80;
           
        }
        else
        {
            y = xy.y - 80;
            
        }
        
        y1 = y2 = y - detlaY;
        y3 = y4 = y + detlaY;
        
        if (tempAngle > M_PI_2 && tempAngle < M_PI_2 *3) {
            
            x = xy.x - 40;
            detlaX = -detlaX;
            
        }else
        {
            x = xy.x + 40;
            
        }
        
        x1 = x4 = x;
        x2 = x3 = x1 + detlaX;
        
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = 1.5;
        path.lineJoinStyle = kCGLineJoinRound;
        [[UIColor redColor]set];
        [path moveToPoint:xy];
        [path addLineToPoint:CGPointMake(xy.x, y)];
        [path addLineToPoint:CGPointMake(x, y)];
        [path stroke];
        
        UIBezierPath *aPath = [UIBezierPath bezierPath];
        aPath.lineJoinStyle = kCGLineJoinRound;
        aPath.lineWidth = 1.0f;
        [[UIColor brownColor ]set];
        [aPath moveToPoint:CGPointMake(x, y)];
        [aPath addLineToPoint:CGPointMake(x1, y1)];
        [aPath addLineToPoint:CGPointMake(x2, y2)];
        [aPath addLineToPoint:CGPointMake(x3, y3)];
        [aPath addLineToPoint:CGPointMake(x4, y4)];
        [aPath closePath];
        [aPath stroke];
        
        
        if (tempAngle > M_PI_2 && tempAngle < M_PI_2 *3) {
            rectX = x2;
            rectY = y2;
        }
        else
        {
            rectX = x1;
            rectY = y1;
        }
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.alignment = NSTextAlignmentLeft;
        
        [[NSString stringWithFormat:@"%.2f%%",[[self.itemArr[idx] itemNum] floatValue]/sum * 100] drawInRect:CGRectMake(rectX, rectY, abs(detlaX), detlaY*2) withAttributes:@{NSParagraphStyleAttributeName:paragraph}];
        
        
        
        
    }];
    
}


static void MyShaderProcedure(void *info, const CGFloat *in, CGFloat *out)

{
    
    CGFloat color;
    
    if(in[0] < 0.33f)
        
        color = 0.3f;
    
    else if(in[0] < 0.66f)
        
        color = 0.9f;
    
    else
        
    color = 0.6f;
    
    out[0] = color;
    
    out[1] = color;
    
    out[2] = color;
    
    out[3] = 1.0f;
    
}


- (void)addDrawpieChart:(CGContextRef)ctx center:(CGPoint)center startAngle:(CGFloat)start_angle endAngle:(CGFloat)end_angle color:(UIColor*)color
{
    UIGraphicsPushContext(ctx);
    CGContextSaveGState(ctx);
    
    [color set];
    
    CGContextMoveToPoint(ctx, center.x, center.y);
    
    const CGFunctionCallbacks callbacks = {
        
        .version = 0, .evaluate = &MyShaderProcedure, .releaseInfo = NULL
        
    };
    
    CGFunctionRef funcRef = CGFunctionCreate(NULL,  // 将info置空
                                             
                                             1,     // 1个输入元素（每个元素为2个分量来表示区间）
                                             
                                             (CGFloat[]){0.0f, 1.0f},
                                            
                                             4,     // 4个输出元素
                                             
                                             (CGFloat[]){0.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f},
                                            
                                             &callbacks);
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    CGShadingRef shading = CGShadingCreateAxial(space, CGPointMake(0, 0), center, funcRef, false, false);
    
//    CGContextDrawShading(ctx, shading);
    CGContextAddArc(ctx, center.x, center.y, self.radius, end_angle, start_angle, 1);
    CGContextAddArc(ctx, center.x, center.y, self.radius * .1, start_angle, end_angle, 0);
    CGContextClip(ctx);
    
    CGContextFillRect(ctx, self.bounds);
    
    CGColorSpaceRelease(space);
    CGFunctionRelease(funcRef);
    CGShadingRelease(shading);
    CGContextRestoreGState(ctx);
}


- (void)animationStartAngleFrom:(CGFloat)startFrom toStart:(CGFloat)toStartAngle endAngleFrom:(CGFloat)endFrom toEnd:(CGFloat)toEndAngle
{
    
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"startAngle"];
    startAnimation.fromValue = @(startFrom);
    startAnimation.toValue = @(toStartAngle);
    startAnimation.duration = .6;
    startAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"endAngle"];
    endAnimation.fromValue = @(endFrom);
    endAnimation.toValue = @(toEndAngle);
    endAnimation.duration = .6;
    endAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = .6;
    group.animations = @[startAnimation,endAnimation];
    [self addAnimation:group forKey:nil];
    
    
}



+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if([key isEqualToString:@"radius"] || [key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"])
    {
        return YES;
    }

   return [super needsDisplayForKey:key];
}

- (id<CAAction>)actionForKey:(NSString *)event
{
    if ([event isEqualToString:@"radius"]) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        animation.fromValue = [self.presentationLayer valueForKey:event];
        return animation;
    }
    
    if ([event isEqualToString:@"startAngle"]) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        animation.fromValue = [self.presentationLayer valueForKey:event];
        return animation;
    }
    
    if ([event isEqualToString:@"endAngle"]) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        animation.fromValue = [self.presentationLayer valueForKey:event];
        return animation;
    }
    
    
    return [super animationForKey:event];
}


@end
















