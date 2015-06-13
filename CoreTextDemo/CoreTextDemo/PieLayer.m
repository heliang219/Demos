//
//  PieLayer.m
//  CoreTextDemo
//
//  Created by pangfuli on 15/1/10.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "PieLayer.h"



//#define kAngle(degree) ((degree)*M_PI)/180


static inline float kAngle(float degree)
{
    return degree*M_PI/180.0f;
}



@interface PieLayer ()
{
    CGPoint _tmpPoint;
   
    NSMutableArray *_drawArr;
    CGFloat _totalPecentage;
    CGPoint _midPoint;
}



@end


@implementation PieLayer

@dynamic corlorArr,radius,itemArr,startAngle,endAngle;



- (id)initWithLayer:(id)layer
{
    if (self = [super initWithLayer:layer]) {
       
    }
    return self;
}



- (id)init
{
    if (self = [super init]) {
        
        _pieCenter1 = CGPointMake(150, 250);
        _pieCenter2 = CGPointMake(150, 250);
        self.radius = 150.0f;
        self.startAngle = 45.0f;
        self.endAngle = 360.0f;
       
    }
    return self;
}


- (void)drawInContext:(CGContextRef)context {
   
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);


    CGFloat sum = 0;
    
    for (NSNumber *num  in self.itemArr) {
        sum += num.floatValue;
    }

    CGFloat angleStart = self.startAngle;

//    CGFloat angleInterval = (self.endAngle - self.startAngle) * M_PI / 180.0;
    
    __unused UIBezierPath *aPath = [[UIBezierPath alloc]init];
    
    for (int i = 0 ; i < self.itemArr.count; i++) {
        
        UIColor *color = self.corlorArr[i];
        
        UIGraphicsPushContext(context);

        [color set];

        
        
        CGFloat  angleEnd = angleStart + [self.itemArr[i] floatValue]/sum * (self.endAngle - self.startAngle);
        
        float sinY = sin(kAngle(angleStart))*self.radius;
        
        float cosX = cos(kAngle(angleStart))*self.radius;
        

        CGContextSaveGState(context);
//        CGContextBeginPath(context);
        CGContextMoveToPoint(context, center.x, center.y);
        CGContextAddArc(context, center.x, center.y, self.radius, kAngle(angleEnd),kAngle(angleStart), YES);
        CGContextAddArc(context, center.x, center.y, self.radius-80, kAngle(angleStart), kAngle(angleEnd), NO);
//        CGContextClosePath(context);
        CGContextClip(context);
        CGContextFillRect(context, self.bounds);
        CGContextRestoreGState(context);
        angleStart = angleEnd;
        UIGraphicsPopContext();
        
//        CGContextSaveGState(context);
//        aPath.lineWidth = 1.0f;
//        aPath.lineJoinStyle = kCGLineCapRound;
//        [aPath moveToPoint:center];
//        [aPath addArcWithCenter:center radius:self.radius startAngle:angleStart endAngle:angleEnd clockwise:NO];
//        aPath.usesEvenOddFillRule = YES;
//        [aPath fillWithBlendMode:kCGBlendModeColor alpha:1.0];
//        angleStart = angleEnd;
//        CGContextTranslateCTM(context, 0, -568);
//        CGContextScaleCTM(context, 1.0f, -1.0f);
//        CGContextRestoreGState(context);
        
        _midPoint = _tmpPoint;
        
        _tmpPoint = CGPointMake(_pieCenter1.x+cosX, _pieCenter1.y+sinY);
        
        _midPoint.x  =_tmpPoint.x/2 + _midPoint.x/2;
        _midPoint.y = _tmpPoint.y/2 + _midPoint.y/2;
       
        
        
//        if (angleStart == 0) {
//            return;
//        }
//        if (kAngle(angleStart) >= 0 && kAngle(angleStart) < M_PI) {// 0 - 180
//            [self addLabel:YES angle:[self.itemArr[i] floatValue]];
//        }
//        else
//        {
//            [self addLabel:NO angle:[self.itemArr[i] floatValue]];
//        }
    }
    

    

    
}
//
//- (void)display
//{
//    NSLog(@"endAngle = %f",[self.presentationLayer endAngle]);
//}


