//
//  Book.h
//  RACDemo2
//
//  Created by pfl on 15/10/7.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

+ (instancetype)bookWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic, readwrite, copy) NSString *isbn13;
@property (nonatomic, readwrite, copy) NSString *author_intro;
@property (nonatomic, readwrite, copy) NSString *publisher;
@property (nonatomic, readwrite, copy) NSString *pages;
@property (nonatomic, readwrite, copy) NSString *title;
@property (nonatomic, readwrite, copy) NSString *tags;
@property (nonatomic, readwrite, copy) NSString *image;
@property (nonatomic, readwrite, copy) NSString *catalog;
@property (nonatomic, readwrite, copy) NSString *alt;
@property (nonatomic, readwrite, copy) NSString *isbn10;
@property (nonatomic, readwrite, copy) NSString *url;
@property (nonatomic, readwrite, copy) NSString *alt_title;
@property (nonatomic, readwrite, copy) NSString *images;
@property (nonatomic, readwrite, copy) NSString *summary;
@property (nonatomic, readwrite, copy) NSString *pubdate;
@property (nonatomic, readwrite, copy) NSString *origin_title;
@property (nonatomic, readwrite, copy) NSString *ID;
@property (nonatomic, readwrite, copy) NSString *subtitle;
@property (nonatomic, readwrite, copy) NSString *translator;
@property (nonatomic, readwrite, copy) NSString *price;
@property (nonatomic, readwrite, copy) NSString *rating;
@property (nonatomic, readwrite, copy) NSString *author;
@property (nonatomic, readwrite, copy) NSString *binding;

@end
