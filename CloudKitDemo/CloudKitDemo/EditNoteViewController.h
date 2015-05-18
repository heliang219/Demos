//
//  EditNoteViewController.h
//  CloudKitDemo
//
//  Created by pfl on 15/5/18.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>

@protocol EditNoteViewControllerDelegate <NSObject>

- (void)didSaveNote:(CKRecord *)record isEdited:(BOOL)isEdited;

@end

@interface EditNoteViewController : UIViewController
- (instancetype)initWithRecord:(CKRecord*)record delegate: (id<EditNoteViewControllerDelegate>) delegate;


@end

