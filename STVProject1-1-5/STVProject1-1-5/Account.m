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

@interface Account () <FavoriteProgrammingLanguageDelegate>

//プロパティを定義
@property (strong, nonatomic) Account *account;
@end

@implementation Account : NSObject 

- (id)init{
    if (self = [super init]) {
        self.account = [Account new];
        // delegateに自身を指定します。
        self.account.delegate = self;
        [self.account canDoObjc];
    }
    return self;
}

- (void)canDoObjc{
    //canDoObjc通知を受信する
    NSLog(@"canDoObjc通知を受信しました。");
}
@end

