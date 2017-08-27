//
//  ViewController.m
//  STVProject2-1-7
//
//  Created by kawaharadai on 2017/08/23.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // デリゲートを接続
    self.textField.delegate = self;
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
    
    // 最大入力文字数の定数を用意（毎回作られるが？）
    static int const maxTextLength = 30;
    
    // 入力済みのテキストを取得
    NSMutableString *inputedText = [textField.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [inputedText replaceCharactersInRange:range withString:string];
    
    // 入力中のテキストが30を超えたらそれ以上の入力を無効にする
    if ([inputedText length] > maxTextLength) {
        NSLog(@"30文字以上は入力できません。");
        return NO;
    }
    return YES;
}

// テキストフィールド以外のタップでキーボードを閉じる
- (IBAction)tapBackground:(id)sender {
    [self.view endEditing:YES];
}

@end
