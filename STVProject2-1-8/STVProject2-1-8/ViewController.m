//
//  ViewController.m
//  STVProject2-1-8
//
//  Created by kawaharadai on 2017/08/23.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// プロパティを定義
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *pickerHiddenButton;
@property (strong, nonatomic) NSArray *userAgeChoice;
// メソッドを定義
- (void)setupPickerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPickerView];
}

// ピッカーを用意する
- (void)setupPickerView {
    // ピッカーの選択肢をインスタンス化
    self.userAgeChoice = @[@"10代", @"20代", @"30代", @"40代", @"50代"];
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
    self.resultLabel.text = [NSString stringWithFormat:@"私の年齢は%@です。", self.userAgeChoice[row]];
}

// ラベルタッチイベント
- (IBAction)labelTouch:(id)sender {
    // 初期のテキスト表示
    if ([self.resultLabel.text  isEqual: @"年層を選択してください"]) {
        self.resultLabel.text = [NSString stringWithFormat:@"私の年齢は%@です。", self.userAgeChoice[0]];
    }
    // ピッカーと閉じるボタンが非表示の場合表示する
    if ((self.pickerView.hidden = YES) && (self.pickerHiddenButton.hidden = YES)) {
        self.pickerView.hidden = NO;
        self.pickerHiddenButton.hidden = NO;
    }
}

// タッチでピッカーとDoneボタンを非表示にする
- (IBAction)closePckerAndDoneButton:(id)sender {
    self.pickerView.hidden = YES;
    self.pickerHiddenButton.hidden = YES;
}

@end
