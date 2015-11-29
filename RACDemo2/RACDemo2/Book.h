//
//  Books.h
//  RACDemo2
//
//  Created by pfl on 15/10/9.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Realm/Realm.h>
#import "BaseModel.h"
#import "Images.h"
#import "Rating.h"
#import "Tags.h"

@interface Book : BaseModel
+ (instancetype)bookWithDictionary:(NSDictionary*)dictionary;

@property NSString *isbn13;
@property NSString *author_intro;
@property NSString *publisher;
@property NSString *pages;
@property NSString *title;
@property RLMArray<Tags> *tags;
@property NSString *image;
@property NSString *catalog;
@property NSString *alt;
@property NSString *isbn10;
@property NSString *url;
@property NSString *alt_title;
@property Images *images;
@property NSString *summary;
@property NSString *pubdate;
@property NSString *origin_title;
@property NSString *ID;
@property NSString *subtitle;
@property NSString *translator;
@property NSString *price;
@property Rating *rating;
@property NSString *author;
@property NSString *binding;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Books>
RLM_ARRAY_TYPE(Book)
