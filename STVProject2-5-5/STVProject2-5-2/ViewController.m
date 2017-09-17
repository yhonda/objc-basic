//
//  ViewController.m
//  STVProject2-5-2
//
//  Created by kawaharadai on 2017/09/09.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// メソッドを定義
- (void)settingImagePickerController;
- (void)addFilterAction;
// プロパティを定義
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (weak, nonatomic) IBOutlet UIButton *addFilterButton;
@property (weak, nonatomic) IBOutlet UIButton *exceptFilterButton;
@property (strong, nonatomic) UIImage *saveImage;
@end

static NSString *const FilterName = @"CIMinimumComponent";
static NSString *const FilterSetKey = @"inputImage";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingImagePickerController];
}

// imagePickerControllerを用意
- (void)settingImagePickerController {
    self.imagePickerController = [[UIImagePickerController alloc]init];
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.delegate = self;
}

// カメラボタンアクション
- (IBAction)cameraButton:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    } else {
        NSLog(@"カメラ起動失敗");
    }
}

// アルバムボタンアクション
- (IBAction)albumButton:(id)sender {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = sourceType;
        cameraPicker.delegate = self;
        
        [self presentViewController:cameraPicker animated:YES completion:nil];
        NSLog(@"アルバムを起動しました。");
    } else {
        NSLog(@"アルバム起動に失敗しました。");
    }
}

// 保存ボタンアクション
- (IBAction)saveButton:(id)sender {
    UIImage *image = [self.imageView image];
    if (image == nil) {
        return;
    }
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}

//　撮影が完了時した時に呼ばれるメソッド
- (void)imagePickerController: (UIImagePickerController *)imagePicker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *PictureImage = info[UIImagePickerControllerOriginalImage];
    self.saveImage = PictureImage;
    [self.imageView setImage:PictureImage];
    // ボタンを戻す
    self.exceptFilterButton.enabled = NO;
    self.addFilterButton.enabled = YES;
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"メインイメージを更新しました。");
}

// 撮影がキャンセルされた時に呼ばれる（キャンセルボタンを押したとき）
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)imagePicker {
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"撮影をキャンセルしました。");
}

// 画像の保存を確認するメソッド
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo
{
    if (error != nil) {
        NSLog(@"イメージの保存に失敗しました。");
    } else {
        NSLog(@"イメージをアルバムに保存しました。");
    }
}

// フィルターをかける処理（モノクロ）
- (void)addFilterAction {
    // 加工前の画像を保存（戻す時のため）
    self.saveImage = [[UIImage alloc]init];
    self.saveImage = self.imageView.image;
    // 元画像を取得
    UIImage *originImage = self.imageView.image;
    
    // UIImageをCIImageに変換
    CIImage *filteredImage = [[CIImage alloc] initWithCGImage:originImage.CGImage];
    
    // CIFilterを作成（今回はモノクロフィルタ）
    CIFilter *filter = [CIFilter filterWithName:FilterName];
    [filter setValue:filteredImage forKey:FilterSetKey];
    // フィルタ後の画像を取得
    filteredImage = filter.outputImage;
    // CIContext,CGImageRefでフィルターを用意
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [ciContext createCGImage:filteredImage fromRect:filteredImage.extent];
    // CIImageをUIImageに変換（フィルターの適用）
    UIImage *outputImage  = [UIImage imageWithCGImage:imageRef scale:2.5f orientation:UIImageOrientationUp];
    // 使用後のフィルターを破棄
    CGImageRelease(imageRef);
    // イメージを表示
    self.imageView.image = outputImage;
    // ボタンの状態を変更
    self.exceptFilterButton.enabled = YES;
    self.addFilterButton.enabled = NO;
}
// フィルターをかけるメソッド
- (IBAction)addFilter:(id)sender {
    [self addFilterAction];
}
// 加工前の画像に戻す
- (IBAction)exceptFilter:(id)sender {
    // 加工前の画像を反映
    self.imageView.image = self.saveImage;
    // ボタンの状態を変更
    self.exceptFilterButton.enabled = NO;
    self.addFilterButton.enabled = YES;
}

@end
