//
//  ViewController.h
//  STVProject2-1-10
//
//  Created by kawaharadai on 2017/08/24.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

// デリゲート接続
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
// プロパティを定義
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *cellImageList;
@property NSArray *cellTextList;
@end

