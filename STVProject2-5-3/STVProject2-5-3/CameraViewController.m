//
//  CameraViewController.m
//  STVProject2-5-3
//
//  Created by kawaharadai on 2017/09/09.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()
// プロパティを定義
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic) AVCaptureSession *session;
@property (weak, nonatomic) IBOutlet UIButton *retakeButton;
@property (weak, nonatomic) IBOutlet UIButton *setPictureButton;

// メソッドを定義

@end

@implementation CameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 撮影開始
    [self setupAVCapture];
    
    
}

- (void)setupAVCapture
{
    // セッション作成
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetHigh;  // セッション画質設定
    
    // デバイス取得
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 入力作成
    AVCaptureDeviceInput* deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [self.session addInput:deviceInput];  // セッションに追加
    
    // 出力作成
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    [self.session addOutput:self.stillImageOutput]; // セッションに追加
    
    // プレビュー作成
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    captureVideoPreviewLayer.frame = self.view.bounds;
    captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    // プレビューを表示
    [self.view addSubview:self.previewView]; // ビューを画面に貼り付け
    [self.view sendSubviewToBack:self.previewView]; // ビューを最背面に移動
    
    // プレビューに画像表示
    CALayer *previewLayer = self.previewView.layer;
    previewLayer.masksToBounds = YES;
    // マスク設定(Viewからはみ出た部分を削除)
    [previewLayer addSublayer:captureVideoPreviewLayer];
    
    // セッション開始
    [self.session startRunning];
}

- (IBAction)takePhoto:(id)sender {
    
    // ビデオ入力のAVCaptureConnectionを取得
    [self takePhoto];
    [self.session stopRunning];
    //（ここをONにすると落ちる、しなければ、撮影後プレビューを作成できない）
}

// 撮影メソッド
- (void)takePhoto
{
    // ビデオコネクションを取得
    AVCaptureConnection * connection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    
    // 画像撮影
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error)
     {
         NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:data forKey:@"imageData"];
         
         if([defaults synchronize]) {
             
             NSLog(@"保存完了");
         }
     }];
    
}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)retakeButtonAction:(id)sender {
    [self.session startRunning];
}

@end

