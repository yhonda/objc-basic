//
//  main.m
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/15.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteProgrammingLanguage.h"
#import "Account.h"
#import "main.h"

//実行メソッド
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Account *account = [[Account alloc]init];
        [account callJoinInternship];
        // デリゲート先クラスのjoinInternshipメソッドを呼び出す
    }
    return 0;
}
