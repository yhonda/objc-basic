//
//  ViewController.h
//  STVProject2-1-6
//
//  Created by kawaharadai on 2017/08/23.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

// デリゲート接続
@interface ViewController : UIViewController <UIWebViewDelegate>
// プロパティを宣言
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) UIAlertController *alertController;
// メソッドを定義
- (void)createAleartController;
- (void)setWebView;
- (void)webViewDidStartLoad:(UIWebView*)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (IBAction)goBackButton:(id)sender;
- (IBAction)reloadButton:(id)sender;
- (IBAction)goForwardButton:(id)sender;
@end

