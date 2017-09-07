//
//  ViewController.h
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/05.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
// プロパティを定義
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UIAlertController *alertController;
@property NSString *date;
@property NSString *telop;
@property NSString *text;
@property NSData *iconImageUrl;

// メソッドを定義
- (void)setTableView;
- (void)setAlertController;
@end

