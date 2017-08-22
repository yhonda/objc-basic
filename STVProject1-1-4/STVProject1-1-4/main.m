//
//  main.m
//  STVProject1-1-4
//
//  Created by kawaharadai on 2017/08/14.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

// 実行関数
int main(int argc, const char * argv[])
{
    @autoreleasepool {
        // Accountクラス型の変数を用意、同時にメモリを割り振り、初期化
        Account *classObject = [[Account alloc] init];
        //各社員分インスタンスを用意
        
        // AccountクラスのoutputEmployeelistメソッドを呼び出す
        [classObject outputEmployeeList];
    }
    return 0;
}
