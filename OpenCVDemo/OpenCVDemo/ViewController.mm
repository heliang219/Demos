//
//  ViewController.m
//  OpenCVDemo
//
//  Created by pfl on 15/9/16.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "ViewController.h"

//#include <highgui.h>
//#include <cvaux.h>
//#include <ml.h>

#import <vector>
#import "DetectRegions.h"
#import "OCR.h"
#import <opencv2/highgui/cap_ios.h>


using namespace std;
using namespace cv;

string getFilename(string s) {
    
    char sep = '/';
    char sepExt='.';
    
#ifdef _WIN32
    sep = '\\';
#endif
    
    size_t i = s.rfind(sep, s.length( ));
    NSLog(@"i:%zu",i);
    if (i != string::npos) {
        string fn= (s.substr(i+1, s.length( ) - i));
        size_t j = fn.rfind(sepExt, fn.length( ));
        if (i != string::npos) {
            NSLog(@"fn.substr:%s",fn.substr(0,j).c_str());
            return fn.substr(0,j);
        }else{
            NSLog(@"fn.substr:%s",fn.c_str());
            return fn;
        }
    }else{
        NSLog(@"fn.substr");
        return "";
    }
}


@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, CvVideoCameraDelegate, CvPhotoCameraDelegate>
@property (nonatomic, readwrite, strong) UIButton *button;
@property (nonatomic, readwrite, strong) UIImageView *imgeView;
@property (nonatomic, readwrite, strong) CvVideoCamera *videoCamera;
@property (nonatomic, readwrite, strong) CvPhotoCamera *photoCamera;
@property (nonatomic, readwrite, strong) UIButton *startButton;
@property (nonatomic, readwrite, strong) UIButton *photoButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.imgeView];
    [self.view addSubview:self.button];
    [self videoCamera];
    [self photoCamera];
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.photoButton];

    [self.photoCamera start];


}

- (void)identifyImageForPath:(NSString*)path img:(cv::Mat &)img {
#if 1
    cout << "OpenCV Automatic Number Plate Recognition\n";
    NSString *filenames = path;//[[NSBundle mainBundle]pathForResource:@"3028BYS.JPG" ofType:nil];
    const char *filename = [filenames cStringUsingEncoding:NSUTF8StringEncoding];
    Mat input_image;
    input_image = img;
    if (path) {
        input_image=imread(filename,1);
    }
    
    //Check if user specify image to process
    string filename_whithoutExt = getFilename(filename);
    
    
    cout << "working with file: "<< filename_whithoutExt << "\n";
    
    //Detect posibles plate regions
    DetectRegions detectRegions;
    detectRegions.setFilename(filename_whithoutExt);
    detectRegions.saveRegions=false;
    detectRegions.showSteps=false;
    NSLog(@"input_image:%d",input_image.empty());
    vector<Plate> posible_regions= detectRegions.run( input_image );
    //SVM for each plate region to get valid car plates
    //Read file storage.
    FileStorage fs;
    NSString *svmPath = [[NSBundle mainBundle]pathForResource:@"SVM.xml" ofType:nil];
    const char *svm = [svmPath cStringUsingEncoding:NSUTF8StringEncoding];
    fs.open(svm, FileStorage::READ);
    Mat SVM_TrainingData;
    Mat SVM_Classes;
    fs["TrainingData"] >> SVM_TrainingData;
    fs["classes"] >> SVM_Classes;
    //Set SVM params
    CvSVMParams SVM_params;
    SVM_params.svm_type = CvSVM::C_SVC;
    SVM_params.kernel_type = CvSVM::LINEAR; //CvSVM::LINEAR;
    SVM_params.degree = 0;
    SVM_params.gamma = 1;
    SVM_params.coef0 = 0;
    SVM_params.C = 1;
    SVM_params.nu = 0;
    SVM_params.p = 0;
    SVM_params.term_crit = cvTermCriteria(CV_TERMCRIT_ITER, 1000, 0.01);
    //Train SVM
    CvSVM svmClassifier(SVM_TrainingData, SVM_Classes, Mat(), Mat(), SVM_params);
    
    //For each possible plate, classify with svm if it's a plate or no
    vector<Plate> plates;
    for(int i=0; i< posible_regions.size(); i++)
    {
        Mat img=posible_regions[i].plateImg;
        Mat p= img.reshape(1, 1);
        p.convertTo(p, CV_32FC1);
        
        int response = (int)svmClassifier.predict( p );
        if(response==1)
            plates.push_back(posible_regions[i]);
    }
    
    cout << "Num plates detected: " << plates.size() << "\n";
    //For each plate detected, recognize it with OCR
    
    NSString *ocrPath = [[NSBundle mainBundle]pathForResource:@"OCR.xml" ofType:nil];
    const char *ocr_ = [ocrPath cStringUsingEncoding:NSUTF8StringEncoding];
    
    OCR ocr(ocr_);
    ocr.saveSegments=true;
    ocr.debu = false;
    ocr.filename=filename_whithoutExt;
    for(int i=0; i< plates.size(); i++){
        Plate plate=plates[i];
        
        string plateNumber=ocr.run(&plate);
        string licensePlate=plate.str();
        cout << "================================================\n";
        cout << "License plate number: "<< licensePlate << "\n";
        cout << "================================================\n";
        rectangle(input_image, plate.position, Scalar(0,0,200));
        putText(input_image, licensePlate, cv::Point(plate.position.x, plate.position.y), CV_FONT_HERSHEY_SIMPLEX, 1, Scalar(0,0,200),2);
        
    }
    
    
    self.imgeView.image = [self UIImageFromCVMat:input_image];

#endif
 
}


