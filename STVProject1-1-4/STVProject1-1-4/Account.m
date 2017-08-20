//
//  Account.m
//  STVProject1-1-4
//
//  Created by kawaharadai on 2017/08/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@implementation Account

-(void)outputEmployeelist{
    _employeeName = @[@"鈴木あやか", @"佐藤春彦", @"渡辺直美", @"木村拓哉", @"加藤浩次", @"若林里美"];
    _employeeAge = @[@21,@33,@45,@28,@33,@25];
    _employeeSex = @[@"女性", @"男性", @"女性", @"男性", @"男性", @"女性"];
    _employeeGoodLanguage = @[@"Java", @"Swift", @"Objective-C", @"Swift", @"Objective-C", @"Java"];
    
    // 処理内容
    for(int i=0; i<_employeeName.count; i++){
        // 条件分岐
        if ([_employeeSex[i]  isEqual : @"男性"]){
            NSLog(@"社員リスト：%@君は、%@が得意な%@歳です。",
                  _employeeName[i],
                  _employeeGoodLanguage[i],
                  _employeeAge[i]);
        } else if ([_employeeSex[i] isEqual : @"女性"]){
            NSLog(@"社員リスト：%@さんは、%@が得意な%@歳です。",
                  _employeeName[i],
                  _employeeGoodLanguage[i],
                  _employeeAge[i]);
        } else {
            NSLog(@"社員リスト：該当者なし");
        }
    }

}

@end
