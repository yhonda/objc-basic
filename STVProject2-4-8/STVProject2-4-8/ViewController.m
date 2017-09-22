//
//  ViewController.m
//  STVProject2-4-8
//
//  Created by kawaharadai on 2017/09/07.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import "InstagramController.h"

@interface ViewController ()
// メソッドを定義
@end

static NSString *const PostImageName = @"AngkorWat";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// インスタを呼び出して、画像を投稿する
- (IBAction)postInstagramButton:(id)sender {
    /*NSURL *instagramURL = [NSURL URLWithString:@"instagram://library?LocalIdentifier=4"];
     // URLが正しくスキーマとして動くかをチェックして、OKならリクエスト。これだと任意の画像が遅れない
     if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
     [[UIApplication sharedApplication] openURL:instagramURL];
     }
     */
    // instagramにスキームをリクエストして開いてみる
    if ([InstagramController canInstagramOpen]) {
        // 任意の画像を用意
        UIImage *image = [UIImage imageNamed:PostImageName];
        // instagram連携用のクラスをインスタンス化
        InstagramController *instagramController = [[InstagramController alloc]init];
        // 画像形式をinstagram用に変更するメソッドに用意した画像を渡す
        [instagramController setImage:image];
        // instagramControllerクラスをメインクラスに乗せる？
        [self.view addSubview: instagramController.view];
        // instagramControllerをViewControllerの子コントローラーに登録
        [self addChildViewController:instagramController];
        // instagramを表示するコントローラーの準備、画像の用意ができたら、画像送信のリクエストメソッドを呼び出す
        [instagramController openInstagram];
        
    } else {
        // Instagramがインストールされていないまたは、起動しない場合
        NSLog(@"Instagramがインストールされていません。");
    }
}

@end
