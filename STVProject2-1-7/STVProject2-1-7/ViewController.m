//
//  ViewController.m
//  STVProject2-1-7
//
//  Created by kawaharadai on 2017/08/23.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// プロパティを定義
@property (weak, nonatomic) IBOutlet UITextField *textField;
// メソッドを定義
- (IBAction)tapBackground:(id)sender;
@end

// 最大入力文字数の定数を用意
static int const maxTextLength = 30;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 入力開始後のみテキストをチェックし、空欄の場合はリターンキーを非活性にする
// shouldChangeCharactersInRangeでは最初の入力は補えないため
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // テキストフィールドが空欄かどうかチェック
    if (textField.text.length == 0) {
        textField.enablesReturnKeyAutomatically = YES;
    }
    return YES;
}

// テキストの文字数をチェックしているメソッド
// 編集中のみテキストをチェックし、空欄の場合はリターンキーを非活性にする
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 空欄チェック
    if (textField.text.length == 0) {
        textField.enablesReturnKeyAutomatically = YES;
    }
    
    // 入力済みのテキストを初期値として取得
    NSMutableString *inputedText = [textField.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [inputedText replaceCharactersInRange:range withString:string];
    
    // 入力中のテキストが30を超えたらそれ以上の入力を無効にする
    if ([inputedText length] > maxTextLength) {
        NSLog(@"%d文字以上は入力できません。", maxTextLength);
        return NO;
    }
    return YES;
}

// テキストフィールド以外のタップでキーボードを閉じる
- (IBAction)tapBackground:(id)sender {
    [self.view endEditing:YES];
}

@end
