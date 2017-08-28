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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // アラートコントローラーの生成
    self.alertController =
    [UIAlertController alertControllerWithTitle:@"SNS投稿"
                                        message:@"連携するSNSを選んでください。"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    // Facebookボタンアクションを生成
    UIAlertAction *faceBookAction =
    [UIAlertAction actionWithTitle:@"Facebook"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"Facebook投稿を行います。");
                           }];
    // Twitterボタンアクションを生成
    UIAlertAction *twitterAction =
    [UIAlertAction actionWithTitle:@"Twitter"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"Twitter投稿を行います。");
                           }];
    // Lineボタンアクションを生成
    UIAlertAction *lineAction =
    [UIAlertAction actionWithTitle:@"Line"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"Line送信を行います。");
                           }];
    // キャンセルアクションを生成
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"ボタン操作をキャンセルしました。");
                           }];
    
    // コントローラにアクションを追加
    [self.alertController addAction: faceBookAction];
    [self.alertController addAction: twitterAction];
    [self.alertController addAction: lineAction];
    [self.alertController addAction: cancelAction];
}

// SNS投稿ボタンアクション
- (IBAction)snsButton:(id)sender {
    // アクションシートの表示
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
