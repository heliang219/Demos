//
//  ViewController.m
//  DropBoxDemo
//
//  Created by pfl on 15/5/18.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "ViewController.h"
#import <DropboxSDK/DropboxSDK.h>

#define tinkColor [UIColor colorWithRed:0.980f green:0.604f blue:0.000f alpha:1.00f]

@interface ViewController ()<DBRestClientDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIBarButtonItem *bbiConnect;
@property (nonatomic, strong) DBRestClient *dbRestClient;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) NSInteger uploadIndex;
@property (nonatomic, strong) UIProgressView *progressBar;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIImage *theImage;
@property (nonatomic, strong) DBMetadata *dropboxMetadata;
@end

@implementation ViewController
@synthesize bbiConnect,dbRestClient,path,uploadIndex,progressBar,myTableView,theImage,dropboxMetadata;
- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAction) target:self action:@selector(performAction)];
    item1.tintColor = tinkColor;
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemRefresh) target:self action:@selector(reloadFiles)];
    item2.tintColor = tinkColor;
    self.navigationItem.rightBarButtonItems = @[item1,item2];;
    
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithRed:0.980f green:0.604f blue:0.000f alpha:1.00f]};

    bbiConnect = [[UIBarButtonItem alloc]initWithTitle:@"Disconnect" style:(UIBarButtonItemStylePlain) target:self action:@selector(reloadFiles)];
    self.navigationItem.leftBarButtonItem = bbiConnect;
   
    [item2 setTitleTextAttributes:dic forState:(UIControlStateNormal)];
    [item1 setTitleTextAttributes:dic forState:(UIControlStateNormal)];
    [bbiConnect setTitleTextAttributes:dic forState:(UIControlStateNormal)];
    
    progressBar = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    progressBar.frame = CGRectMake(10, 0, self.view.frame.size.width-20, 10);
    progressBar.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 20);
    progressBar.tintColor = tinkColor;
    progressBar.trackTintColor = [UIColor greenColor];
    [self.view addSubview:progressBar];
    
    myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    [self.view bringSubviewToFront:progressBar];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDidLinkNotification:) name:@"didLinkToDropboxAccountNotification" object:nil];
    
    if ([[DBSession sharedSession]isLinked]) {
        bbiConnect.title = @"Disconnect";
        [self initDropboxRestClient];
    }else
    {
        bbiConnect.title = @"Connect";
    }
    
}

- (void)reloadFiles
{
    [dbRestClient loadMetadata:@"/"];
}

- (void)performAction
{
    if (![[DBSession sharedSession]isLinked]) {
        NSLog(@"You're not connected to Dropbox");
        return;
    }
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Upload file" message:@"select file to upload" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *uploadTextFileAction = [UIAlertAction actionWithTitle:@"Upload text file" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        NSString *sourePath = [[NSBundle mainBundle] pathForResource:@"testText" ofType:@"txt"];
        NSString *fileName = @"testText.txt";
        NSString *destinationPath = @"/";
        
        [self showProgressBar];
        
        uploadIndex++;
        
        [dbRestClient uploadFile:fileName toPath:destinationPath withParentRev:nil fromPath:sourePath];
        
    }];
    UIAlertAction *uploadImageFileAction = [UIAlertAction actionWithTitle:@"Upload image" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
        }];
        
//        NSString *sourePath = [[NSBundle mainBundle] pathForResource:@"mm" ofType:@"jpg"];
//        NSString *fileName = @"mm.jpg";
//        [dbRestClient uploadFile:fileName toPath:@"/" withParentRev:nil fromPath:sourePath];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {}];
    [actionSheet addAction:uploadTextFileAction];
    [actionSheet addAction:uploadImageFileAction];
    [actionSheet addAction:cancelAction];
    [self.navigationController presentViewController:actionSheet animated:YES completion:nil];
    
}

- (void)connectToDropBox
{
    if (![[DBSession sharedSession]isLinked]) {
        [[DBSession sharedSession]linkFromController:self];
    }else
    {
        [[DBSession sharedSession]unlinkAll];
        dbRestClient = nil;
    }
}



- (void)initDropboxRestClient
{
    dbRestClient = [[DBRestClient alloc]initWithSession:[DBSession sharedSession]];
    dbRestClient.delegate = self;
    [dbRestClient loadMetadata:@"/"];
    
}

- (void)handleDidLinkNotification:(NSNotification*)notification
{
    [self initDropboxRestClient];
    bbiConnect.title = @"Disconnect";
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dropboxMetadata) {
        return dropboxMetadata.contents.count;
    }
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
   
    DBMetadata *metadata = dropboxMetadata.contents[indexPath.row];

    cell.textLabel.text = metadata.filename;
    if (theImage) {
         cell.imageView.image = theImage;
    }
   

    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fileName = [(DBMetadata*)dropboxMetadata.contents[indexPath.row] path];
    NSString *toPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"file"];
    [self showProgressBar];
    [dbRestClient loadFile:fileName intoPath:toPath];
    
}


#pragma mark DBRestClientDelegate
- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error
{
    NSLog(@"error:%@",error.localizedDescription);
    progressBar.hidden = YES;
}

- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath from:(NSString *)srcPath metadata:(DBMetadata *)metadata
{
    NSLog(@"metadata:%@",metadata.path);
    
    if (path) {
        NSError *error;
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:path]) {
            [manager removeItemAtPath:path error:&error];
            if (error) {
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:error.localizedDescription delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            }
            else
            {
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"上传成功,本地删除成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                progressBar.hidden = YES;
            }
        }
    }
    
    [dbRestClient loadMetadata:@"/"];
    
}

- (void)restClient:(DBRestClient *)client uploadProgress:(CGFloat)progress forFile:(NSString *)destPath from:(NSString *)srcPath
{
    progressBar.progress = progress;
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata
{
    dropboxMetadata = metadata;
    [myTableView reloadData];
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error
{
    NSLog(@"error:%@",error.localizedDescription);
    progressBar.hidden = YES;
}

- (void)restClient:(DBRestClient *)client loadProgress:(CGFloat)progress forFile:(NSString *)destPath
{
    progressBar.progress = progress;
    
}

- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)destPath contentType:(NSString *)contentType metadata:(DBMetadata *)metadata
{
    NSLog(@"The file %@ was downloaded. Content type: %@",metadata.filename,contentType);
    
    progressBar.hidden = YES;
}



#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    theImage = image;
    
    [self saveImageLocally:image];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImageLocally:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"img"];
    [imageData writeToFile:path atomically:YES];
    
    NSString *sourePath = path;
    NSString *fileName =[NSString stringWithFormat:@"img%ld.jpg",uploadIndex++];
    NSString *destinationPath = @"/";
    
    [self showProgressBar];
    
    [dbRestClient uploadFile:fileName toPath:destinationPath withParentRev:nil fromPath:sourePath];
}

- (void)showProgressBar
{
    progressBar.progress = 0.0;
    progressBar.hidden = NO;
}

@end




















