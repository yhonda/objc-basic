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
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *telop;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSData *iconImageUrl;

// メソッドを定義
- (void)setTableView;
- (void)setAlertController;
- (IBAction)outputWeatherForecastButton:(id)sender;
@end

