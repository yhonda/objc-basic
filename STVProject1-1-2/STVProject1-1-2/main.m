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
        NSArray *fruitsArray;
        NSDictionary *fruitsColorArray;
        // 値を設定
        fruitsArray = [NSArray arrayWithObjects:@"りんご",@"バナナ",@"ぶどう",nil];
        fruitsColorArray = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"赤色", @"りんご",
                            @"黄色", @"バナナ",
                            @"紫色", @"ぶどう",nil];
        // NSArray型変数の出力
        for(int i=0; i<fruitsArray.count; i++){
            NSLog(@"%@", fruitsArray[i]);
        }
        // NSDictonary型変数の出力
        NSLog(@"%@", [fruitsColorArray objectForKey:@"りんご"]);
        NSLog(@"%@", [fruitsColorArray objectForKey:@"バナナ"]);
        NSLog(@"%@", [fruitsColorArray objectForKey:@"ぶどう"]);
    }
    return 0;
}

