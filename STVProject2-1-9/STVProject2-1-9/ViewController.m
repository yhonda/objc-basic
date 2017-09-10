//
//  ViewController.m
//  STVProject2-1-9
//
//  Created by kawaharadai on 2017/08/24.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// プロパティを宣言
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *pickerHiddenButton;
@property (strong, nonatomic) NSDate *todayDate;
@property (strong, nonatomic) NSDateFormatter *formatter;
// メソッドを定義
- (void)settingTodaydate;
- (void)setUpDateLabel;
- (IBAction)dateChangedAction:(id)sender;
- (IBAction)pickerHiddenAction:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpDateLabel];
    [self settingTodaydate];
}

// dateLabelの設定
- (void)setUpDateLabel {
    // dateLabelにタグをつける（タッチイベント取得用）
    self.dateLabel.tag = 1;
    // dateLabelのタッチ判定を有効にする
    self.dateLabel.userInteractionEnabled = YES;
    // datePickerとdoneボタンを隠す
    self.datePicker.hidden = YES;
    self.pickerHiddenButton.hidden = YES;
}

// 当日の日付を取得し、ラベルに表示
- (void)settingTodaydate {
    // 当日の日付を取得
    self.todayDate = [[NSDate alloc]init];
    self.todayDate = [NSDate date];
    
    // 表示用データフォーマットをインスタンス化
    self.formatter = [[NSDateFormatter alloc] init];
    
    // フォーマットに型をセット(時間まで表示する時は、@"M月dd日(E) HH:mm"でModeを変更する)
    [self.formatter setDateFormat:@"yyyy年M月dd日"];
    
    // ラベルに当日の日付を反映
    self.dateLabel.text = [self.formatter stringFromDate:self.todayDate];
}

// ラベルタッチイベントの取得(ラベルタッチでpicker表示、背景タッチでpkicker非表示)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 受け取ったタッチイベントをインスタンス化
    UITouch *touch = [[event allTouches] anyObject];
    
    // タッチ箇所によってボタンとピッカーの表示/非表示を切り替える
    if (touch.view.tag == self.dateLabel.tag){
        self.datePicker.hidden = NO;
        self.pickerHiddenButton.hidden = NO;
    } else {
        self.datePicker.hidden = YES;
        self.pickerHiddenButton.hidden = YES;
    }
}

- (IBAction)dateChangedAction:(id)sender {
    // datapikerが変更されるたびにその日付を取得してpickerに入れる
    self.dateLabel.text = [self.formatter stringFromDate:self.datePicker.date];
}

// Doneボタンアクション
- (IBAction)pickerHiddenAction:(id)sender {
    self.datePicker.hidden = YES;
    self.pickerHiddenButton.hidden = YES;
}

@end
