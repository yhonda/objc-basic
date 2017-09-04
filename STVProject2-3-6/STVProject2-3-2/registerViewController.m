//
//  registerViewController.m
//  STVProject2-3-2
//
//  Created by kawaharadai on 2017/08/31.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "registerViewController.h"
#import "ViewController.h"
#import "FMDatabase.h"

@interface registerViewController ()

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // デリゲート接続
    self.registerTextField.delegate = self;
    self.registerTextView.delegate = self;
   
    // アラートを作成
    [self createAleart];
    
}

// 初回起動時に呼ぶ（初期IDを決める）
-(int)addTodo_id {
    // DB接続
    ViewController *viewController = [[ViewController alloc]init];
    FMDatabase *db = [viewController connectDataBase:@"test.db"];
    
    //count文の作成
    NSString *countTodo_id = [[NSString alloc] initWithFormat:@"select count(*) as count from tr_todo where todo_id"];
    
    // DBをオープン
    [db open];
    // セットしたcount文を回して、todo_idの数を数える
    FMResultSet *countRequest = [db executeQuery:countTodo_id];
    if([countRequest next]) {
        self.todo_id = [countRequest intForColumn:@"count"];
    }
    // DBを閉じる
    [db close];
    
    // 数えた値に+1をして返す
    return self.todo_id + 1;
}

- (NSString *)getCreated {
    // 当日の日付を取得
    //NSDateFormatterクラスを出力する。
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    //出力形式を文字列で指定する。
    [format setDateFormat:@"yyyy/MM/dd"];
    
    // 現在時刻を取得しつつ、NSDateFormatterクラスをかませて、文字列を出力する。
    return [format stringFromDate:[NSDate date]];
}

// 〜日後の期日を設定
- (NSString *)getLimit_date {
    
    //NSDateFormatterクラスを出力する。
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    //出力形式を文字列で指定する。
    [format setDateFormat:@"yyyy/MM/dd"];
    
    // 日付のオフセットを生成
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    
    // 〜日後を指定
    [dateComp setDay:7];
    
    // 〜日後のNSDateインスタンスを取得する
    NSDate *futureDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComp toDate:[NSDate date] options:0];
    
    // 〜日後のインスタンスをフォーマットにはめて返す
    return [format stringFromDate:futureDate];
}

// Delete_flgを返すメソッド
- (NSString *)getDelete_flg {
    return @"OFF";
}

// タイトル空欄時に表示するアラートを作成
- (void)createAleart {
    //アラートコントローラーの生成
    self.registerAlertController = [UIAlertController
                            alertControllerWithTitle:@"未入力"
                            message:@"タイトルの入力は必須です。"
                            preferredStyle:UIAlertControllerStyleAlert];
    
    self.doneAlertController = [UIAlertController alertControllerWithTitle:@"登録完了" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // OKボタンと処理内容を用意
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    
    // 閉じるボタン（処理：一覧画面に戻る）を用意
    UIAlertAction *backTopButton = [UIAlertAction
                                           actionWithTitle:@"閉じる"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               [self dismissViewControllerAnimated:YES completion:nil];
                                           }];
    
    // 連続登録ボタン（処理：その画面のまま、テキストをリセット）を用意
    UIAlertAction *continueRegistButton = [UIAlertAction
                                           actionWithTitle:@"連続登録"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               self.registerTextField.text = @"";
                                               self.registerTextView.text = @"";
                                               // リセット後に再度テキストビューを選択してあげる（何故か処理が遅くなる）
                                               [self.registerTextField becomeFirstResponder];
                                           }];

    // 用意したボタンアクションをアラートコントローラーにセット
    [self.registerAlertController addAction:okButton];
    [self.doneAlertController addAction:backTopButton];
    [self.doneAlertController addAction:continueRegistButton];

}

// 登録アクション
- (void)registerAction {
    
    ViewController *viewController = [[ViewController alloc]init];
    FMDatabase *db = [viewController connectDataBase:@"test.db"];
    
    // todo_idをセット（0をセットまたは+1で返す）
    self.todo_id = [self addTodo_id];
    // createdを取得
    self.created = [self getCreated];
    // modifiedを取得
    self.modified = [self getCreated];
    // limit_dateを取得
    self.limit_date = [self getLimit_date];
    // self.limit_date = @"2017/09/22";
    // delete_flgを設定
    self.delete_flg = [self getDelete_flg];
    // テキストフィールドからタイトルを取得
    self.todo_title = self.registerTextField.text;
    // テキストビューから内容を取得
    self.todo_contents = self.registerTextView.text;
    
    // 取得した情報をデータベースに登録
    NSString *insert = [[NSString alloc] initWithFormat:@"INSERT INTO tr_todo(todo_id, todo_title, todo_contents, created, modified, limit_date, delete_flg) VALUES('%d', '%@', '%@', '%@', '%@', '%@', '%@')", self.todo_id, self.todo_title, self.todo_contents, self.created, self.modified, self.limit_date, self. delete_flg];
    
    [db open];
    
    [db executeUpdate:insert];
    
    [db close];
    
    // 処理完了後、アラートを表示
    [self presentViewController:self.doneAlertController animated:YES completion:nil];
    
}
// 登録ボタン
- (IBAction)resisterButton:(id)sender {
    // タイトルが空欄の場合はアラートを出し、問題がなければ登録アクションの呼び出し
    if (self.registerTextField.text.length == 0) {
        [self presentViewController:self.registerAlertController animated:YES completion:nil];
    } else {
        [self registerAction];
    }
}

// 戻るボタン
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 背景タップでキーボードを閉じる
- (IBAction)backgroundKeyboard:(id)sender {
    [self.view endEditing:YES];
}

// リターンキーでキーボードを下げる
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
