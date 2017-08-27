//
//  ViewController.m
//  STVProject2-1-6
//
//  Created by kawaharadai on 2017/08/23.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
- (void)webViewDidStartLoad:(UIWebView*)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
// ロード完了でインジケータを非表示
- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
