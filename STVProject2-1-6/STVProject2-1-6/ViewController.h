//
//  ViewController.h
//  STVProject2-1-6
//
//  Created by kawaharadai on 2017/08/23.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

// デリゲート接続
@interface ViewController : UIViewController<UIWebViewDelegate>
// プロパティを宣言
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property UIAlertController *alertController;

@end

