//
//  RegisterViewController.h
//  STVProject2-3-2
//
//  Created by kawaharadai on 2017/08/31.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface RegisterViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate>
// プロパティを定義
@property (weak, nonatomic) IBOutlet UITextField *registerTextField;
@property (weak, nonatomic) IBOutlet UITextView *registerTextView;
@property (strong, nonatomic) UIAlertController *registerAlertController;
@property (strong, nonatomic) UIAlertController *doneAlertController;

// DBカラム関連プロパティ
@property  (nonatomic) int todoId;
@property  (strong, nonatomic) NSString *todoTitle;
@property  (strong, nonatomic) NSString *todoContents;
@property  (strong, nonatomic) NSString *created;
@property  (strong, nonatomic) NSString *modified;
@property  (strong, nonatomic) NSString *limitDate;
@property  (strong, nonatomic) NSString *deleteFlag;

// メソッドを定義
- (int)addTodoId;
- (NSString *)getCreated;
- (NSString *)getLimitDate;
- (void)createAleart;
- (void)registerAction;
@end
