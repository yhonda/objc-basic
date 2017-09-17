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
- (IBAction)cameraButton:(id)sender;
- (IBAction)albumButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (void)settingImagePickerController;
// プロパティを定義
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingImagePickerController];
}

// imagePickerControllerを用意
- (void)settingImagePickerController {
    // UIImagePickerControllerのインスタンスの作成
    self.imagePickerController = [[UIImagePickerController alloc]init];
    // カメラの利用(SourceTypeCameraでカメラ系機能の選択肢からタイプを指定)
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    // imagepickerのデリゲートを適用
    self.imagePickerController.delegate = self;
}

// カメラボタンアクション
- (IBAction)cameraButton:(id)sender {
    // カメラが利用可能かチェック(カメラ機能の選択肢があるのかを)
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // selfのviewに用意したimagepickercontrollerを反映する（載せる）
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    } else {
        NSLog(@"カメラ起動失敗");
    }
}

// アルバムボタンアクション
- (IBAction)albumButton:(id)sender {
    // アルバムの利用
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = sourceType;
        cameraPicker.delegate = self;
        
        // ビューを開く
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
    // イメージのフォトアルバムへの書き込み
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}

//　撮影が完了時した時に呼ばれるメソッド
- (void)imagePickerController: (UIImagePickerController *)imagePicker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // infoDicから撮影後のオリジナル画像を取り出す（キー値:撮影時に専用の番号（NSString）,値:UIimage型で格納されている）
    UIImage *PictureImage = info[UIImagePickerControllerOriginalImage];
    [self.imageView setImage:PictureImage];
    // 設定後戻る
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

@end
