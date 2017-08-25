//
//  FavoriteProgrammingLanguage.m
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteProgrammingLanguage.h"

@interface FavoriteProgrammingLanguage ()

@end

@implementation FavoriteProgrammingLanguage

-(void)joinInternship{
    // オプショナルメソッドを呼び出す
    if ([self.delegate respondsToSelector:@selector(canDoObjc:)]) {
        [self.delegate canDoObjc];
    }
}

- (void)canDoObjc{
    //canDoObjc通知を受信する
    NSLog(@"canDoObjc通知を受信しました。");
}

@end

