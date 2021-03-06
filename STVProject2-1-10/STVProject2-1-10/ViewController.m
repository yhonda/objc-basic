//
//  ViewController.m
//  STVProject2-1-10
//
//  Created by kawaharadai on 2017/08/24.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
// プロパティを定義
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *cellImageList;
@property (strong, nonatomic) NSArray *cellTextList;
// メソッドを定義
- (void)setupTableView;
- (void)getPlistData;
@end

static CGFloat const cellRowEstimateHeigt = 100;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPlistData];
    [self setupTableView];
}

- (void)setupTableView {
    // セルの高さをセル内のレイアウトに準拠するように設定
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // セルの最低限の高さを設定
    self.tableView.estimatedRowHeight = cellRowEstimateHeigt;
}

- (void)getPlistData {
    // セル内のデータを用意
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    NSBundle *bundle = NSBundle.mainBundle;
    //読み込むプロパティリストのファイルパスを指定
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    //プロパティリストの中身データを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    // キー値を元に各自データリストを取得
    self.cellImageList = dic[@"travelImageName"];
    self.cellTextList = dic[@"travelExplainText"];
}

// セルの数（必須メソッド）
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX(self.cellImageList.count, self.cellTextList.count);
}

// セルの作成（必須メソッド）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // インスタンス化
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.cellTextList[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.cellImageList[indexPath.row]];
    
    // セルを実装
    return cell;
}

@end
