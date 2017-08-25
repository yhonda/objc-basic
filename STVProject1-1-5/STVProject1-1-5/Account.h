//
//  Account.h
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteProgrammingLanguage.h"

@interface Account : NSObject <FavoriteProgrammingLanguageDelegate>
//プロパティを定義
@property (strong, nonatomic) Account *account;

- (void)callJoinInternship;
@end
