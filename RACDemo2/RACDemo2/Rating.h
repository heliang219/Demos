//
//  Rating.h
//  RACDemo2
//
//  Created by pfl on 15/10/9.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Realm/Realm.h>
#import "BaseModel.h"
@interface Rating : BaseModel
@property int min;
@property NSString *average;
@property int max;
@property int numRaters;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Rating>
RLM_ARRAY_TYPE(Rating)
