//
//  DrawView.m
//  CoreTextDemo
//
//  Created by pfl on 15/1/8.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "DrawView.h"
#import "PieLayer.h"
#import "PieLayer1.h"

#define kAngle(degree) ((degree)*M_PI)/180

@interface DrawView ()
{
    CGPoint _tmpPoint;
//    CGFloat _startAngle;
//    CGFloat _endAngle;
    
    NSMutableArray *_drawArr;
    CGFloat _totalPecentage;
    CGPoint _midPoint;
}




@end

@implementation DrawView

//@dynamic startAngle,endAngle;



+ (Class)layerClass
{
//    return [PieLayer1 class];
    
    return [PieLayer class];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor  = [UIColor clearColor];
        
        
//        self.layer.pieCenter1 = CGPointMake(150, 250);
//        self.layer.pieCenter2 = CGPointMake(150, 250);
//        self.layer.radius = 100.0f;
//        self.layer.startAngle = 0;
        self.pieCenter1 = CGPointMake(150, 250);
        self.pieCenter2 = CGPointMake(150, 250);
        self.radius = 100.0f;
        self.startAngle = 0;
     
        if ([self.layer respondsToSelector:@selector(setContentsScale:)]) {
            self.layer.contentsScale = [[UIScreen mainScreen] scale];
        }
        
        _drawArr = [NSMutableArray arrayWithCapacity:10];
       
        
//        [self setNeedsDisplay];
    }
    return self;
}

//
//- (void)drawRect:(CGRect)rect {
//    
////    [self.layer drawInContext:UIGraphicsGetCurrentContext()];
////    
////}
//
////    [self drawFiveStar];
//    
//    [self clearsContextBeforeDrawing];
//    
//    
//    [self getArrc];
//    
//    [self animateFromStartAngle:0 toStartAngle:0 fromEndAngle:0 toEndAngle:360];
//}


- (void)animateFromStartAngle:(float)fromStartAngle
                 toStartAngle:(float)toStartAngle
                 fromEndAngle:(float)fromEndAngle
                   toEndAngle:(float)toEndAngle
{
    CAAnimationGroup* runingAnimation = (CAAnimationGroup*)[self.layer animationForKey:@"animationStartEndAngle"];
    if(runingAnimation){
        [self.layer removeAnimationForKey:@"animationStartEndAngle"];
    }
    
    NSString* timingFunction = runingAnimation? kCAMediaTimingFunctionEaseOut : kCAMediaTimingFunctionEaseInEaseOut;
    
    CABasicAnimation* animStart = [CABasicAnimation animationWithKeyPath:@"startAngle"];
    animStart.fillMode = kCAFillModeRemoved;
    animStart.duration = .6;
    animStart.repeatCount = 1;
    animStart.delegate = self;
    animStart.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    animStart.fromValue = [NSNumber numberWithFloat:fromStartAngle];
    animStart.toValue = [NSNumber numberWithFloat:toStartAngle];
    
    CABasicAnimation* animEnd = [CABasicAnimation animationWithKeyPath:@"endAngle"];
    animEnd.fillMode = kCAFillModeRemoved;
    animEnd.duration = .6;
    animEnd.repeatCount = 1;
    animEnd.delegate = self;
    animEnd.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    animEnd.fromValue = [NSNumber numberWithFloat:fromEndAngle];
    animEnd.toValue = [NSNumber numberWithFloat:toEndAngle];
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animation];
    keyFrame.path =CFAutorelease(CGPathCreateWithEllipseInRect(CGRectMake(CGRectGetWidth(self.frame)/2-50, CGRectGetHeight(self.frame)/2-50, CGRectGetWidth(self.frame)/2+50, CGRectGetHeight(self.frame)/2+50), NULL));
    keyFrame.keyPath = @"position";
    keyFrame.duration = .5;
    keyFrame.additive = YES;
    keyFrame.repeatCount = 1;
    keyFrame.calculationMode = kCAAnimationPaced;
    keyFrame.rotationMode = kCAAnimationRotateAuto;
    [self.layer addAnimation:keyFrame forKey:@"keyFrame"];
    
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeRemoved;
    group.duration = .6;
    group.repeatCount = MAXFLOAT;
    group.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    group.animations = [NSArray arrayWithObjects:keyFrame, nil];
    
    [self.layer addAnimation:group forKey:nil];
}

