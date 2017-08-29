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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //アラートコントローラーの生成
    self.alertController = [UIAlertController
                            alertControllerWithTitle:@"確認"
                            message:@"次の課題の課題に進みます。"
                            preferredStyle:UIAlertControllerStyleAlert];
    
    // キャンセルボタンと処理内容を用意
    UIAlertAction *cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       NSLog(@"課題内容を修正します。");
                                   }];
    // OKボタンと処理内容を用意
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   NSLog(@"次の課題を開始します。");
                               }];
    
    // 用意したボタンアクション２つをアラートコントローラーにセット
    [self.alertController addAction:cancelButton];
    [self.alertController addAction:okButton];
}

// 確認ボタンメソッド
- (IBAction)confirmButton:(id)sender {
    // アラートコントローラーを表示
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
