//
//  Account.h
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteProgrammingLanguage.h"

// デリゲート接続
@interface Account : NSObject <FavoriteProgrammingLanguageDelegate>
//メソッドを定義
- (void)callJoinInternship;
@end
