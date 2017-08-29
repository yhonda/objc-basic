//
//  ViewController.h
//  STVProject2-3-1
//
//  Created by kawaharadai on 2017/08/29.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
// プロパティをを定義
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
// メソッドを定義
- (BOOL)CheckRunfirstTime;
@end

