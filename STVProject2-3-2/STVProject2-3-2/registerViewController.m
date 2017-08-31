//
//  registerViewController.m
//  STVProject2-3-2
//
//  Created by kawaharadai on 2017/08/31.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "registerViewController.h"
#import "FMDatabase.h"

@interface registerViewController ()

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // デリゲート接続
    self.registerTextField.delegate = self;
    self.registerTextView.delegate = self;
    // DBと接続
    [self connectDatabase];
    // アラートを作成
    [self createAleart];
    
}

// データベースと接続する（インスタンス化）
- (void)connectDatabase {
    self.paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    self.dir = [self.paths objectAtIndex:0];
    self.database = [FMDatabase databaseWithPath:[self.dir stringByAppendingPathComponent:@"test.db"]];
}
// 初回起動時に呼ぶ（初期IDを決める）
-(int)addTodo_id {
    //count文の作成
    NSString *countTodo_id = [[NSString alloc] initWithFormat:@"select count(*) as count from tr_todo where todo_id"];
    // DBをオープン
    [self.database open];
    // セットしたcount文を回して、todo_idの数を数える
    FMResultSet *countRequest = [self.database executeQuery:countTodo_id];
    if([countRequest next]) {
        self.todo_id = [countRequest intForColumn:@"count"];
    }
    // DBを閉じる
    [self.database close];
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
    //
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
    self.alertController = [UIAlertController
                            alertControllerWithTitle:@"未入力"
                            message:@"タイトルの入力は必須です。"
                            preferredStyle:UIAlertControllerStyleAlert];
    
    // OKボタンと処理内容を用意
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    
    // 用意したボタンアクションをアラートコントローラーにセット
    [self.alertController addAction:okButton];
}

// 登録アクション
- (void)registerAction {
    
    // todo_idをセット（0をセットまたは+1で返す）
    self.todo_id = [self addTodo_id];
    // createdを取得
    self.created = [self getCreated];
    // modifiedを取得
    self.modified = [self getCreated];
    // limit_dateを取得
    self.limit_date = [self getLimit_date];
    // delete_flgを設定
    self.delete_flg = [self getDelete_flg];
    // テキストフィールドからタイトルを取得
    self.todo_title = self.registerTextField.text;
    // テキストビューから内容を取得
    self.todo_contents = self.registerTextView.text;
    
    // 取得した情報をデータベースに登録
    NSString *insert = [[NSString alloc] initWithFormat:@"INSERT INTO tr_todo(todo_id, todo_title, todo_contents, created, modified, limit_date, delete_flg) VALUES('%d', '%@', '%@', '%@', '%@', '%@', '%@')", self.todo_id, self.todo_title, self.todo_contents, self.created, self.modified, self.limit_date, self. delete_flg];
    
    [self.database open];
    
    [self.database executeUpdate:insert];
    
    [self.database close];
    
}
// 登録ボタン
- (IBAction)resisterButton:(id)sender {
    // タイトルが空欄の場合はアラートを出し、問題がなければ登録アクションの呼び出し
    if (self.registerTextField.text.length == 0) {
        [self presentViewController:self.alertController animated:YES completion:nil];
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
