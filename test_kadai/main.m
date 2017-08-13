//
//  main.m
//  test_kadai
//
//  Created by kawaharadai on 2017/08/05.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>

// 出力メソッド
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // BOOL型、NSString型、NSInteger型、NSNumber型(Int)の変数をそれぞれ定義
        BOOL boolStatus = YES;
        NSString *string = @"mojiretsu";
        NSInteger integer = 10;
        NSNumber *number = @10;
        // 出力
        NSLog(@"%hhd", boolStatus);
        NSLog(@"%@", string);
        NSLog(@"%zd", integer);
        NSLog(@"%@", number);
    }
   return 0;
}