- (void)drawFiveStar
{
    
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(100.0, 0.0)];
    
    // Draw the lines
    [aPath addLineToPoint:CGPointMake(200.0, 40.0)];
    [aPath addLineToPoint:CGPointMake(160, 140)];
    [aPath addLineToPoint:CGPointMake(40.0, 140)];
    [aPath addLineToPoint:CGPointMake(0.0, 40.0)];
    [aPath closePath];//第五条线通过调用closePath方法得到的
    
    [aPath stroke];//Draws line 根据坐标点连线
    
    [aPath fill];
}



- (void)getArrc
{
    
    if (_itemArr.count == 0) {
        return;
    }
    
//    _tmpPoint = _pieCenter1;
    
    double sinY ;
    double cosX ;
    
    sinY = sin(self.startAngle)* self.radius;
    
    cosX = cos(self.startAngle)* self.radius;
    _tmpPoint = CGPointMake(_pieCenter2.x + cosX, _pieCenter2.y + sinY);
    
    
    
//    [self addLineToendAngle:_startAngle color:[UIColor redColor]];
    
   
    
    CGFloat __block angleStart = 0;
    CGFloat __block interval = (self.endAngle - self.startAngle)*M_PI/180;
    
    CGFloat __block sum = 0;
    
    
    
    
    [self.itemArr enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        sum += obj.floatValue;
    }];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self.itemArr enumerateObjectsUsingBlock:^(NSNumber *pecentage, NSUInteger idx, BOOL *stop) {
        
        

        [(UIColor*)_corlorArr[idx] set];
        
        
    
        CGFloat angleEnd = angleStart + pecentage.floatValue*interval/sum;
        
        double sinY ;
        double cosX ;
        
        sinY = sin(angleEnd)* self.radius;
        
        cosX = cos(angleEnd)* self.radius;
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, _pieCenter2.x, _pieCenter2.y);
            
        if (idx == 0) {
            
            CGContextAddArc(context, _pieCenter2.x, _pieCenter2.y, _radius, angleStart, angleEnd, YES);
        }
        else
        {
          
            CGContextAddArc(context, _pieCenter2.x, _pieCenter2.y, _radius,angleStart, angleEnd, YES);
        }
        CGContextClip(context);
  
        
        _midPoint = _tmpPoint;
        
        _tmpPoint = CGPointMake(_pieCenter2.x+cosX, _pieCenter2.y+sinY);

        CGContextFillRect(context, self.bounds);

        
        _midPoint.x  =_tmpPoint.x/2 + _midPoint.x/2;
        _midPoint.y = _tmpPoint.y/2 + _midPoint.y/2;
        
        
        angleStart = angleEnd;
        
        
        
//        if (angleStart == 0) {
//            return;
//        }
 
//        
//        if (angleStart >= 0 && angleStart < M_PI) {// 0 - 180
//            [self addLabel:YES angle:pecentage.floatValue sum:sum];
//        }
//        else
//        {
//            [self addLabel:NO angle:pecentage.floatValue sum:sum];
//        }

        
    }];
    


    
}


- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    
    if ([event isEqualToString:@"endAngle"]) {
        
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:event];
        anim.fromValue = @(self.endAngle);
        
        
        return anim;
    }
    
    return  [super actionForLayer:layer forKey:event];
    
}

- (void)addLineToendAngle:(CGFloat)angle color:(UIColor*)color
{
    
    [color set];
    
    
    _totalPecentage += angle;
   

    double radius = _radius;
    double degree = kAngle(_totalPecentage);
    double sinY = sin(degree);
    double cosX = cos(degree);
    
    self.endAngle = degree;
    
    
    UIBezierPath *aPath = [UIBezierPath bezierPathWithArcCenter:_pieCenter1 radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
    aPath.lineWidth = 1.0f;
    aPath.lineCapStyle = kCGLineCapRound;
    aPath.lineJoinStyle = kCGLineCapRound;
  
    
    if (degree >= 0 && degree < M_PI) {// 0 - 180
        sinY = fabs(sin(degree))*radius;
    }
    else
    {
        sinY = - fabs(sin(degree))*radius;
    }
    
    
    if (degree > M_PI_2 && degree <= M_PI_2 * 3) {//90-270
        cosX = -fabs(cos(degree))*radius;
    }
    else
    {
        cosX = fabs(cos(degree))*radius;
    }
    
    
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
    UILabel *l = [[UILabel alloc]initWithFrame:(CGRect){_midPoint,CGSizeMake(dire?1:-1, dire?100:-100)}];
    l.backgroundColor = [UIColor blackColor];
    
    [self addSubview:l];
    
    UILabel *l2 = [[UILabel alloc]initWithFrame:CGRectMake(dire?CGRectGetMaxX(l.frame)-1:CGRectGetMinX(l.frame), dire?CGRectGetMaxY(l.frame)-1:CGRectGetMinY(l.frame), 10, 1)];
   
    l2.backgroundColor = [UIColor blackColor];
    [self addSubview:l2];
    
    
    UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(l2.frame), CGRectGetMaxY(l2.frame)-9.5, 30, 20)];
    l3.text = @(angle/3.6).stringValue;
    l3.textAlignment = NSTextAlignmentCenter;
    l3.backgroundColor = [UIColor cyanColor];
    [self addSubview:l3];
}


