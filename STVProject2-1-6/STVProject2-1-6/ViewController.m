//
//  ViewController.m
//  STVProject2-1-6
//
//  Created by kawaharadai on 2017/08/23.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import <SafariServices/SafariServices.h>

@interface ViewController()
// プロパティを宣言
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) UIAlertController *alertController;
// メソッドを定義
- (void)createAleartController;
- (void)setWebView;
- (IBAction)goBackButton:(id)sender;
- (IBAction)reloadButton:(id)sender;
- (IBAction)goForwardButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createAleartController];
    [self setWebView];
}

// オフライン時に表示するアラートの作成
- (void)createAleartController {
    
    self.alertController = [UIAlertController alertControllerWithTitle:@"通信エラー" message:@"通信エラーが発生しました。\n通信環境を確認してください。" preferredStyle:UIAlertControllerStyleAlert];
    // アラートボタンとそのアクションを設定
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"通信エラーが発生しました。");
    }
                               ];
    // アラートコントローラーにアラートをセット
    [self.alertController addAction: okButton];
}

// webViewの初期設定
- (void)setWebView {
    // 自身にデリゲートを適用
    self.webView.delegate = self;
    // ピンチイン／アウトを可能にする
    self.webView.scalesPageToFit = YES;
    
    // url用のインスタンスを生成(https~が推奨)
    NSURL *url = [NSURL URLWithString:@"https://www.yahoo.co.jp"];
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

// エラーの場合、エラーコードに応じてアラートを表示する（リクエストキャンセルはエラーにしたくない）
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // リクエストキャンセルのエラー以外は全てアラートを出す。
    if ([error code] != NSURLErrorCancelled) {
        //エラー処理
        [self presentViewController:self.alertController animated:YES completion:nil];
    }
}

// 通信開始時のチェック
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *url = request.URL;
    NSLog(@"%@", url);
    
    // httpsの場合はアクセス許可
    if ([url.scheme isEqualToString:@"https"]) {
        return YES;
    }
    
    // httpのアドレスの場合は、サファリに飛ばす
    if ([SFSafariViewController class]) {
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:url];
        [self presentViewController:safariViewController animated:YES completion:nil];
    } else {
        [[UIApplication sharedApplication] canOpenURL:url];
    }
    return NO;
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
