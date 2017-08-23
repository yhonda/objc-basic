//
//  ViewController.h
//  STVProject2-1-8
//
//  Created by kawaharadai on 2017/08/23.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>
// デリゲートを接続
@interface ViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
// プロパティを定義
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *pickerHiddenButton;
@property NSArray *userAgeChoice;
@end

