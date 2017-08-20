//
//  main.m
//  STVProject1-1-2
//
//  Created by kawaharadai on 2017/08/14.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>

// 出力メソッド
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // NSArray型、NSDictonary型の変数を定義
        NSArray *fruitsArray = @[@"りんご", @"バナナ", @"ぶどう"];
        NSDictionary *fruitsColorDictionary = @{@"りんご":@"赤色",
                                                @"バナナ":@"黄色",
                                                @"ぶどう":@"紫色"};

        // NSArray型変数の出力
        for(int i=0; i<fruitsArray.count; i++){
            NSLog(@"%d番目の要素は「%@」です。",i,fruitsArray[i]);
        }
        // NSDictonary型変数の出力
        NSLog(@"キー値「りんご」のとき、値「%@」",fruitsColorDictionary[@"りんご"]);
        NSLog(@"キー値「バナナ」のとき、値「%@」",fruitsColorDictionary[@"バナナ"]);
        NSLog(@"キー値「ぶどう」のとき、値「%@」",fruitsColorDictionary[@"ぶどう"]);
    }
    return 0;
}

