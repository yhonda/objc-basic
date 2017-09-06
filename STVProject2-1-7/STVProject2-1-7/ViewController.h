//
//  ViewController.h
//  STVProject2-1-7
//
//  Created by kawaharadai on 2017/08/23.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

// デリゲートを接続
@interface ViewController : UIViewController<UITextFieldDelegate>
// プロパティを定義
@property (weak, nonatomic) IBOutlet UITextField *textField;
// メソッドを定義
- (IBAction)tapBackground:(id)sender;

@end

