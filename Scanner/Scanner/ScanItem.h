//
//  ScanItem.h
//  Scanner
//
//  Created by pfl on 15/6/3.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ScanItem : NSManagedObject

@property (nonatomic, retain) NSString * scanDate;
@property (nonatomic, retain) NSString * scanDetail;

@end
