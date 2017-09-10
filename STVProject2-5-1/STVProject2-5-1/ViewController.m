//
//  ViewController.m
//  STVProject2-5-1
//
//  Created by kawaharadai on 2017/09/06.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// メソッドを定義
- (IBAction)sendMailButton:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// メールを送るボタンアクション
- (IBAction)sendMailButton:(id)sender {
    // メールを利用できるかチェック
    if (![MFMailComposeViewController canSendMail]) {
        return;
    }
    
    // MFMailComposeViewControllerを定義＆初期化する
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    
    // デリゲートを設定
    mailComposeViewController.mailComposeDelegate = self;
    
    // 件名をセット
    [mailComposeViewController setSubject:@"アプリからメール送信"];
    
    // テストとして任意の画像を添付
    // 画像を用意
    UIImage *boraboraImage = [UIImage imageNamed:@"ボラボラ島"];
    // NSData変数を用意し、上記画像をpngデータに変換したものをセット
    NSData* imageData = [[NSData alloc] initWithData:UIImagePNGRepresentation(boraboraImage)];
    // メールコントローラーに画像データをセット（mimeType:データ形式区分、fileName:自由）
    [mailComposeViewController addAttachmentData:imageData mimeType:@"image/png" fileName:@"ボラボラ島.png"];
    
    // 本文に固定文を設定
    [mailComposeViewController setMessageBody:@"ここに本文を入力してください。" isHTML:NO];
    
    // 作成したメールコントローラーを表示
    [self presentViewController: mailComposeViewController animated:YES completion:nil];
}

// 送信後の結果を受け取る
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    switch (result) {
        case MFMailComposeResultCancelled:
            // 下書き削除の場合
            NSLog(@"キャンセルしました。");
            break;
        case MFMailComposeResultSaved:
            // 下書き保存の場合
            NSLog(@"保存成功です。");
            break;
        case MFMailComposeResultSent:
            // 送信成功の場合
            NSLog(@"送信成功です。");
            break;
        case MFMailComposeResultFailed:
            // 送信失敗の場合
            NSLog(@"送信失敗です。");
            break;
        default:
            break;
    }
    
    // いずれの場合もアクション後は送信前の画面に戻る
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
