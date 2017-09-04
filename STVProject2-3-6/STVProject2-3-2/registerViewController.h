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
@property UIAlertController * registerAlertController;
@property UIAlertController * doneAlertController;

// DBカラム関連プロパティ
@property int todo_id;
@property NSString *todo_title;
@property NSString *todo_contents;
@property NSString *created;
@property NSString *modified;
@property NSString *limit_date;
@property NSString *delete_flg;

// メソッドを定義
- (int)addTodo_id;
- (NSString *)getCreated;
- (NSString *)getLimit_date;
- (NSString *)getDelete_flg;
- (void)createAleart;
- (void)registerAction;
@end
