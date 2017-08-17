//
//  main.m
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/15.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "main.h"

// クラスを定義
@interface Account()

@end

// デリゲートをする側
@implementation Account

- (void)インターンに参加する
{
    // デリゲートメソッドの実装を判定
    if ([self.delegate respondsToSelector:@selector(ObjCができる:)]) {
        //Obj-Cができるに通知を送る
        [self.delegate ObjCができる];
    }
}
@end

//実行メソッド
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // インターンに参加メソッドを呼び出す
        id ClassObject;
        // Accountクラスにメモリを割り振り、初期化して格納
        ClassObject = [[Account alloc] init];
        // Accountクラスのインターンに参加メソッドを呼び出す
        [ClassObject インターンに参加する];
    
    }
    return 0;
}
