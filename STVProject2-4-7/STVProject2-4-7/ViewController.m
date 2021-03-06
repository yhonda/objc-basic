//
//  ViewController.m
//  STVProject2-4-7
//
//  Created by kawaharadai on 2017/09/05.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()
// プロパティを定義
@property SLComposeViewController *twitterViewController;
// メソッドを定義
- (IBAction)tapTwirtButton:(id)sender;
@end

static NSString *const postImageName = @"twitterLogo";
static NSString *const postPageUrl = @"https://github.com";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // ツイッター機能を用意
    [self setTwitterViewController];
}

// ツイッターの表示ダイヤログを用意
- (void)setTwitterViewController {
    
    self.twitterViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    // 初期値の文字列を設定
    [self.twitterViewController setInitialText:[NSBundle.mainBundle localizedStringForKey:@"postText" value:nil table:@"Localizable"]];
    // 一緒に投稿する画像を設定(nilの場合はURL部分の)
    [self.twitterViewController addImage:[UIImage imageNamed:postImageName]];
    // 一緒に投稿するURLを設定
    [self.twitterViewController addURL:[NSURL URLWithString:postPageUrl]];
    
}

// ツイートボタンを押した時
- (IBAction)tapTwirtButton:(id)sender {
    // 用意したツイート投稿のダイヤログを表示
    [self presentViewController:self.twitterViewController animated:YES completion:nil];
}
@end
