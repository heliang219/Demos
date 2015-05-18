//
//  ViewController.m
//  CloudKitDemo
//
//  Created by pfl on 15/5/18.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "ViewController.h"
#import <CloudKit/CloudKit.h>
#import "EditNoteViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,EditNoteViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *arrNotes;
@property (nonatomic, assign) NSInteger selectedNoteIndex;
@property (nonatomic, strong) UITableView *tblNotes;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedNoteIndex = 0;
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote)];
    
    
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tblNotes = table;
    self.tblNotes.delegate = self;
    self.tblNotes.dataSource = self;
    self.tblNotes.tableFooterView = [[UIView alloc]init];
    self.tblNotes.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    [self.view addSubview:self.tblNotes];
    self.arrNotes = [NSMutableArray array];
    
    [self fecthNotes];
}

- (void)addNote
{
    EditNoteViewController *edit = [[EditNoteViewController alloc]initWithRecord:nil delegate:self];

    [self.navigationController pushViewController:edit animated:YES];
    
}

- (void)editNote
{
    EditNoteViewController *edit = [[EditNoteViewController alloc]initWithRecord:self.arrNotes[self.selectedNoteIndex] delegate:self];
    
    [self.navigationController pushViewController:edit animated:YES];
    
}


#pragma mark EditNoteViewControllerDelegate
- (void)didSaveNote:(CKRecord *)record isEdited:(BOOL)isEdited
{
    if (record) {
        if (!isEdited) {
            [self.arrNotes addObject:record];
            [self.tblNotes reloadData];
        }
        
    }
    
}


#pragma mark UITableViewDataSoures methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrNotes.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifer];
    }
    
    CKRecord *record = [self.arrNotes objectAtIndex:indexPath.row];
    cell.textLabel.text = [record objectForKey:@"noteTitle"];
    cell.detailTextLabel.text = [[record objectForKey:@"noteEditedDate"] description];
    CKAsset *asset = [record objectForKey:@"noteImage"];
    UIImage *image = [UIImage imageWithContentsOfFile:[[asset fileURL]path]];
    cell.imageView.image = image;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    

    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedNoteIndex = indexPath.row;
    [self editNote];
    
}



- (void)fecthNotes
{
    CKContainer *container = [CKContainer defaultContainer];
    CKDatabase *dataBase = [container privateCloudDatabase];
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    CKQuery *query = [[CKQuery alloc]initWithRecordType:@"Notes" predicate:predicate];
    [dataBase performQuery:query inZoneWithID:nil completionHandler:^(NSArray *results, NSError *error) {
       
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
        else
        {
            NSLog(@"%@",results);
            for (CKRecord *record in results) {
                
                [self.arrNotes addObject:record];
                
            }
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
               
                [self.tblNotes reloadData];
                
                
            }];
            
        }
        
        
        
    }];
    
}



@end





