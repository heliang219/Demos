//
//  EditNoteViewController.m
//  CloudKitDemo
//
//  Created by pfl on 15/5/18.
//  Copyright (c) 2015年 pfl. All rights reserved.
//


#import "EditNoteViewController.h"

@interface EditNoteViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) CKRecord *selectedRecord;
@property (nonatomic, copy) NSString *titleNote;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextView *detailTextView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *theImage;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, weak) id <EditNoteViewControllerDelegate> delegate;
@end

@implementation EditNoteViewController
@synthesize titleField,detailTextView,imageView,btn,imageUrl;
- (instancetype)initWithRecord:(CKRecord *)record delegate:(id<EditNoteViewControllerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.selectedRecord = record;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"编辑";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"save" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveNote)];
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithRed:0.980f green:0.604f blue:0.000f alpha:1.00f]};
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"cancel" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancel)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dic forState:(UIControlStateNormal)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:dic forState:(UIControlStateNormal)];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadUI];
   
    [self addGesture];
    
    
}


- (void)addGesture
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeDownGestureRecognizer)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
}

- (void)handleSwipeDownGestureRecognizer
{
    [titleField resignFirstResponder];
    [detailTextView resignFirstResponder];
}

- (void)loadUI
{

    
    
    titleField = [[UITextField alloc]initWithFrame:CGRectMake(20, 84, [UIScreen mainScreen].bounds.size.width-40, 40)];
    titleField.layer.cornerRadius = 5.f;
    
    titleField.backgroundColor = [UIColor colorWithRed:0.980f green:0.604f blue:0.000f alpha:1.00f];
    [self.view addSubview:titleField];
    
    detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titleField.frame)+20, [UIScreen mainScreen].bounds.size.width-40,150)];
    detailTextView.layer.cornerRadius = 5.f;
    detailTextView.backgroundColor = titleField.backgroundColor;
    [self.view addSubview:detailTextView];
    

    btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
    btn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(detailTextView.frame) + 100);
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"select a photo" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(addActionSheet) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(detailTextView.frame)+20, CGRectGetWidth(titleField.frame), CGRectGetHeight(self.view.frame)-CGRectGetMinY(imageView.frame))];
    imageView.hidden = YES;
    [self.view addSubview:imageView];
    
    if (self.selectedRecord) {
        btn.hidden = YES;
        imageView.hidden = NO;
        titleField.text = [self.selectedRecord objectForKey:@"noteTitle"];
        detailTextView.text = [self.selectedRecord objectForKey:@"noteText"];
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:((CKAsset*)[self.selectedRecord objectForKey:@"noteImage"]).fileURL]];
    }
    
}


- (void)addActionSheet
{

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选取资料" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"手机相册",@"拍照", nil];
    [sheet showInView:self.view];

}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *imagePicke = [[UIImagePickerController alloc]init];
    imagePicke.delegate = self;
    
    if (buttonIndex == 0) {// 相册

        if (![UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
            return;
        }
        imagePicke.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePicke animated:YES completion:nil];


    }
    else if (buttonIndex == 1)// 相机
    {
        if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            return;
        }
        
        if (![UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
            return;
        }
        
        imagePicke.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicke animated:YES completion:nil];


    }else// 取消
    {

    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.theImage = info[UIImagePickerControllerOriginalImage];
    imageView.image = self.theImage;
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.hidden = NO;
    btn.hidden = YES;
    
    [self autoWriteLocally:self.theImage];
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)autoWriteLocally:(UIImage*)image
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"img"];
    imageUrl = [NSURL fileURLWithPath:path];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [imageData writeToURL:imageUrl atomically:YES];
    

}



- (void)saveNote
{
    if (![titleField.text  isEqual: @""]) {
       
        BOOL isEdited = YES;
        self.titleNote = titleField.text;
        
        if (!self.selectedRecord)
        {
            isEdited = NO;
            NSString *timestampAsString = [NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]];
            NSString *noteID = [timestampAsString componentsSeparatedByString:@"."][0];
            CKRecordID *recordID = [[CKRecordID alloc]initWithRecordName:noteID];
            self.selectedRecord = [[CKRecord alloc]initWithRecordType:@"Notes" recordID:recordID];
        }
        
        [self.selectedRecord setObject:titleField.text forKey:@"noteTitle"];
        [self.selectedRecord setObject:detailTextView.text forKey:@"noteText"];
        [self.selectedRecord setObject:[NSDate date] forKey:@"noteEditedDate"];
        
        if (!imageUrl) {
            
            imageUrl = [[NSBundle mainBundle]URLForResource:@"no_image" withExtension:@"png"];
        }
        
        [self.selectedRecord setObject:[[CKAsset alloc]initWithFileURL:imageUrl] forKey:@"noteImage"];
        
        CKContainer *container = [CKContainer defaultContainer];
        CKDatabase *database = [container privateCloudDatabase];
        [database saveRecord:self.selectedRecord completionHandler:^(CKRecord *record, NSError *error) {
            
            if (!error) {
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(didSaveNote:isEdited:)]) {
                    [self.delegate didSaveNote:record isEdited:isEdited];
                }
                
            }
            
        }];
            
        
    }
}

- (void)cancel
{
    if (imageUrl) {
        
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:imageUrl.absoluteString]) {
            [manager removeItemAtURL:imageUrl error:nil];
        }
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end









