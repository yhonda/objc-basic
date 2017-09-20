//
//  RegisterViewController.m
//  STVProject2-3-2
//
//  Created by kawaharadai on 2017/08/31.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterViewController.h"
#import "ViewController.h"
#import "FMDatabase.h"

@interface RegisterViewController () <UITextFieldDelegate,UITextViewDelegate>

@end

// Todoの期日指定を定数で用意（〜日後）
static int const TodoLimitAfterDays = 7;
// DB内で値に振るIDの増数値
static int const AddCountTodoId = 1;
// 日付のフォーマット
static NSString *const DateFormat = @"yyyy/MM/dd";

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // アラートを作成
    [self createAleart];
}

-(int)addTodoId {
    // DB接続
    ViewController *viewController = [[ViewController alloc]init];
    FMDatabase *db = [viewController connectDataBase:AccessDatabaseName];
    //count文の作成
    NSString *countTodoId = [[NSString alloc] initWithFormat:@"select count(*) as count from tr_todo where todo_id"];
    // DBをオープン
    [db open];
    // セットしたcount文を回して、todo_idの数を数える
    FMResultSet *countRequest = [db executeQuery:countTodoId];
    if([countRequest next]) {
        self.todoId = [countRequest intForColumn:@"count"];
    }
    // DBを閉じる
    [db close];
    // 数えた値に+1をして返す
    int latestTodoId = self.todoId + AddCountTodoId;
    
    return latestTodoId;
}

- (NSString *)getCreated {
    // 当日の日付を取得
    //NSDateFormatterクラスを出力する。
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    //出力形式を文字列で指定する。
    [format setDateFormat:DateFormat];
    // 現在時刻を取得しつつ、NSDateFormatterクラスをかませて、文字列を出力する。
    NSString *todayDate = [format stringFromDate:[NSDate date]];
    
    return todayDate;
}

// 〜日後の期日を設定
- (NSString *)getLimitDate {
    //NSDateFormatterクラスを出力する。
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    //出力形式を文字列で指定する。
    [format setDateFormat:DateFormat];
    // 日付のオフセットを生成
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    // 〜日後を指定
    [dateComp setDay:TodoLimitAfterDays];
    // 〜日後のNSDateインスタンスを取得する
    NSDate *futureDate = [NSCalendar.currentCalendar dateByAddingComponents:dateComp toDate:[NSDate date] options:0];
    // 〜日後のインスタンスをフォーマットにはめて返す
    NSString *limitLineDate = [format stringFromDate:futureDate];
    
    return limitLineDate;
}

// タイトル空欄時に表示するアラートを作成
- (void)createAleart {
    
    NSString *registerAlertControllerTitle = [NSBundle.mainBundle localizedStringForKey:@"registerAlertControllerTitle" value:nil table:@"Localizable"];
    NSString *registerAlertControllerMessage = [NSBundle.mainBundle localizedStringForKey:@"registerAlertControllerMessage" value:nil table:@"Localizable"];
    NSString *doneAlertControllerTitle = [NSBundle.mainBundle localizedStringForKey:@"doneAlertControllerTitle" value:nil table:@"Localizable"];
    NSString *okButtonAleartActionTitle = [NSBundle.mainBundle localizedStringForKey:@"okButtonAleartActionTitle" value:nil table:@"Localizable"];
    NSString *backTopButtonAleartActionTitle = [NSBundle.mainBundle localizedStringForKey:@"backTopButtonAleartActionTitle" value:nil table:@"Localizable"];
    NSString *continueRegistButtonAleartActionTitle = [NSBundle.mainBundle localizedStringForKey:@"continueRegistButtonAleartActionTitle" value:nil table:@"Localizable"];

    //アラートコントローラーの生成
    self.registerAlertController = [UIAlertController
                                    alertControllerWithTitle:registerAlertControllerTitle
                                    message:registerAlertControllerMessage
                                    preferredStyle:UIAlertControllerStyleAlert];
    
    self.doneAlertController = [UIAlertController alertControllerWithTitle:doneAlertControllerTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // OKボタンと処理内容を用意
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:okButtonAleartActionTitle
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    
    // 閉じるボタン（処理：一覧画面に戻る）を用意
    UIAlertAction *backTopButton = [UIAlertAction
                                    actionWithTitle:backTopButtonAleartActionTitle
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                    }];
    
    // 連続登録ボタン（処理：その画面のまま、テキストをリセット）を用意
    UIAlertAction *continueRegistButton = [UIAlertAction
                                           actionWithTitle:continueRegistButtonAleartActionTitle
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
    FMDatabase *db = [viewController connectDataBase:AccessDatabaseName];
    
    // todoIdをセット（0をセットまたは+1で返す）
    self.todoId = [self addTodoId];
    // createdを取得
    self.created = [self getCreated];
    // modifiedを取得
    self.modified = [self getCreated];
    // limitDateを取得
    self.limitDate = [self getLimitDate];
    // deleteFlagを設定
    self.deleteFlag = @"OFF";
    // テキストフィールドからタイトルを取得
    self.todoTitle = self.registerTextField.text;
    // テキストビューから内容を取得
    self.todoContents = self.registerTextView.text;
    
    // 取得した情報をデータベースに登録
    NSString *insert = [[NSString alloc] initWithFormat:@"INSERT INTO tr_todo(todo_id, todo_title, todo_contents, created, modified, limit_date, delete_flg) VALUES('%d', '%@', '%@', '%@', '%@', '%@', '%@')", self.todoId, self.todoTitle, self.todoContents, self.created, self.modified, self.limitDate, self. deleteFlag];
    
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
