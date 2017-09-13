//
//  instagramController.m
//  STVProject2-4-8
//
//  Created by kawaharadai on 2017/09/07.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstagramController.h"

@interface InstagramController ()

@end

@implementation InstagramController

// インスタのスキーマーを使えるかどうかを実際にリクエストしてチェック
+ (BOOL)canInstagramOpen {
    NSLog(@"canInstagramOpen");
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        return YES;
    }
    return NO;
}

// instaramに投稿できる型に画像を変換（圧縮は0.8）
- (void)setImage:(UIImage *)image {
    NSLog(@"setImage");
    // 送られてきた画像データをjpeg形式に変換
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8f);
    // ファイルパスを付与
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.igo"];
    // 容量などの設定を付与？
    [imageData writeToFile:filePath atomically:YES];
    
}

// instagramに画像を送るメソッド
- (void)openInstagram {
    NSLog(@"openInstagram");
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.igo"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.documentInteractionController.UTI = @"com.instagram.exclusivegram";
    self.documentInteractionController.delegate = self;
    
    BOOL present = [self.documentInteractionController presentOpenInMenuFromRect:self.view.frame
                                                                          inView:self.view
                                                                        animated:YES];
    // instagramに画像送信が失敗した時
    if (!present) {
        NSLog(@"instagramへの画像送信が失敗しました。");
        [self deleteView];
    }
}

// instaramに画像を送信後、コントローラーごと削除する（都度作る必要がある）
- (void)deleteView {
    NSLog(@"closeView");
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    self.documentInteractionController.delegate = nil;
}

// UIDocumentInteractionControllerのデリゲートメソッド
// コントローラーをinstaram側に渡した後に呼ばれる
- (void)documentInteractionController:(UIDocumentInteractionController *)controller
           didEndSendingToApplication:(NSString *)application {
    [self deleteView];
}

// instagramの投稿画面をキャンセルで閉じたときに呼ばれる
- (void) documentInteractionControllerDidDismissOpenInMenu: (UIDocumentInteractionController *) controller {
    // これはいらないかもしれない
    [self deleteView];
}

@end
