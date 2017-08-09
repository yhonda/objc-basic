//
//  main.m
//  test_kadai
//
//  Created by kawaharadai on 2017/08/05.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//


#import <Foundation/Foundation.h>

//出力メソッド
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //BOOL型、NSString型、NSInteger型、NSNumber型(Int)の変数をそれぞれ定義
        BOOL Bool_value = YES;
        NSString *NSstring_value = @"mojiretsu";
        NSInteger NSInteger_value = 10;
        NSNumber *NSNumber_value = @10;

        //出力
        NSLog(@"%hhd", Bool_value);
        NSLog(@"%@", NSstring_value);
        NSLog(@"%zd", NSInteger_value);
        NSLog(@"%@", NSNumber_value);
    }
   return 0;
}
