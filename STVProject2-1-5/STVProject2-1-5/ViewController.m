//
//  ViewController.m
//  STVProject2-1-5
//
//  Created by kawaharadai on 2017/08/22.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// プロパティの定義
@property UIAlertController * alertController;
@property UIAlertAction * faceBookAction;
@property UIAlertAction * twitterAction;
@property UIAlertAction * lineAction;
@property UIAlertAction * cancelAction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // アラートコントローラーの初期化
    [self initAlertController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
// アラートコントローラーの初期化メソッド
- (void)initAlertController{
    // アラートコントローラーを用意（初期化）
    self.alertController =
    [UIAlertController alertControllerWithTitle:@"SNS投稿"
                                        message:@"連携するSNSを選んでください。"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    // Facebookボタンアクションを生成
    self.faceBookAction =
    [UIAlertAction actionWithTitle:@"Facebook"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"Facebook投稿を行います。");
                           }];
    // Twitterボタンアクションを生成
    self.twitterAction =
    [UIAlertAction actionWithTitle:@"Twitter"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"Twitter投稿を行います。");
                           }];
    // Lineボタンアクションを生成
    self.lineAction =
    [UIAlertAction actionWithTitle:@"Line"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"Line送信を行います。");
                           }];
    // キャンセルアクションを生成
    self.cancelAction =
    [UIAlertAction actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"ボタン操作をキャンセルしました。");
                           }];
    
    // コントローラにアクションを追加
    [self.alertController addAction:self.faceBookAction];
    [self.alertController addAction:self.twitterAction];
    [self.alertController addAction:self.lineAction];
    [self.alertController addAction:self.cancelAction];
}

// SNS投稿ボタンアクション
- (IBAction)snsButton:(id)sender {
    // アクションシートの表示
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
