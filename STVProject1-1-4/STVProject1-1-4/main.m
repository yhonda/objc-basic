//
//  main.m
//  STVProject1-1-4
//
//  Created by kawaharadai on 2017/08/14.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

// 実行関数
int main(int argc, const char * argv[])
{
    @autoreleasepool {
        // Accountクラス型の変数を用意、同時にメモリを割り振り、初期化
        Account *classObject = [[Account alloc] init];
        //各社員分インスタンスを用意
        Account *employee1 = [[Account alloc]initName:@"鈴木あやか" initAge:@21 initSex:@"女性" initGoodLanguage:@"Java"];
        Account *employee2 = [[Account alloc]initName:@"佐藤春彦" initAge:@33 initSex:@"男性" initGoodLanguage:@"Swift"];
        Account *employee3 = [[Account alloc]initName:@"渡辺直美" initAge:@45 initSex:@"女性" initGoodLanguage:@"Objective-C"];
        Account *employee4 = [[Account alloc]initName:@"木村拓哉" initAge:@28 initSex:@"男性" initGoodLanguage:@"Swift"];
        Account *employee5 = [[Account alloc]initName:@"加藤浩次" initAge:@36 initSex:@"男性" initGoodLanguage:@"Objective-C"];
        Account *employee6 = [[Account alloc]initName:@"若林里美" initAge:@24 initSex:@"女性" initGoodLanguage:@"Java"];
        
        // インスタンスを配列に格納
        NSArray *employeeList = @[employee1,employee2,employee3,employee4,employee5,employee6];
        
        // for文で一つずつ取り出して、outputEmployeeListを通す
        for(int i=0; i<employeeList.count; i++){
            [classObject outputEmployeeList:employeeList[i]];
        }
    }
    return 0;
}
