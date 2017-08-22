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

    if ([self.delegate respondsToSelector:@selector(canDoObjc:)]) {
        [self.delegate canDoObjc];
    }
}

@end