- (void)startDrawItem:(NSArray *)itemsArr color:(NSArray *)colorArr
{
    
    self.corlorArr = [NSArray arrayWithArray:colorArr];
    self.itemArr = [NSArray arrayWithArray:itemsArr];
    [self animateFromStartAngle:0 toStartAngle:0 fromEndAngle:0 toEndAngle:self.endAngle];
    
}

- (void)animateFromStartAngle:(float)fromStartAngle
                 toStartAngle:(float)toStartAngle
                 fromEndAngle:(float)fromEndAngle
                   toEndAngle:(float)toEndAngle
{
    CAAnimationGroup* runingAnimation = (CAAnimationGroup*)[self animationForKey:@"animationStartEndAngle"];
    if(runingAnimation){
        [self removeAnimationForKey:@"animationStartEndAngle"];
    }

    NSString* timingFunction = runingAnimation? kCAMediaTimingFunctionEaseOut : kCAMediaTimingFunctionEaseInEaseOut;
    
    CABasicAnimation* animStart = [CABasicAnimation animationWithKeyPath:@"startAngle"];
    animStart.fillMode = kCAFillModeRemoved;
    animStart.duration = .6;
    animStart.repeatCount = 1;
    animStart.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    animStart.fromValue = [NSNumber numberWithFloat:fromStartAngle];
    animStart.toValue = [NSNumber numberWithFloat:toStartAngle];
    
    CABasicAnimation* animEnd = [CABasicAnimation animationWithKeyPath:@"endAngle"];
    animEnd.fillMode = kCAFillModeRemoved;
    animEnd.duration = .6;
    animEnd.repeatCount = 1;
    animEnd.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    animEnd.fromValue = [NSNumber numberWithFloat:fromEndAngle];
    animEnd.toValue = [NSNumber numberWithFloat:toEndAngle];
    

    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.duration = .6;
    transition.repeatCount = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];

   
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeRemoved;
    group.duration = 1.6;
    group.repeatCount = 1;
    group.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    group.animations = [NSArray arrayWithObjects:animStart,animEnd,nil];
    [self addAnimation:group forKey:@"animationStartEndAngle"];
    
    
}

