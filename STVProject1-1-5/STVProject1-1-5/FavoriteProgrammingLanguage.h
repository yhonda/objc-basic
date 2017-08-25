//
//  FavoriteProgrammingLanguage.h
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>

// プロトコルを定義
@protocol FavoriteProgrammingLanguageDelegate <NSObject>
// @optional以下のメソッドはデリゲートの実装は必須ではない。
@optional
- (void)canDoObjc;

@end

@interface FavoriteProgrammingLanguage : NSObject
// デリゲートインスタンスを作成
@property (weak, nonatomic) id <FavoriteProgrammingLanguageDelegate> delegate;
// initializer
-(void)joinInternship;

@end
