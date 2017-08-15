//
//  main.m
//  STVProject1-1-3
//
//  Created by kawaharadai on 2017/08/14.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 使用する変数の用意
        NSInteger englishTestScore = 80;
        NSInteger mathTestScore = 65;
        NSInteger chemicalTestScore = 40;
        NSInteger plusCount = 0;
        NSArray *numberArray = @[@1,@2,@3,@4,@5,@6,@7,@8,@9];
        NSInteger MethodNumber = 2;
        
        // 使用する定数の用意
        static NSInteger *const PassTestScore = 60;
        static NSInteger *const RepeatTestScore = 30;
        typedef NS_ENUM(NSInteger, MethodNumberEnum) {
            MethodNumber0 = 0,
            MethodNumber1 = 1,
            MethodNumber2 = 2,
        };

        // if文
        // 英語の試験結果(englishTestScore)、60点以上なら合格、59点以下なら不合格
        if (englishTestScore >= (long)PassTestScore) {
            NSLog(@"if文処理結果：英語の試験に”合格”しました。");
        } else {
            NSLog(@"if文処理結果：英語の試験は”不合格”でした。");
        }
        
        // if〜else文
        // 数学の試験結果(mathTestScore)、60点以上なら合格、59点〜30点なら再試験、29点以下なら不合格
        if (mathTestScore >= (long) PassTestScore) {
            NSLog(@"if〜else文処理結果：数学の試験に”合格”しました。");
        } else if (mathTestScore >= (long) RepeatTestScore) {
            NSLog(@"if〜else文処理結果：数学の試験は”再試験”です。");
        } else {
            NSLog(@"if〜else文処理結果：数学の試験は”不合格”です。");
        }
        
        // if文、三項演算子
        // 化学の試験結果(chemicalTestScore)、60点以上なら合格、59点以下なら不合格
        NSString *result = (chemicalTestScore >= (long) PassTestScore) ? @"化学の試験に”合格”しました。" : @"化学の試験は”不合格”です。";
        NSLog(@"if文、三項演算子文処理結果：%@",result);
        
        // for文
        // 10回連続して「変数plusCountを2ずつ増やす」処理を行い、最後に処理結果を出力する。
        for (NSInteger i = 0; i <= 10; i++) {
            plusCount = i * 2;
        }
        NSLog(@"for文処理結果：%ld", plusCount);
        
        // 高速列挙構文
        // 配列型の変数numberArray先頭から順に取り出す。
        for (NSNumber * i in numberArray) {
            NSLog(@"高速列挙構文処理結果：%@", i);
        }
        
        // switch文
        // MethodNumberの値によって、メソッドを実行。
        switch (MethodNumber) {
            case MethodNumber0:
                NSLog(@"switch文処理結果：0番のメソッドを実行します。");
                break;
            case MethodNumber1:
                NSLog(@"switch文処理結果：1番のメソッドを実行します。");
                break;
            case MethodNumber2:
                NSLog(@"switch文処理結果：2番のメソッドを実行します。");
                break;
            default:
                NSLog(@"switch文処理結果：実行するメソッドがありません。");
                break;
        }
    }
    return 0;
}
