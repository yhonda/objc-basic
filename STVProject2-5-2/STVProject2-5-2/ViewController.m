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
    }
    else {
        NSLog(@"カメラ起動失敗");
    }
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

@end
