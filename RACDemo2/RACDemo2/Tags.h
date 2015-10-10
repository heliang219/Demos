//
//  Tags.h
//  RACDemo2
//
//  Created by pfl on 15/10/9.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Realm/Realm.h>
#import "BaseModel.h"

@interface Tags : BaseModel
@property int count;
@property NSString *name;
@property NSString *title;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Tags>
RLM_ARRAY_TYPE(Tags)
