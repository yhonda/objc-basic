//
//  ViewController.m
//  STVProject2-1-3
//
//  Created by kawaharadai on 2017/08/17.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// プロパティと変数の定義
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property NSArray *imageList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 配列を初期化、画像名を初期値として設定
    self.imageList = @[@"Austraria", @"Bari", @"Guam", @"Kanagawa", @"Vetonum"];
}

// ボタンを押した時のメソッド
- (IBAction)chengeBackground:(id)sender {
    // 0〜4からランダムに値を取得
    int randomCount = arc4random_uniform((int)self.imageList.count);
    // 取得したランダム値にて、imageListから画像名を取得し、背景画像にセット
    self.backgroundView.image = [UIImage imageNamed: self.imageList[randomCount]];
}

@end
