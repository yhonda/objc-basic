//
//  CameraViewController.m
//  STVProject2-5-3
//
//  Created by kawaharadai on 2017/09/09.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController () <AVCapturePhotoCaptureDelegate>
// プロパティを定義
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 撮影開始
    [self setupAVCapture];
}

- (void)setupAVCapture {
    // セッション作成
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPreset1920x1080;
    //　AVCapturePhotoOutputを用意
    self.stillImageOutput = [[AVCapturePhotoOutput alloc] init];
    // デバイス取得
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // エラー判定を用意
    NSError *error = [[NSError alloc] init];
    
    // 入力作成
    AVCaptureDeviceInput* deviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:device error:&error];
    [self.session addInput:deviceInput];
    
    // 設定を反映
    [self.session addOutput:self.stillImageOutput];
    
     // 撮影用カメラビューの画質設定
    AVCaptureVideoPreviewLayer* captureVideoLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    captureVideoLayer.frame = self.previewView.bounds;
    captureVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.previewView.layer addSublayer:captureVideoLayer];
    
    // カメラ撮影スタート
    [self.session startRunning];
}

- (IBAction)takePhoto:(id)sender {
    // ビデオ入力のAVCaptureConnectionを取得
    [self takePhoto];
}

// 撮影メソッド
- (void)takePhoto {
    // ビデオコネクションを取得
    AVCapturePhotoSettings* settings = [[AVCapturePhotoSettings alloc] init];
    settings.flashMode = AVCaptureFlashModeAuto;
    [self.stillImageOutput capturePhotoWithSettings:settings delegate:self];
}

- (void)savePhotoData:(NSData *)photoData {
    // 画像を保存する
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    [defaults setObject:photoData forKey:@"imageData"];
    [defaults synchronize];
    // メイン画面に戻る
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput
didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer
previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer
    resolvedSettings:(nonnull AVCaptureResolvedPhotoSettings *)resolvedSettings
     bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings
               error:(nullable NSError *)error {
    // jpeg形式で撮影画像をデータ化
    NSData* photoData = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
    // 画像の保存、画面遷移
    [self savePhotoData:photoData];
}
@end

