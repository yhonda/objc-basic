//
//  ViewController.m
//  STVProject2-4-6
//
//  Created by kawaharadai on 2017/09/06.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()
// プロパティを定義
@property (strong, nonatomic) SLComposeViewController *facebookViewController;
// メソッドを定義
- (IBAction)postFacebookButton:(id)sender;
- (void)setFacebookViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 今回はfacebookのみでの投稿なので、あらかじめインスタンスを作れる
    [self setFacebookViewController];
}

// 表示ダイヤログを用意
- (void)setFacebookViewController {
    // SLComposeViewControllerをfacebook属性をセットしてインスタンス化
    self.facebookViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    // デフォルトテキストの設定
    [self.facebookViewController setInitialText:@"投稿テキスト"];
    // 画像を入れる場合
    [self.facebookViewController addImage:[UIImage imageNamed:@"facebookLogo"]];
    // urlを入れる場合
    [self.facebookViewController addURL:[NSURL URLWithString:@"https://www.yahoo.co.jp"]];
    
}

// 投稿ボタンアクション
- (IBAction)postFacebookButton:(id)sender {
    // 作成したダイヤログを表示する
    [self presentViewController:self.facebookViewController animated:YES completion:nil];
}

@end
