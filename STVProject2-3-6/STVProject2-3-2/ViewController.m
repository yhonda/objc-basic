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
    
    // セル表示用のデータを取得
    [self createCellArray];

    // テーブルをリロード
    [self.tableView reloadData];
    
    // 余分な線を消す？
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
}

// DBと接続するメソッド
- (id)connectDataBase:(NSString *)dbName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir = [paths objectAtIndex:0];
    FMDatabase *database = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:dbName]];
    return database;
}

// DBに接続して要素の数を数えるメソッド
- (int)countId {
    
    // DB接続
    registerViewController *registerviewcontroller = [[registerViewController alloc]init];
    FMDatabase *db = [self connectDataBase:@"test.db"];
    
    // count文の作成（todo_idを数える）
    NSString *countId = [[NSString alloc]initWithFormat:@"select count(*) as count from tr_todo where todo_id"];
    // select文の作成（delete_flgを全て取得する）
    NSString *select = [[NSString alloc] initWithFormat:@"SELECT * from tr_todo"];

    // DBをオープン
    [db open];
    // テーブルを全てチェックして、todo_idテーブルの要素の数を数える
    FMResultSet *countRequest = [db executeQuery:countId];
    if([countRequest next]) {
        registerviewcontroller.todo_id = [countRequest intForColumn:@"count"];
    }
    // セレクト文をセット
    FMResultSet *selectRequest = [db executeQuery:select];
    // delete_flgを格納する配列を用意
    NSMutableArray *delete_flgList = [[NSMutableArray alloc]init];
    
    // delete_flgListにdelete_flgを全て取り出す
    while ([selectRequest next]) {
        NSString *delete_flg = [selectRequest stringForColumn:@"delete_flg"];
        [delete_flgList addObject:delete_flg];
    }
    
    // DBを閉じる
    [db close];

    // delete_flgがONの要素の数だけ表示セルを減らす
    for (NSString *i in delete_flgList) {
        if ([i  isEqual: @"ON"]) {
            registerviewcontroller.todo_id = registerviewcontroller.todo_id - 1;
        }
    }
    
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

// セルに表示する用の配列を作る
- (void)createCellArray {
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
    NSMutableArray *delete_flgList = [[NSMutableArray alloc]init];
    
    // nilが出るまでtodo_idに任意のカラムから値を取得し続ける
    while([resultSet next]) {
        // 値をDBから取り出す
        NSString *title = [resultSet stringForColumn:@"todo_title"];
        NSString *limit = [resultSet stringForColumn:@"limit_date"];
        NSString *delete = [resultSet stringForColumn:@"delete_flg"];
        
        // それぞれ配列に格納
        [titleList addObject:title];
        [limit_dateList addObject:limit];
        [delete_flgList addObject:delete];
    }
    
    // DBを閉じる
    [db close];
    
    // 多次元配列を作る
    self.titleAndDaysList = @[titleList,limit_dateList];
    
    // ループで回して、フラグがONのものを削除する
    for(int i=0; i<delete_flgList.count; i++){
        if ([delete_flgList[i]  isEqual: @"ON"]) {
            [self.titleAndDaysList[0] removeObjectAtIndex:i];
            [self.titleAndDaysList[1] removeObjectAtIndex:i];
        }
    }
}

// セルの数（必須メソッド）(DBの要素の数に連動)
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
    
    
    // セル用の配列を取得する
    // セルの番号に合わせて配列からテキストを入れていく
        titleLabel.text = self.titleAndDaysList[0][indexPath.row];
        limit_dateLabel.text = self.titleAndDaysList[1][indexPath.row];
    
    // セルを実装
    return cell;
}

// セルの編集機能を追加（左スワイプ）
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 削除モードの場合の処理
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // DBから削除
        FMDatabase *db = [self connectDataBase:@"test.db"];
        
        // UPDATE文を用意（DB内のデータで、選択したセル番号の要素のdelete_flgをONにして非表示にする）
        NSString *changeStatus = @"ON";
        //DBにレコードdelete_flgの更新、id=indexPath.row番目のデータを更新
        NSString *update = [[NSString alloc] initWithFormat:@"UPDATE tr_todo SET delete_flg='%@' where id=%ld", changeStatus, (long)indexPath.row+1];
        
        NSLog(@"%@", update);
        // DBをオープン
        [db open];
        
        // UPDATE文を実行
        [db executeUpdate:update];
        
        // DBを閉じる
        [db close];
        
        // セルの数を決定する
        self.cellCount = [self countId];
        
        // セル表示用のデータを取得
        [self createCellArray];
        
        // テーブルを更新
        [self.tableView reloadData];
        
    }
}

// セルを選択した時の処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

// セルの幅を調節（今回はラベルが複数行にならないため、可変ではない）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
@end
