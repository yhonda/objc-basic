//
//  delegateFile.m
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/15.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

//デリゲート側のファイル（機能実装を委託される）
#import <Foundation/Foundation.h>
#import "main.h"
#import "delegateFile.h"

// 設定したプロトコルに準拠する
@interface FavoriteProgrammingLanguage () <FavoriteProgrammingLanguageDelegate>

@property (strong, nonatomic) Account *account;

@end

@implementation FavoriteProgrammingLanguage

- (void)ObjCができる
{
    // 処理内容
    NSLog(@"ObjCができる通知を受信しました。");
}

@end
