//
//  Account.h
//  STVProject1-1-4
//
//  Created by kawaharadai on 2017/08/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject
// プロパティを定義
@property NSString *employeeName;
@property NSNumber *employeeAge;
@property NSString *employeeSex;
@property NSString *employeeGoodLanguage;
// メソッドを定義
- (void) outputEmployeeList:(Account*)account;
- (id)initName:(NSString*)name initAge:(NSNumber*)age initSex:(NSString*)sex initGoodLanguage:(NSString*)goodlanguage;
@end
