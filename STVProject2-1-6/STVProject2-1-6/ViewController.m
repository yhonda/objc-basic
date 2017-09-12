//
//  ViewController.m
//  STVProject2-1-6
//
//  Created by kawaharadai on 2017/08/23.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()
// プロパティを宣言
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIAlertController *alertController;
// メソッドを定義
- (void)createAleartController;
- (void)setWebView;
@end

// 起動時にアクセスするURL
static NSString *const openUrl = @"http://www.yahoo.co.jp";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createAleartController];
    [self setWebView];
}

// オフライン時に表示するアラートの作成
- (void)createAleartController {
    
    NSString *alertTitle = [NSBundle.mainBundle localizedStringForKey:@"alertTitle" value:nil table:@"Localizable"];
    
    NSString *alertMessege = [NSBundle.mainBundle localizedStringForKey:@"alertMessege" value:nil table:@"Localizable"];
    
    NSString *alertActiontitle = [NSBundle.mainBundle localizedStringForKey:@"alertActiontitle" value:nil table:@"Localizable"];
    
    self.alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessege preferredStyle:UIAlertControllerStyleAlert];
    
    // アラートボタンとそのアクションを設定
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:alertActiontitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"通信エラーが発生しました。");
    }
                               ];
    // アラートコントローラーにアラートをセット
    [self.alertController addAction: okButton];
    NSLog(@"アラートセット完了");
}

// webViewの初期設定
- (void)setWebView {
    // url用のインスタンスを生成(https~が推奨)
    NSURL *url = [NSURL URLWithString:openUrl];
    // リクエスト用のインスタンスにurlをセット
    NSURLRequest *reqest = [NSURLRequest requestWithURL:url];
    // webviewにリクエストを投げる
    [self.webView loadRequest:reqest];
}

// ロード時にインジケータをまわす
- (void)webViewDidStartLoad:(UIWebView*)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// ロード完了でインジケータを非表示
- (void)webViewDidFinishLoad:(UIWebView*)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// エラーの場合、エラーコードに応じてアラートを表示する（今回はオフラインの場合のみアラートを出す）
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    // オフラインによるエラー場合のみアラートを出す（エラーコードは-1009）
    if (error.code == NSURLErrorNotConnectedToInternet) {
        [self presentViewController:self.alertController animated:YES completion:nil];
    }
}

//　戻るボタン、押すとデリゲートメソッドの「goBack」を呼び出す
- (IBAction)goBackButton:(id)sender {
    [self.webView goBack];
}

//　リロードボタン、押すとデリゲートメソッドの「reload」を呼び出す
- (IBAction)reloadButton:(id)sender {
    [self.webView reload];
}

//　進むボタン、押すとデリゲートメソッドの「goForward」を呼び出す
- (IBAction)goForwardButton:(id)sender {
    [self.webView goForward];
}

@end
