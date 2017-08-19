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
@property int randomCount;
@property NSString * imageName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 変数を用意
    _imageList = @[@"Austraria", @"Bari", @"Guam", @"Kanagawa", @"Vetonum"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// ボタンを押した時のメソッド
- (IBAction)chengeBackground:(id)sender {
    // 0〜4からランダムに値を取得
    _randomCount = arc4random_uniform((int)_imageList.count);
    // 用意したランダム値にて、_imageListから画像名を取得し、背景画像にセット
    _backgroundView.image = [UIImage imageNamed:_imageList[_randomCount]];
    }

@end
