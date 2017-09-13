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
// プロパティを定義
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated {
    // 受け渡し後、値をクリアする
    self.textField.text = [[NSString alloc]init];
}

// リターンキーでテキストを送信する
// 同時にキーボードを閉じる
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sendText:nil];
    return [textField resignFirstResponder];
}

// テキストフィールド以外のタップでキーボードを閉じる
- (IBAction)keyBoardClose:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)sendText:(id)sender {

    //他storyboardの読み込み
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    
    // 遷移先クラスをインスタンス化して呼び出す
    SecondViewController *secondViewController = [secondStoryboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    secondViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    // 未入力の場合、代わりのメッセージを代入。
    if (self.textField.text.length == 0) {
        //textFieldが空の時
        self.textField.text = @"値が入力されていません。";
    }
    
    // テキストフィールド内のテキストを受け渡し用の変数にセットする
    secondViewController.receiveString = self.textField.text;
    // 画面遷移
    [self presentViewController: secondViewController animated:YES completion: nil];
    
}
@end
