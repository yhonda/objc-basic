//
//  SecondViewController.h
//  STVProject2-1-19
//
//  Created by kawaharadai on 2017/08/28.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
// 受け取り用ラベルのプロパティを定義
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property NSString *receiveString;

@end
