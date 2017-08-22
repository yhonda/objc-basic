//
//  ViewController.m
//  STVProject2-1-4
//
//  Created by kawaharadai on 2017/08/19.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// プロパティの定義
@property UIAlertController * alertController;
@property UIAlertAction * cancelButton;
@property UIAlertAction * okButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //アラートコントローラーの初期化メソッドを呼ぶ
    [self initAlertController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// アラートコントローラーの初期化メソッド
-(void)initAlertController {
    // アラートコントローラーを用意（初期化）
    self.alertController = [UIAlertController
                            alertControllerWithTitle:@"確認"
                            message:@"次の課題の課題に進みます。"
                            preferredStyle:UIAlertControllerStyleAlert];
    // キャンセルボタンと処理内容を用意
    self.cancelButton = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action) {
                             NSLog(@"課題内容を修正します。");
                         }];
    // OKボタンと処理内容を用意
    self.okButton = [UIAlertAction
                     actionWithTitle:@"OK"
                     style:UIAlertActionStyleDefault
                     handler:^(UIAlertAction * action) {
                         NSLog(@"次の課題を開始します。");
                     }];
    
    // 用意したボタンアクション２つをアラートコントローラーにセット
    [self.alertController addAction:self.cancelButton];
    [self.alertController addAction:self.okButton];
}

// 確認ボタンメソッド
- (IBAction)confirmButton:(id)sender {
    // アラートコントローラーを表示
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
