//
//  Account.m
//  STVProject1-1-5
//
//  Created by kawaharadai on 2017/08/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "FavoriteProgrammingLanguage.h"

@interface Account ()

@end

@implementation Account : NSObject

-(void)callJoinInternship {
    // FavoriteProgrammingLanguageクラスのjoinInternshipを呼ぶ
    FavoriteProgrammingLanguage *favoriteProgrammingLanguage = [[FavoriteProgrammingLanguage alloc]init];
    favoriteProgrammingLanguage.delegate = self;
    [favoriteProgrammingLanguage joinInternship];
}
@end

