//
//  registerViewController.h
//  STVProject2-3-2
//
//  Created by kawaharadai on 2017/08/31.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface registerViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate>
// プロパティを定義
@property (weak, nonatomic) IBOutlet UITextField *registerTextField;
@property (weak, nonatomic) IBOutlet UITextView *registerTextView;
@property (strong, nonatomic) UIAlertController * registerAlertController;
@property (strong, nonatomic) UIAlertController * doneAlertController;

// DBカラム関連プロパティ
@property  (nonatomic) int todo_id;
@property  (strong, nonatomic) NSString *todo_title;
@property  (strong, nonatomic) NSString *todo_contents;
@property  (strong, nonatomic) NSString *created;
@property  (strong, nonatomic) NSString *modified;
@property  (strong, nonatomic) NSString *limit_date;
@property  (strong, nonatomic) NSString *delete_flg;

// メソッドを定義
- (int)addTodo_id;
- (NSString *)getCreated;
- (NSString *)getLimit_date;
- (void)createAleart;
- (void)registerAction;
- (IBAction)resisterButton:(id)sender;
- (IBAction)backButton:(id)sender;
- (IBAction)backgroundKeyboard:(id)sender;

@end
