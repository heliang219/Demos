//
//  BaseModel.h
//  RACDemo2
//
//  Created by pfl on 15/10/10.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Realm/Realm.h>

@interface BaseModel : RLMObject

- (void)setValuesForKeysWithDic:(NSDictionary*)dic;


@end

// This protocol enables typed collections. i.e.:
// RLMArray<BaseModel>
RLM_ARRAY_TYPE(BaseModel)
