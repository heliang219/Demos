//
//  Images.h
//  RACDemo2
//
//  Created by pfl on 15/10/9.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Realm/Realm.h>

@interface Images : RLMObject
@property NSString *small;
@property NSString *medium;
@property NSString *large;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Images>
RLM_ARRAY_TYPE(Images)
