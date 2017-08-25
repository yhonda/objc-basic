//
//  Account.m
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "FavoriteProgrammingLanguage.h"

@interface Account ()

@end

@implementation Account : NSObject

// FavoriteProgrammingLanguageクラスのjoinInternshipを呼ぶ
-(void)callJoinInternship {
    // デリゲート接続して通知を送る
    FavoriteProgrammingLanguage *favoriteProgrammingLanguage = [[FavoriteProgrammingLanguage alloc]init];
    favoriteProgrammingLanguage.delegate = self;
    [favoriteProgrammingLanguage joinInternship];
}
// デリゲートメソッド（オプショナルメソッド）
- (void)canDoObjc{
    //canDoObjc通知を受信する
    NSLog(@"canDoObjc通知を受信しました。");
}

@end

