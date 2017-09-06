//
//  ViewController.h
//  STVProject2-5-1
//
//  Created by kawaharadai on 2017/09/06.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

// デリゲートを接続
@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate>
// メソッドを定義
- (IBAction)sendMailButton:(id)sender;

@end
