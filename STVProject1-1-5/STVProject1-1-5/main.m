//
//  main.m
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/15.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "main.h"
#import "FavoriteProgrammingLanguage.h"

//実行メソッド
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // デリゲート先クラスのjoinInternshipメソッドを呼び出す
        FavoriteProgrammingLanguage *favoriteProgrammingLanguage = [[FavoriteProgrammingLanguage alloc]init];
        [favoriteProgrammingLanguage joinInternship];
        
    }
    return 0;
}
