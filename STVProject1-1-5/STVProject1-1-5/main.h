//
//  main.h
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/15.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#ifndef main_h
#define main_h
#endif /* main_h */

// デリゲートをする側

#import <Foundation/Foundation.h>

// プロトコルを定義
@protocol FavoriteProgrammingLanguageDelegate <NSObject>
// @optional以下のメソッドはデリゲートの実装は必須ではない。
@optional
- (void)ObjCができる;
@end

// 通知元のクラス
@interface Account : NSObject
// 通知先のデリゲートインスタンス
@property (weak, nonatomic) id <FavoriteProgrammingLanguageDelegate> delegate;
// インターンに参加するメソッドを定義
- (void)インターンに参加する;

@end

