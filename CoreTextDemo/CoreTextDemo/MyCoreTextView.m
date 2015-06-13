//
//  MyCoreTextView.m
//  CoreTextDemo
//
//  Created by pfl on 15/1/7.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "MyCoreTextView.h"
#import <CoreText/CoreText.h>

@implementation MyCoreTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = 15.0f;
        self.character = 20.0f;
        self.line = 10.0f;
        self.paragraph = 20.0f;
        self.text = @"这是myView,请赋值";
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
   
#if 1
    
    // 创建attributeString
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:_text];
    
    // 创建字体以及字体大小
    
    CTFontRef helvatica = CTFontCreateWithName(CFSTR("Helvetica"), _font, NULL);
    CTFontRef helvaticaBlod = CTFontCreateWithName(CFSTR("Helvatica"), _font, NULL);
    [string addAttribute:(id)kCTFontAttributeName value:(__bridge id)helvatica range:NSMakeRange(0, _text.length)];
    
    [string addAttribute:(id)kCTFontAttributeName value:(__bridge id)helvaticaBlod range:NSMakeRange(0, [_text length])];
    
    // 设置字体的颜色
    [string addAttribute:(id)kCTForegroundColorAttributeName value:(__bridge id)[UIColor blackColor].CGColor range:NSMakeRange(0, _text.length)];
    
    // 创建文本的对其方式
    
    CTTextAlignment alignment = kCTJustifiedTextAlignment;
    CTParagraphStyleSetting alignmentStyleSetting;
    alignmentStyleSetting.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentStyleSetting.value = &alignment;
    alignmentStyleSetting.valueSize = sizeof(alignment);
    
    
    //设置字体间距
    
    long number = _character;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [string addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, _text.length)];
    CFRelease(num);
    
    //设置  段落间距
    CGFloat paraparaph = _paragraph;
    CTParagraphStyleSetting paragraphStyleSetting;
    paragraphStyleSetting.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphStyleSetting.value = &paraparaph;
    paragraphStyleSetting.valueSize = sizeof(paraparaph);
    
    
    //创建文本,行间距
    CGFloat line = _line;
    CTParagraphStyleSetting lineStyleSetting;
    lineStyleSetting.valueSize = sizeof(line);
    lineStyleSetting.value = &line;
    lineStyleSetting.spec = kCTParagraphStyleSpecifierLineSpacing;
    
    //创建样式数组
    
    CTParagraphStyleSetting setting[] = {alignmentStyleSetting,lineStyleSetting,paragraphStyleSetting};
    
    CTParagraphStyleRef paragraphStyly = CTParagraphStyleCreate(setting, sizeof(setting));
    [string addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)paragraphStyly range:NSMakeRange(0, _text.length)];
    
    
    // layout master
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) string);
    CGSize temSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(300, MAXFLOAT), NULL);
    CGSize textBoxSize = CGSizeMake(temSize.width+1, temSize.height+1);
    self.frame = CGRectMake(0, 0, textBoxSize.width, textBoxSize.height);
    
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    CGPathAddRect(leftColumnPath, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), leftColumnPath, NULL);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, self.frame);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextFillRect(context, CGRectMake(0, 0, 320, CGRectGetHeight(self.frame)));
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
    
    
    
    CTFrameDraw(leftFrame, context);
    
    
    CGPathRelease(leftColumnPath);
    CFRelease(framesetter);
    CFRelease(helvatica);
    CFRelease(helvaticaBlod);
    
    UIGraphicsPushContext(context);
    
    
#endif
    
   
    
}


@end

















