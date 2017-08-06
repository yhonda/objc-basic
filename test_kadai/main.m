

#import <Foundation/Foundation.h>

//BOOL型、NSString型、NSInteger型、NSNumber型(初期値設定はできない)
BOOL test1 = YES;
NSString *test2 = @"mojiretsu";
NSInteger test3 = 10;
NSNumber *test4;


//出力メソッド
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //値を設定
        test4 = [NSNumber numberWithInt:10];
        
        //出力
        NSLog(@"%hhd", test1);
        NSLog(@"%@", test2);
        NSLog(@"%ld", (long)test3);
        NSLog(@"%@", test4);
    }
   
}
