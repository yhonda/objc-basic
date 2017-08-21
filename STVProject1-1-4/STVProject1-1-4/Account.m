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
// プロパティを定義
@property NSString *employeeName;
@property NSNumber *employeeAge;
@property NSString *employeeSex;
@property NSString *employeeGoodLanguage;
@property NSArray *employeeNameList;
@property NSArray *employeeAgeList;
@property NSArray *employeeSexList;
@property NSArray *employeeGoodLanguageList;

@end

@implementation Account

// イニシャライザを定義し、配列に初期値をセット
- (id)init {
    if((self = [super init]))
    {
        self.employeeNameList = @[@"鈴木あやか", @"佐藤春彦", @"渡辺直美", @"木村拓哉", @"加藤浩次", @"若林里美"];
        self.employeeAgeList = @[@21,@33,@45,@28,@33,@25];
        self.employeeSexList = @[@"女性", @"男性", @"女性", @"男性", @"男性", @"女性"];
        self.employeeGoodLanguageList = @[@"Java", @"Swift", @"Objective-C", @"Swift", @"Objective-C", @"Java"];
    }
    return self;
}

-(void)outputEmployeeList{
    
    //クラス型変数を定義
    Account *accountInfomation = [[Account alloc]init];
    
    // 処理内容
    for(int i=0; i<self.employeeNameList.count; i++){
        accountInfomation.employeeName = self.employeeNameList[i];
        accountInfomation.employeeAge = self.employeeAgeList[i];
        accountInfomation.employeeSex = self.employeeSexList[i];
        accountInfomation.employeeGoodLanguage = self.employeeGoodLanguageList[i];
        // 条件分岐
        if ([accountInfomation.employeeSex  isEqual : @"男性"]){
            NSLog(@"社員リスト：%@君は、%@が得意な%@歳です。",
                  accountInfomation.employeeName,
                  accountInfomation.employeeGoodLanguage,
                  accountInfomation.employeeAge);
        } else if ([accountInfomation.employeeSex isEqual : @"女性"]){
            NSLog(@"社員リスト：%@さんは、%@が得意な%@歳です。",
                  accountInfomation.employeeName,
                  accountInfomation.employeeGoodLanguage,
                  accountInfomation.employeeAge);
        } else {
            NSLog(@"社員リスト：該当者なし");
        }
    }
}

@end
