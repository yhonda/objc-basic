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
@end

// 必要なKeyを定数で定義
static NSString *const StringFileName = @"Localizable";
static NSString *const RunFirstTimeKey = @"runFirstTime";
static NSString *const NotRunFirstTimeKey = @"notRunFirstTime";
static NSString *const CheckFirstRunTimeKey = @"firstRun";
static NSString *const IntTypeValueKey = @"ValueTypeInt";
static NSString *const DoubleTypeValueKey = @"ValueTypeDouble";
static NSString *const StringTypeValueKey = @"ValueTypeString";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初回起動を確認し、初回起動でなければ、それぞれの型で値を設定
    if ([self CheckRunfirstTime]) {
        NSLog(@"初回起動です。");
        self.resultLabel.text = [NSBundle.mainBundle localizedStringForKey:RunFirstTimeKey value:nil table:StringFileName];
    } else {
        NSLog(@"初回起動ではありません。");
        self.resultLabel.text = [NSBundle.mainBundle localizedStringForKey:NotRunFirstTimeKey value:nil table:StringFileName];
        [self createNewData];
    }
}

// 初回起動を確認するメソッド
- (BOOL)CheckRunfirstTime {
    //UserDefaultsに接続
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    // 起動確認用の値が設定されていれば、NOを返し、されていなければ、起動証明として値を設定
    if ([userDefaults objectForKey:CheckFirstRunTimeKey]) {
        return NO;
    }
    // BoolをYESで保存
    [userDefaults setBool:YES forKey:CheckFirstRunTimeKey];
    // 更新をかける
    [userDefaults synchronize];
    // 初回起動
    return YES;
}

// UserDefaultsに新たなデータを作成、保存する
- (void)createNewData {
    //UserDefaultsに接続
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    // Int型の値を保存
    [userDefaults setInteger:1000 forKey:IntTypeValueKey];
    // Double型の値を保存
    [userDefaults setDouble:0.005 forKey:DoubleTypeValueKey];
    // String型の値を保存
    [userDefaults setObject:@"アイウエオ" forKey:StringTypeValueKey];
    // 更新をかける
    [userDefaults synchronize];
}

// UserDefaultsに保存している値を出力する
- (IBAction)outputSaveDataButton:(id)sender {
    
    //UserDefaultsに接続
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    
    // 取り出した値をインスタンス化
    int saveIntValue = (int)[userDefaults integerForKey:IntTypeValueKey];
    double saveDoubleValue = [userDefaults doubleForKey:DoubleTypeValueKey];
    NSString *saveStringValue = [userDefaults stringForKey:StringTypeValueKey];
    
    // 初回起動時の場合は、保存データがないことを通知して処理を終了させる
    if (!saveIntValue && !saveDoubleValue && !saveStringValue) {
        return NSLog(@"保存されているデータはありません。");
    }
    
    // 保存されている値がある場合は出力する
    NSLog(@"%d", saveIntValue);
    NSLog(@"%f", saveDoubleValue);
    NSLog(@"%@", saveStringValue);
}

@end
