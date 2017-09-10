//
//  ViewController.m
//  STVProject2-3-1
//
//  Created by kawaharadai on 2017/08/29.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// プロパティをを定義
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
// メソッドを定義
- (void)createNewData;
- (BOOL)CheckRunfirstTime;
- (IBAction)outputSaveDataButton:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初回起動を確認し、初回起動でなければ、それぞれの型で値を設定
    if ([self CheckRunfirstTime]) {
        NSLog(@"初回起動です。");
        self.resultLabel.text = @"初回起動です。";
    } else {
        NSLog(@"初回起動ではありません。");
        self.resultLabel.text = @"初回起動ではありません。";
        [self createNewData];
    }
}

// 初回起動を確認するメソッド
- (BOOL)CheckRunfirstTime {
    //UserDefaultsに接続
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 起動確認用の値が設定されていれば、NOを返し、されていなければ、起動証明として値を設定
    if ([userDefaults objectForKey:@"firstRun"]) {
        return NO;
    }
    // BoolをYESで保存
    [userDefaults setBool:YES forKey:@"firstRun"];
    // 即時反映
    [userDefaults synchronize];
    // 初回起動
    return YES;
}

// UserDefaultsに新たなデータを作成、保存する
- (void)createNewData {
    //UserDefaultsに接続
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // Int型の値を保存
    [userDefaults setInteger:1000 forKey:@"ValueTypeInt"];
    // Double型の値を保存
    [userDefaults setDouble:0.005 forKey:@"ValueTypeDouble"];
    // String型の値を保存
    [userDefaults setObject:@"アイウエオ" forKey:@"ValueTypeString"];
}

// UserDefaultsに保存している値を出力する
- (IBAction)outputSaveDataButton:(id)sender {
    
    //UserDefaultsに接続
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // 取り出した値をインスタンス化
    int saveIntValue = (int)[userDefaults integerForKey:@"ValueTypeInt"];
    double saveDoubleValue = [userDefaults doubleForKey:@"ValueTypeDouble"];
    NSString *saveStringValue = [userDefaults stringForKey:@"ValueTypeString"];
    
    // 初回起動時の場合は、保存データがないことを通知して処理を終了させる
    if (saveStringValue == nil) {
        return NSLog(@"保存されているデータはありません。");
    }
    
    // 保存されている値がある場合は出力する
    NSLog(@"%d", saveIntValue);
    NSLog(@"%f", saveDoubleValue);
    NSLog(@"%@", saveStringValue);
}

@end