- (void)addLabel:(BOOL)dire angle:(CGFloat)angle sum:(CGFloat)sum
{
    UILabel *l = [[UILabel alloc]initWithFrame:(CGRect){_midPoint,CGSizeMake(dire?1:-1, dire?100:-100)}];
    l.backgroundColor = [UIColor blackColor];
    
    [self addSubview:l];
    
    UILabel *l2 = [[UILabel alloc]initWithFrame:CGRectMake(dire?CGRectGetMaxX(l.frame)-1:CGRectGetMinX(l.frame), dire?CGRectGetMaxY(l.frame)-1:CGRectGetMinY(l.frame), 10, 1)];
    
    l2.backgroundColor = [UIColor blackColor];
    [self addSubview:l2];
    
    
    UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(l2.frame), CGRectGetMaxY(l2.frame)-9.5, 30, 20)];
    l3.text = @(angle).stringValue;
    l3.textAlignment = NSTextAlignmentCenter;
    l3.backgroundColor = [UIColor cyanColor];
    [self addSubview:l3];
}

- (void)startDraw
{
//    [self setNeedsDisplay];
}


- (void)coreGraphyDrawAngle:(CGFloat)angle color:(UIColor*)color context:(CGContextRef)context
{
    
    [color setStroke];
    [color setFill];
    
    
    _totalPecentage += angle;
    if (_totalPecentage > 360) {
        
        self.startAngle = _totalPecentage - angle;
        
        _totalPecentage = 360;

    }
    
    double radius = _radius;
    double degree = _totalPecentage;
    double sinY = sin(degree);
    double cosX = cos(degree);
    
    self.endAngle = degree;
    
     sinY = sin(degree)*radius;

     cosX = cos(degree)*radius;
  
//    CGMutablePathRef path = CGPathCreateMutable();
    UIGraphicsPushContext(context);
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 5.0f);
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    
//    CGPathMoveToPoint(path, NULL, _pieCenter2.x, _pieCenter2.y);
//    
//    CGPathAddLineToPoint(path, NULL, _tmpPoint.x, _tmpPoint.y);
    
    
    CGContextMoveToPoint(context, _pieCenter2.x, _pieCenter2.y);
    
   
//    CGContextAddPath(context, path);
//    CGContextDrawPath(context, kCGPathFillStroke);
    
    
//    CGPathAddArc(path, NULL, _pieCenter2.x, _pieCenter2.y, _radius, _startAngle, _endAngle, NO);
    
    CGContextAddArc(context, _pieCenter2.x, _pieCenter2.y, _radius, self.startAngle, self.endAngle, NO);
    CGContextClip(context);
    
    
//    CGPathAddArcToPoint(path, NULL, _pieCenter2.x, _pieCenter2.y, _tmpPoint.x, _tmpPoint.y, _radius);
    
//    CGContextAddPath(context, path);
//    CGContextDrawPath(context, kCGPathFillStroke);

    _midPoint = _tmpPoint;
    
    _tmpPoint = CGPointMake(_pieCenter2.x+cosX, _pieCenter2.y+sinY);

//    CGContextAddPath(context, path);
//    CGContextDrawPath(context, kCGPathFillStroke);
    
//    CGContextFillPath(context);
    CGContextFillRect(context, self.bounds);
    

    CGContextRestoreGState(context);
    
    
    self.startAngle = self.endAngle;
    
    
    
    _midPoint.x  =_tmpPoint.x/2 + _midPoint.x/2;
    _midPoint.y = _tmpPoint.y/2 + _midPoint.y/2;
    
    
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




@end






