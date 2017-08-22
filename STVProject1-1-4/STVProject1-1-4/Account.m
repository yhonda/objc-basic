//
//  Account.m
//  STVProject1-1-4
//
//  Created by kawaharadai on 2017/08/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface Account ()

@end

@implementation Account

// 指定イニシャライザを定義し、社員情報の引数を指定
- (instancetype)initName:(NSString*)name initAge:(NSNumber*)age initSex:(NSString*)sex initGoodLanguage:(NSString*)goodlanguage {
    self = [super init];
    if (self != nil) {
        self.employeeName = name;
        self.employeeAge = age;
        self.employeeSex = sex;
        self.employeeGoodLanguage = goodlanguage;
    }
    return self;
}

// 指定イニシャライザを経由して初期化
- (instancetype)init
{
    self = [super init];
    return [self initName:self.employeeName initAge:self.employeeAge initSex:self.employeeSex initGoodLanguage:self.employeeGoodLanguage];
}
// 出力メソッド
-(void)outputEmployeeList:(Account*)account{
    
    // 条件分岐でログを出力
    if ([account.employeeSex  isEqual : @"男性"]){
        NSLog(@"社員リスト：%@君は、%@が得意な%@歳です。",
              account.employeeName,
              account.employeeGoodLanguage,
              account.employeeAge);
    } else if ([account.employeeSex isEqual : @"女性"]){
        NSLog(@"社員リスト：%@さんは、%@が得意な%@歳です。",
              account.employeeName,
              account.employeeGoodLanguage,
              account.employeeAge);
    } else {
        NSLog(@"社員リスト：該当者なし");
    }
   }

@end
