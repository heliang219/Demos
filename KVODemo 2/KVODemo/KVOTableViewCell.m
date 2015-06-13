//
//  KVOTableViewCell.m
//  KVODemo
//
//  Created by pfl on 15/1/27.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "KVOTableViewCell.h"

@implementation KVOTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
    
        
    }
    return self;
}


- (void)setValue:(id)value
{
    
    [self removeObserver];
    
     _value = value;
    
    [self addObserver];
    
    [self update];
}


- (void)setKey:(NSString *)key
{
    
    [self removeObserver];
    
    _key = key;
    
    [self addObserver];
    
    [self update];
}

- (void)update
{

  id value = [self.value valueForKeyPath:self.key];
    if ([value isKindOfClass:[NSDate class]]) {
        NSDate *date = value;
        NSString *tem = [date descriptionWithLocale:[NSLocale currentLocale]];
        self.textLabel.text = tem;
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
        self.textLabel.text = @"";
    }
}

- (void)addObserver
{
    [self.value addObserver:self forKeyPath:self.key options:0 context:(void *)(self)];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ((__bridge id)context == self) {
        [self update];
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}

- (void)removeObserver
{
    [self.value removeObserver:self forKeyPath:self.key];
}


- (void)awakeFromNib {
    // Initialization code
}



@end
