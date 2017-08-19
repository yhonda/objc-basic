//
//  main.m
//  STVProject1-1-4
//
//  Created by kawaharadai on 2017/08/14.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "main.h"

// ヘッダファイルと接続
@interface Account ()

@end

// クラスファイル部分
@implementation Account

// メソッド内容記載
- (void) outputEmployeelist{
    
    // 変数を定義
    NSArray *employeeName = @[@"鈴木あやか", @"佐藤春彦", @"渡辺直美", @"木村拓哉", @"加藤浩次", @"若林里美"];
    NSArray *employeeAge = @[@21,@33,@45,@28,@33,@25];
    NSArray *employeeSex = @[@"女性", @"男性", @"女性", @"男性", @"男性", @"女性"];
    NSArray *employeeGoodLanguage = @[@"Java", @"Swift", @"Objective-C", @"Swift", @"Objective-C", @"Java"];
    
    // 処理内容
    for(int i=0; i<employeeName.count; i++){
        // 条件分岐
        if ([employeeSex[i]  isEqual : @"男性"]){
            NSLog(@"社員リスト：%@君は、%@が得意な%@歳です。",
                  employeeName[i],
                  employeeGoodLanguage[i],
                  employeeAge[i]);
        } else if ([employeeSex[i] isEqual : @"女性"]){
            NSLog(@"社員リスト：%@さんは、%@が得意な%@歳です。",
                  employeeName[i],
                  employeeGoodLanguage[i],
                  employeeAge[i]);
        } else {
            NSLog(@"社員リスト：該当者なし");
        }
    }
}
@end

// 実行関数
int main(int argc, const char * argv[])
{
    @autoreleasepool {
        // クラス用の変数を用意
        id classObject;
        // Accountクラスにメモリを割り振り、初期化して格納
        classObject = [[Account alloc] init];
        // AccountクラスのoutputEmployeelistメソッドを呼び出す
        [classObject outputEmployeelist];
    }
    return 0;
}
