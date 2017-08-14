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
- (void) Output_Employee_list{
    
    // プロパティを定義
    NSArray<NSString*> *name = [NSArray<NSString*> arrayWithObjects:@"鈴木あやか",@"佐藤春彦",@"渡辺直美",@"木村拓哉",@"加藤浩次",@"若林里美", nil];
    NSArray<NSNumber*> *age = [NSArray <NSNumber*> arrayWithObjects:@21,@33,@45,@28,@33,@25, nil];
    NSArray<NSString*> *sex = [NSArray<NSString*> arrayWithObjects:@"女性",@"男性",@"女性",@"男性",@"男性",@"女性", nil];
    NSArray<NSString*> *good_language = [NSArray<NSString*> arrayWithObjects:@"Java",@"Swift",@"Objective-C",@"Swift",@"Objective-C",@"Java", nil];
    
    // 処理内容
    for(int i=0; i<name.count; i++){
        // 条件分岐
        if([sex[i]  isEqual: @"男性"]){
            NSLog(@"%@君は、%@が得意な%@歳です。",name[i],good_language[i],age[i]);
        }else if([sex[i] isEqual:@"女性"]){
            NSLog(@"%@さんは、%@が得意な%@歳です。",name[i],good_language[i],age[i]);
        }else{
            NSLog(@"該当者なし");
        }
    }
}
@end

// 実行関数
int main(int argc, const char * argv[])
{
    @autoreleasepool {
        // クラス用の変数を用意
        id ClassObject;
        // Accountクラスにメモリを割り振り、初期化して格納
        ClassObject = [[Account alloc] init];
        // AccountクラスのOutput_Employee_listメソッドを呼び出す
        [ClassObject Output_Employee_list];
    }
    return 0;
}
