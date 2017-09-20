//
//  ViewController.h
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/05.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *threeDaysDateList;
@property (nonatomic, strong) NSMutableArray *threeDaysTelopList;
@property (nonatomic, strong) NSMutableArray *threeDaysTextList;
@property (nonatomic, strong) NSMutableArray *threeDaysIconImageUrlList;
@end

