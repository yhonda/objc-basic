//
//  ViewController.m
//  STVProject2-1-1
//
//  Created by kawaharadai on 2017/08/16.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// ストーリーボードのラベルと接続
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // ラベルに文字列を表示
    _resultLabel.text = @"Obj-C講座をスタートしました。";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
