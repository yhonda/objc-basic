//
//  ViewController.h
//  STVProject2-3-2
//
//  Created by kawaharadai on 2017/08/30.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
// プロパティ定義
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//メソッド定義
- (void)createFirstTable;
- (BOOL)CheckRunfirstTime;
- (void)setupTableView;

@end

