//
//  SecondViewController.m
//  STVProject2-1-17
//
//  Created by kawaharadai on 2017/08/28.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
// メソッドを定義
- (IBAction)backButton:(id)sender;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 戻るボタンを押した時、遷移元の画面に戻る
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
