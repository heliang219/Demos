//
//  MyCoreTextView.m
//  CoreTextDemo
//
//  Created by pfl on 15/1/7.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "MyCoreTextView.h"

@interface MyCoreTextView ()
@property (nonatomic, assign) CGFloat textHeight;
@end
@implementation MyCoreTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = 15.0f;
        self.character = 10.0f;
        self.line = 10.0f;
        self.paragraph = 20.0f;
        self.text = @"这是myView,请赋值";
        self.backgroundColor = [UIColor greenColor];
        
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0, -1.0);
        CGAffineTransformTranslate(transform, 0, -self.bounds.size.height);
        self.transform = transform;
    }
    return self;
}

- (void)setText:(NSString *)text {
    if (_text == text) {
        return;
    }
    _text = text;
    
    CFStringRef string = (__bridge CFStringRef)(CFBridgingRelease((__bridge CFTypeRef _Nullable)(_text)));

    // 创建字体以及字体大小
    
    CTFontRef helvatica = CTFontCreateWithName(CFSTR("Helvetica"), _font, NULL);
    CTFontRef helvaticaBlod = CTFontCreateWithName(CFSTR("Helvatica"), _font, NULL);
//    [string addAttribute:(id)kCTFontAttributeName value:(__bridge id)helvatica range:NSMakeRange(0, _text.length * 0.5)];
//    [string addAttribute:(id)kCTFontAttributeName value:(__bridge id)helvaticaBlod range:NSMakeRange(0, [_text length])];
    
    CTFontRef boldFont = CTFontCreateUIFontForLanguage(kCTFontUserFontType, 16, NULL);
    
    CFMutableAttributedStringRef attributedString = CFAttributedStringCreateMutable(NULL, 0);
    CFAttributedStringReplaceString(attributedString, CFRangeMake(0,0), string);
    
    CFAttributedStringSetAttribute(attributedString, CFRangeMake(0, CFStringGetLength(string)/2), kCTFontAttributeName, boldFont);
    
    CGColorRef color = [UIColor redColor].CGColor;
    CFAttributedStringSetAttribute(attributedString, CFStringFind(string,
                                                                  CFSTR("下面"),
                                                                  0), kCTForegroundColorAttributeName, color);
    
    // 设置字体的颜色
//    [string addAttribute:(id)kCTForegroundColorAttributeName value:(__bridge id)[UIColor redColor].CGColor range:NSMakeRange(0, _text.length * 0.5)];
//    [string addAttribute:(id)kCTForegroundColorAttributeName value:(__bridge id)[UIColor blueColor].CGColor range:NSMakeRange(_text.length * 0.5, _text.length)];
    
    // 创建文本的对其方式
    
    CTTextAlignment alignment = kCTJustifiedTextAlignment;
    CTParagraphStyleSetting alignmentStyleSetting;
    alignmentStyleSetting.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentStyleSetting.value = &alignment;
    alignmentStyleSetting.valueSize = sizeof(alignment);
    
    
    //设置字体间距
    long number = _character;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
//    [string addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, _text.length)];
    CFAttributedStringSetAttribute(attributedString, CFRangeMake(0, _text.length), kCTKernAttributeName, num);

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
//    [string addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)paragraphStyly range:NSMakeRange(0, _text.length)];
    
    CFAttributedStringSetAttribute(attributedString, CFRangeMake(0, _text.length), kCTParagraphStyleAttributeName, paragraphStyly);
    
    _framesetter = CTFramesetterCreateWithAttributedString(attributedString);

    [self setNeedsDisplay];
    
    CFRelease(helvatica);
    CFRelease(helvaticaBlod);


}


- (void)drawRect:(CGRect)rect {
   
#if 1
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);

    
//    CGContextClearRect(context, self.frame);
//
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//
//    CGContextFillRect(context, CGRectMake(0, 0, 320, CGRectGetHeight(self.frame)));
//    
//    
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    
//    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGPathRef leftColumnPath = CGPathCreateWithRect(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [self getHeightForString:_text]), nil);
//    CGPathAddRect(leftColumnPath, NULL, CGRectMake(0, 0, self.bounds.size.width, 33));
    CTFrameRef leftFrame = CTFramesetterCreateFrame(_framesetter, CFRangeMake(0, 0), leftColumnPath, NULL);
    
    CTFrameDraw(leftFrame, context);
    
    
    CGPathRelease(leftColumnPath);
    CFRelease(_framesetter);
    
//    UIGraphicsPushContext(context);
    
    
#endif
    
   
    
}

- (CGFloat)getHeightForString:(NSString*)string {
 
    CGSize temSize = CTFramesetterSuggestFrameSizeWithConstraints(_framesetter, CFRangeMake(0, 0), NULL, CGSizeMake([UIScreen mainScreen].bounds.size.width, 2000), NULL);
    return temSize.height;
}


- (void)sizeToFit {
    [super sizeToFit];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = [self getHeightForString:_text];
    return CGSizeMake(width, height);
}


@end

















