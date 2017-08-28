//
//  ViewController.m
//  STVProject2-1-19
//
//  Created by kawaharadai on 2017/08/28.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // テキストフィールドのデリゲートを接続
    self.textField.delegate = self;
    self.textField.text = @"";
}

// リターンキーでテキストを送信する
// 同時にキーボードを閉じる
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // セグエを呼び出し
    [self performSegueWithIdentifier:@"moveToSecondViewController" sender:self];
    // キーボードを閉じる
    return [textField resignFirstResponder];
}

// テキストフィールド以外のタップでキーボードを閉じる
- (IBAction)keyBoardClose:(id)sender {
    [self.view endEditing:YES];
}

// 画面遷移のタイミングで移動先ViewControllerのラベルにテキストを受け渡す
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // セグエのidで受け渡し先を指定
    if ([segue.identifier isEqualToString: @"moveToSecondViewController"]) {
        //　SecondViewControllerをインスタンス化して、受け取り用変数に
        SecondViewController *secondViewController = segue.destinationViewController;
        
        // 未入力の場合、代わりのメッセージを代入。
        if (self.textField.text.length == 0) {
            //textFieldが空の時
            self.textField.text = @"値が入力されていません。";
        }
        // テキストフィールド内のテキストを受け渡し用の変数にセットする
        secondViewController.receiveString = self.textField.text;
        // 受け渡し後、値をクリアする
        self.textField.text = [[NSString alloc]init];
    }
}
@end
