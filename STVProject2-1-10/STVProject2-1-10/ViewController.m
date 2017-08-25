//
//  ViewController.m
//  STVProject2-1-10
//
//  Created by kawaharadai on 2017/08/24.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // デリゲート接続
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // セルの高さをセル内のレイアウトに準拠するように設定
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // セルの最低限の高さを設定
    self.tableView.estimatedRowHeight = 60.0;
    
    // セル内のデータを用意
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    NSBundle *bundle = [NSBundle mainBundle];
    //読み込むプロパティリストのファイルパスを指定
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    //プロパティリストの中身データを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    // キー値を元に各自データリストを取得
    self.cellImageList = [dic objectForKey:@"travelImageName"];
    self.cellTextList = [dic objectForKey:@"travelExplainText"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// セルの数（必須メソッド）
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellImageList.count;
}
// セルの作成（必須メソッド）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // インスタンス化
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // ストーリーボードのラベルをインスタンス化
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    // ラベルの行数設定を無制限にする
    label.numberOfLines = 0;
    // ラベルテキストをセット
    label.text = self.cellTextList[indexPath.row];
    // ストーリーボードのイメージビューをインスタンス化
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:2];
    // 画像をセット
    imageView.image = [UIImage imageNamed:self.cellImageList[indexPath.row]];
    // セルを実装
    return cell;
}

@end