#pragma mark - Redraw
+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if([key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"]) {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}



- (void)getArrc:(CGContextRef)ctx
{

    [self animateFromStartAngle:0
                   toStartAngle:0
                   fromEndAngle:0
                     toEndAngle:self.endAngle];

}

- (id<CAAction>)actionForKey:(NSString *)event
{
    if ([event isEqualToString:@"endAngle"]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        
        animation.fromValue = @([self.presentationLayer endAngle]);
        
        return animation;
    }

    return  [super animationForKey:event];
   
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (!flag) {
        return;
    }
}

- (void)addLineToendAngle:(CGFloat)angle color:(UIColor*)color
{
    
    [color set];
    
    
    _totalPecentage += angle;
    
    
    double degree = kAngle(_totalPecentage);
    double sinY = sin(degree);
    double cosX = cos(degree);
    
    self.endAngle = degree;
    
    
    UIBezierPath *aPath = [UIBezierPath bezierPathWithArcCenter:_pieCenter1 radius:self.radius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
    aPath.lineWidth = 1.0f;
    aPath.lineCapStyle = kCGLineCapRound;
    aPath.lineJoinStyle = kCGLineCapRound;
    
    sinY = sin(degree)*self.radius;
   
    cosX = cos(degree)*self.radius;
   
    [aPath moveToPoint:_pieCenter1];
    
    [aPath addLineToPoint:_tmpPoint];
    
    
    _midPoint = _tmpPoint;
    
    _tmpPoint = CGPointMake(_pieCenter1.x+cosX, _pieCenter1.y+sinY);
    
    _midPoint.x  =_tmpPoint.x/2 + _midPoint.x/2;
    _midPoint.y = _tmpPoint.y/2 + _midPoint.y/2;
    
    [aPath addLineToPoint:_tmpPoint];
    
    
    [aPath stroke];
    [aPath fill];
    self.startAngle = self.endAngle;
    
    
    
    
    if (angle == 0) {
        return;
    }
    if (degree >= 0 && degree < M_PI) {// 0 - 180
        [self addLabel:YES angle:angle];
    }
    else
    {
        [self addLabel:NO angle:angle];
    }
    
    
}


- (void)addLabel:(BOOL)dire angle:(CGFloat)angle
{
    CALayer *l = [[CALayer alloc]init];
    l.frame = (CGRect){_midPoint,CGSizeMake(dire?1:-1, dire?100:-100)};
    l.backgroundColor = [UIColor blackColor].CGColor;
    [self addSublayer:l];
    
    CALayer *l2 = [[CALayer alloc]init];
    l2.frame = CGRectMake(dire?CGRectGetMaxX(l.frame)-1:CGRectGetMinX(l.frame), dire?CGRectGetMaxY(l.frame)-1:CGRectGetMinY(l.frame), 10, 1);
    
    l2.backgroundColor = [UIColor blackColor].CGColor;
    [self addSublayer:l2];
    
    
    CALayer *l3 = [[CALayer alloc]init];
    l3.frame = CGRectMake(CGRectGetMaxX(l2.frame), CGRectGetMaxY(l2.frame)-9.5, 30, 20);
//    l3.text = @(angle/3.6).stringValue;
    
    [@(angle).stringValue drawInRect:l3.frame withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    l3.backgroundColor = [UIColor cyanColor].CGColor;
    [self addSublayer:l3];
}



- (void)startDraw
{
    //    [self setNeedsDisplay];
}



//- (void)coreGraphyDrawAnglecontext:(CGContextRef)context
//{
//    
//    CGFloat angle;
//    UIColor *color;
//    
//    
//    [self.itemArr enumerateObjectsUsingBlock:^(NSNumber *pecentage, NSUInteger idx, BOOL *stop) {
//        
//        if (pecentage.floatValue > 1) {
//            
////            [self coreGraphyDrawAngle:pecentage.floatValue * 3.6 color:_corlorArr[idx] context:ctx];
//            
//            
//            [color setStroke];
//            [color setFill];
//            
//            _totalPecentage += angle;
//            
//            double self.radius = _self.radius;
//            double degree = kAngle(_totalPecentage);
//            double sinY = sin(degree);
//            double cosX = cos(degree);
//            
//            self.endAngle = degree;
//            
//            
//            
//            sinY = sin(degree)*self.radius;
//            
//            cosX = cos(degree)*self.radius;
//            
//            CGContextSaveGState(context);
//            
//            CGContextSetLineWidth(context, 5.0f);
//            CGContextSetLineJoin(context, kCGLineJoinBevel);
//            
//            
//            CGContextMoveToPoint(context, _pieCenter2.x, _pieCenter2.y);
//            
//            CGContextAddArc(context, _pieCenter2.x, _pieCenter2.y, _self.radius, self.startAngle, self.endAngle, NO);
//            
//            
//            _midPoint = _tmpPoint;
//            
//            _tmpPoint = CGPointMake(_pieCenter2.x+cosX, _pieCenter2.y+sinY);
//            
//            
//            
//            CGContextClosePath(context);
//            CGContextClip(context);
//            
//            CGContextFillRect(context, self.bounds);
//            CGContextSetFillColorWithColor(context, color.CGColor);
//            CGContextSetStrokeColorWithColor(context, color.CGColor);
//            //    CGContextFillPath(context);
//            
//            
//            CGContextRestoreGState(context);
//            
//            self.startAngle = self.endAngle;
//            
//
//            
//            
//        }
//        
//        else
//            
////            [self coreGraphyDrawAngle:pecentage.floatValue * 360 color:_corlorArr[idx] context:ctx];
//        
//    }];
//    
//
//    
////    
////    _midPoint.x  =_tmpPoint.x/2 + _midPoint.x/2;
////    _midPoint.y = _tmpPoint.y/2 + _midPoint.y/2;
////    
////    
////    if (angle == 0) {
////        return;
////    }
////    if (degree >= 0 && degree < M_PI) {// 0 - 180
////        [self addLabel:YES angle:angle];
////    }
////    else
////    {
////        [self addLabel:NO angle:angle];
////    }
//
//    
//}
//



@end
