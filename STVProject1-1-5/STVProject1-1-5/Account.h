//
//  Account.h
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#ifndef Account_h
#define Account_h

#endif /* Account_h */

// プロトコルを定義
@protocol FavoriteProgrammingLanguageDelegate <NSObject>

// @optional以下のメソッドはデリゲートの実装は必須ではない。
@optional
- (void)canDoObjc;

@end

@interface Account : NSObject
// デリゲートオブジェクトを定義
@property (weak, nonatomic) id <FavoriteProgrammingLanguageDelegate> delegate;

@end
