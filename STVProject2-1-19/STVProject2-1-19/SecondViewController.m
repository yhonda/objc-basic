//
//  SecondViewController.m
//  STVProject2-1-19
//
//  Created by kawaharadai on 2017/08/28.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 受け取り用の変数をresultLabelに代入する
    self.resultLabel.text = self.receiveString;
}

@end

