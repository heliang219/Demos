//
// PieLayer.m
// MagicPie
//
// Copyright (c) 2013 Alexandr Graschenkov ( https://github.com/Sk0rpion )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "PieLayer1.h"




#define kAngle(degree) ((degree)*M_PI)/180

#define ANIM_KEY_PER_SECOND 36






static NSString * const _animationValuesKey = @"animationValues";

#pragma mark - PieLayer
@interface PieLayer1 ()
{
    BOOL _isNotCopyForAnimation;
}

@property (nonatomic, strong, readwrite) NSArray* values;

@end

@implementation PieLayer1

@dynamic values;
@synthesize animationDuration;

#pragma mark - Init
- (id)init
{
    self = [super init];
    if(self){
        [self setup];
    }
    return self;
}



- (void)setup
{
    
    self.maxRadius = 100;
    self.minRadius = 0;
    self.startAngle = 0.0;
    self.endAngle = 360.0;
    self.animationDuration = 0.6;
 
  
   
}

#pragma mark - Adding, inserting and deleting


- (void)insertValues:(NSArray *)array atIndexes:(NSArray *)indexes animated:(BOOL)animated
{


    self.values = [NSArray arrayWithArray:array];
    self.corlorArr = [NSArray arrayWithArray:indexes];
    
     NSLog(@"========center = %@",NSStringFromCGPoint(_pieCenter2));
    
    [self animateFromStartAngle:0
                   toStartAngle:0
                   fromEndAngle:0
                     toEndAngle:360.0f];

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
    animStart.duration = animationDuration;
    animStart.repeatCount = 1;
    animStart.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    animStart.fromValue = [NSNumber numberWithFloat:fromStartAngle];
    animStart.toValue = [NSNumber numberWithFloat:toStartAngle];
    
    CABasicAnimation* animEnd = [CABasicAnimation animationWithKeyPath:@"endAngle"];
    animEnd.fillMode = kCAFillModeRemoved;
    animEnd.duration = animationDuration;
    animEnd.repeatCount = 1;
    animEnd.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    animEnd.fromValue = [NSNumber numberWithFloat:fromEndAngle];
    animEnd.toValue = [NSNumber numberWithFloat:toEndAngle];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeRemoved;
    group.duration = animationDuration;
    group.repeatCount = 5;
    group.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    group.animations = [NSArray arrayWithObjects:animStart, animEnd, nil];
    
    [self addAnimation:group forKey:nil];
}



#pragma mark - Redraw
+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if( /*[key isEqualToString:@"values"] || [key isEqualToString:@"maxRadius"] || [key isEqualToString:@"minRadius"] || */[key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"] /*|| [key isEqualToString:@"showTitles"] || [key isEqualToString:@"transformTitleBlock"]*/) {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

int count = 0;


#if 1
- (void)drawInContext:(CGContextRef)context {
    
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    float angleStart = 0;
    float angleInterval = (self.endAngle - self.startAngle) * M_PI / 180.0;
    
    
     NSArray *values = self.values;
    
    float sum = 0;
    
    for (NSNumber *num  in values) {
        sum += num.floatValue;
    }
    
   UIGraphicsPushContext(context);
    
    
    for (int i = 0 ; i < values.count; i++) {
        
        
        UIColor *color = _corlorArr[i];
    
        [color setStroke];
        [color setFill];
        
        CGFloat  angleEnd = angleStart + [values[i] floatValue]/sum * angleInterval;
        
        
        CGContextSaveGState(context);
        
    
        CGContextMoveToPoint(context, center.x, center.y);
        
        CGContextAddArc(context, center.x, center.y, 100, angleStart,angleEnd, NO);
        
        CGContextClosePath(context);
        CGContextClip(context);
        
        CGContextFillRect(context, self.bounds);
    
        CGContextRestoreGState(context);
        
        angleStart = angleEnd;
        
        
    }
    
    
    
    
    
}

#endif






@end
