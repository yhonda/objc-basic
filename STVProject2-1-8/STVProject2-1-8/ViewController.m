//
//  ViewController.m
//  STVProject2-1-8
//
//  Created by kawaharadai on 2017/08/23.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // デリゲートと接続
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    // ピッカーの選択肢をインスタンス化
    self.userAgeChoice = @[@"10代",@"20代",@"30代",@"40代",@"50代"];
    // ピッカーとdoneボタンを隠しておく
    self.pickerView.hidden = YES;
    self.pickerHiddenButton.hidden = YES;
    // ラベルのタッチイベントを取得するための設定
    self.resultLabel.userInteractionEnabled = YES;
    self.resultLabel.tag = 1;
    
}

// デリゲートメソッドの実装
// 列数を返す
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
}

// 行数を返す(列ごとの選択肢の数)
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.userAgeChoice.count;

}
// 表示する内容を返す例
-(NSString*)pickerView:(UIPickerView*)pickerView
           titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.userAgeChoice[row];

}

// 選択されたpickerviewを取得
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.resultLabel.text = [NSString stringWithFormat:@"私の年齢は%@です。",self.userAgeChoice[row]];
}
// ラベルタッチイベントの取得
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 受け取ったタッチイベントをインスタンス化
    UITouch *touch = [[event allTouches] anyObject];
    
    // 取得したタッチイベントviewのタグがラベルに設定した値の場合、pickerviewとdoneボタンを出し、それ以外の場合pickerviewとdoneボタンを非表示にする（pickerview部分にはタッチ判定がない？）
    if (touch.view.tag == self.resultLabel.tag){
        if ([self.resultLabel.text  isEqual: @"年層を選択してください"]) {
            self.resultLabel.text = [NSString stringWithFormat:@"私の年齢は%@です。",self.userAgeChoice[0]];
        }
        self.pickerView.hidden = NO;
        self.pickerHiddenButton.hidden = NO;
    }else{
        self.pickerView.hidden = YES;
        self.pickerHiddenButton.hidden = YES;

    }
}

// Doneボタンアクション、pickerviewとdoneボタンを非表示にする
- (IBAction)pickerHiddenAction:(id)sender {
    self.pickerView.hidden = YES;
    self.pickerHiddenButton.hidden = YES;
}

@end