-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}



- (UIImageView*)imgeView {
    if (!_imgeView) {
       
        _imgeView = ({UIImageView *imgeView = [[UIImageView alloc]initWithFrame:({
           CGRect frame = CGRectMake(0, CGRectGetMaxY(self.button.frame)+10, self.view.bounds.size.width, CGRectGetHeight(self.view.bounds)-CGRectGetMaxY(self.button.frame)-64);
            frame;
        })];
            imgeView.contentMode = UIViewContentModeScaleAspectFit;
            imgeView;
        }) ;
    }
    
    return _imgeView;
}

- (UIButton*)button {
    if (!_button) {
        _button = ({
            UIButton *btn = [[UIButton alloc]initWithFrame:({
                CGRect rect = CGRectMake(0, 0, 100, 44);
                rect;
            })];
            btn.center = CGPointMake(CGRectGetMidX(self.view.bounds)-120, 80);
            [btn setTitle:@"识别" forState:(UIControlStateNormal)];
            [btn setBackgroundColor:[UIColor redColor]];
            [btn addTarget:self action:@selector(btnPress:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.tag = 1;
            btn;
        });
    }
    return _button;
}

- (void)btnPress:(UIButton*)btn {
    
    if (btn.tag == 3) {
        [self.photoCamera takePicture];
        return;
    }
    if (btn.tag == 2) {
        [self.videoCamera start];
        return;
    }
    BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)];
    if (isCamera) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark UIImagePickerControllerDelegate 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
             NSString *path = [self writeToPathForImage:image];
            Mat img;
            [self identifyImageForPath:path img:img];
        });

    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)writeToPathForImage:(UIImage*)image {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"img"];
    path = [path stringByAppendingPathExtension:@"jpg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [imageData writeToFile:path atomically:YES];
    
    return path;
}

- (UIButton*)startButton {
    if (!_startButton) {
        _startButton = ({
            UIButton *btn = [[UIButton alloc]initWithFrame:({
                CGRect rect = CGRectMake(0, 0, 100, 44);
                rect;
            })];
            [btn setTitle:@"拍摄" forState:(UIControlStateNormal)];
            [btn setBackgroundColor:[UIColor redColor]];
            btn.center = CGPointMake(CGRectGetMidX(self.view.bounds), self.button.center.y);
            [btn addTarget:self action:@selector(btnPress:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.tag = 2;
            btn;
        });
    }
    return _startButton;
}

- (UIButton*)photoButton {
    if (!_photoButton) {
        _photoButton = ({
            UIButton *btn = [[UIButton alloc]initWithFrame:({
                CGRect rect = CGRectMake(0, 0, 100, 44);
                rect;
            })];
            [btn setTitle:@"相机" forState:(UIControlStateNormal)];
            [btn setBackgroundColor:[UIColor redColor]];
            btn.center = CGPointMake(CGRectGetMidX(self.view.bounds)+120, self.button.center.y);
            [btn addTarget:self action:@selector(btnPress:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.tag = 3;
            btn;
        });
    }
    return _photoButton;
}



- (CvVideoCamera*)videoCamera {
    if (!_videoCamera) {
        _videoCamera = [[CvVideoCamera alloc]initWithParentView:self.imgeView];
        _videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
        _videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
        _videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
        _videoCamera.defaultFPS = 30;
        _videoCamera.grayscaleMode = NO;
        _videoCamera.delegate = self;
    }
    return _videoCamera;
}

#pragma mark CvVideoCameraDelegate
- (void)processImage:(cv::Mat &)image {
    Mat image_input;
    cvtColor(image, image_input, CV_BGR2GRAY);
//    [self identifyImageForPath:nil img:image];
//    bitwise_not(image_input, image_input);
//    cvtColor(image_input, image, CV_BGR2GRAY);
}

- (CvPhotoCamera*)photoCamera {
    if (!_photoCamera) {
        _photoCamera = [[CvPhotoCamera alloc]initWithParentView:self.imgeView];
        _photoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
        _photoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
        _photoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
        _photoCamera.defaultFPS = 30;
        _photoCamera.delegate = self;
    }
    return _photoCamera;
}

#pragma mark CvPhotoCameraDelegate 
- (void)photoCamera:(CvPhotoCamera *)photoCamera capturedImage:(UIImage *)image {
    NSLog(@"image:%@",image);
   NSString *path = [self writeToPathForImage:image];
    Mat img;
    [self identifyImageForPath:path img:img];
    [photoCamera stop];
    
    
}

- (void)photoCameraCancel:(CvPhotoCamera *)photoCamera {
    
}





@end












