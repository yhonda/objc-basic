//
//  ViewController.m
//  STVProject2-3-2
//
//  Created by kawaharadai on 2017/08/30.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
#import "registerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初回起動かを確認
    if ([self CheckRunfirstTime]) {
        // 初回起動の場合、DBにテーブルを作成
        NSLog(@"初回起動です。");
        [self createFirstTable];
    }
    // tableViewの設定
    [self setupTableView];
    
}
// ロード後に毎回、セルの数を決定、リロードをかける
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    // セルの数を決定する
    self.cellCount = [self countId];
    // テーブルをリロード
    [self.tableView reloadData];
    
}

// DBと接続するメソッド
- (id)connectDataBase:(NSString *)dbName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir = [paths objectAtIndex:0];
    FMDatabase *database = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:dbName]];
    return database;
}

- (int)countId {
    
    // DB接続
    registerViewController *registerviewcontroller = [[registerViewController alloc]init];
    FMDatabase *db = [self connectDataBase:@"test.db"];
    
    //count文の作成
    NSString *countId = [[NSString alloc]initWithFormat:@"select count(*) as count from tr_todo where todo_id"];
    
    // DBをオープン
    [db open];
    // セットしたcount文を回して、todo_idの数を数える
    FMResultSet *countRequest = [db executeQuery:countId];
    if([countRequest next]) {
        registerviewcontroller.todo_id = [countRequest intForColumn:@"count"];
    }
    // DBを閉じる
    [db close];
    
    // 数えた値を返す
    return registerviewcontroller.todo_id;
}

// テーブルとカラムの作成
- (void)createFirstTable {
    // DBの呼び出し
    FMDatabase *db = [self connectDataBase:@"test.db"];
    // tableとカラムの作成(sqlコマンドの作成)
    NSString *createTableCommand = @"CREATE TABLE IF NOT EXISTS tr_todo (id INTEGER PRIMARY KEY,todo_id INTEGER,todo_title TEXT,todo_contents TEXT,created INTEGER,modified INTEGER,limit_date INTEGER,delete_flg TEXT);";
    // DBを開ける
    [db open];
    // 作成コマンド実行
    [db executeUpdate:createTableCommand];
    // DBを閉じる
    [db close];
}

// 初回起動を確認するメソッド
- (BOOL)CheckRunfirstTime {
    //UserDefaultsに接続
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 起動確認用の値が設定されていれば、NOを返し、されていなければ、起動証明として値を設定
    if ([userDefaults objectForKey:@"firstRun"]) {
        return NO;
    }
    // BoolをYESで保存
    [userDefaults setBool:YES forKey:@"firstRun"];
    // 即時反映
    [userDefaults synchronize];
    // 初回起動
    return YES;
}

// tableViewのセットアップ
- (void)setupTableView {
    // デリゲート接続
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // セルの高さをセル内のレイアウトに準拠するように設定
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    // セルの最低限の高さを設定
    //self.tableView.estimatedRowHeight = 60.0;
}

// セルの数（必須メソッド）
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellCount;
}

// セルの作成（必須メソッド）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // インスタンス化
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // ストーリーボードと接続、（UILabel*）の宣言はいらないかも？
    UILabel *titleLabel = [cell viewWithTag:1];
    UILabel *limit_dateLabel = [cell viewWithTag:2];
    
    // DBの呼び出し
    FMDatabase *db = [self connectDataBase:@"test.db"];
    
    //select文の作成
    // どのDBからデータを取得するかを指定
    NSString *select = [[NSString alloc] initWithFormat:@"SELECT * from tr_todo"];
    
    // DBを開く
    [db open];
    // FMResultSetにDB先をセット
    FMResultSet *resultSet = [db executeQuery:select];
    
    //　カラムtodo_title,limit_dateの値を格納する配列を用意
    NSMutableArray *titleList = [[NSMutableArray alloc]init];
    NSMutableArray *limit_dateList = [[NSMutableArray alloc]init];
    
    // nilが出るまでtodo_idに任意のカラムから値を取得し続ける
    while([resultSet next]) {
        // ラベルに直接取り出した値を代入していく
        NSString *title = [resultSet stringForColumn:@"todo_title"];
        [titleList addObject:title];
        NSString *limit = [resultSet stringForColumn:@"limit_date"];
        [limit_dateList addObject:limit];
    }
    
    // DBを閉じる
    [db close];
    
    // 多次元配列を作る
    NSMutableArray *titleAndDaysList = @[titleList,limit_dateList];
    
    // セルの番号に合わせて配列からテキストを入れていく
    titleLabel.text = titleAndDaysList[0][indexPath.row];
    limit_dateLabel.text = titleAndDaysList[1][indexPath.row];
    
    // セルを実装
    return cell;
}

// セルの幅を調節（今回はラベルが複数行にならないため、可変ではない）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
@end
