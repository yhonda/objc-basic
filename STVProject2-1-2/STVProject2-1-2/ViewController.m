//
//  ViewController.m
//  STVProject2-1-2
//
//  Created by kawaharadai on 2017/08/16.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// ストーリーボードのimageViewを定義
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 任意の画像をfoodImageにセットする
    // アスペクト比の設定はストーリボード側にて実装(AspectFit)
    self.foodImage.image = [UIImage imageNamed:@"AustrariaBeef"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
