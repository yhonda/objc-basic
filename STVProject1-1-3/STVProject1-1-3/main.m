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
        NSInteger testPoint1 = 80;
        NSInteger testPoint2 = 65;
        NSInteger testPoint3 = 40;
        NSInteger plusCount = 0;
        NSArray *numberArray = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@6,@7,@8,@9, nil];
        NSInteger numberCheck = 2;
        
        // if文
        // テストの点数(testPoint1)、60点以上なら「合格」、59点以下なら「不合格」と出力。
        if(testPoint1 >= 60){
            NSLog(@"合格");
        }else{
            NSLog(@"不合格");
        }
        
        // if〜else文
        // テストの点数(testPoint2)、80点以上なら「合格」、79点〜60点なら「再テスト」、59点以下なら「不合格」と出力。
        if(testPoint2 >= 80){
            NSLog(@"合格");
        }else if(testPoint2 >= 60){
            NSLog(@"再テスト");
        }else{
            NSLog(@"不合格");
        }
        
        // if文、三項演算子
        // テストの点数(testPoint3)、60点以上なら「合格」、59点以下なら「不合格」と出力。
        NSString *result = (testPoint3 >= 60)?@"合格":@"不合格";
        NSLog(@"%@",result);
        
        // for文
        // 10回連続して「変数plusCountを2ずつ増やす」処理を行い、最後に処理結果を出力する。
        for(NSInteger i=0; i<=10; i++){
            plusCount = i*2;
        }
        NSLog(@"%ld", plusCount);
        
        // 高速列挙構文
        // 配列型の変数numberArray先頭から順に取り出す。
        for(NSNumber *i in numberArray){
            NSLog(@"%@", i);
        }
        
        // switch文
        // 変数numberCheckの中の値ごとにメッセージを表示。
        switch (numberCheck) {
            case 0:
                NSLog(@"進め");
                break;
            case 1:
                NSLog(@"注意して進め");
                break;
            case 2:
                NSLog(@"止まれ");
                break;
            default:
                NSLog(@"行き止まり");
                break;
        }
    }
    return 0;
}
