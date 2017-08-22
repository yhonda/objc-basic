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
- (id)initName:(NSString*)name initAge:(NSNumber*)age initSex:(NSString*)sex initGoodLanguage:(NSString*)goodlanguage {
    self = [super init];
    if (self != nil) {
        self.employeeName = name;
        self.employeeAge = age;
        self.employeeSex = sex;
        self.employeeGoodLanguage = goodlanguage;
    }
    return self;
}

// イニシャライザの定義し、指定イニシャライザを通して値をセット
- (id)init
{
    self = [super init];
    // 指定イニシャライザを経由して初期化
    return [self initName:@"鈴木あやか" initAge:@21 initSex:@"女性" initGoodLanguage:@"Java"];
}

-(void)outputEmployeeList{
    
    // 処理内容
    // 条件分岐
    if ([self.employeeSex  isEqual : @"男性"]){
        NSLog(@"社員リスト：%@君は、%@が得意な%@歳です。",
              self.employeeName,
              self.employeeGoodLanguage,
              self.employeeAge);
    } else if ([self.employeeSex isEqual : @"女性"]){
        NSLog(@"社員リスト：%@さんは、%@が得意な%@歳です。",
              self.employeeName,
              self.employeeGoodLanguage,
              self.employeeAge);
    } else {
        NSLog(@"社員リスト：該当者なし");
    }
   }

@end
