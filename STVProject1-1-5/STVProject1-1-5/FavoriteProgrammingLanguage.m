//
//  FavoriteProgrammingLanguage.m
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteProgrammingLanguage.h"
#import "Account.h"

@interface FavoriteProgrammingLanguage () <FavoriteProgrammingLanguageDelegate>
// プロパティを定義
@property (strong, nonatomic) Account *account;

@end

@implementation FavoriteProgrammingLanguage : NSObject 

-(void)joinInternship{
    // クラスの宣言と初期化
    self.account = [Account new];
    // delegateに自身を指定します。
    self.account.delegate = self;
    // canDoObjcメソッドを呼ぶ
    [self canDoObjc];
}

-(void)canDoObjc{
    //canDoObjc通知を受信する
    NSLog(@"canDoObjc通知を受信しました。");
}

@end

