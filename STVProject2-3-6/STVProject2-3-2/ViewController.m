//
//  ViewController.m
//  STVProject2-3-2
//
//  Created by kawaharadai on 2017/08/30.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
#import "RegisterViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
// プロパティ定義
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) int cellCount;
@property (strong, nonatomic) NSMutableArray *todoIdList;
@property (strong, nonatomic) NSMutableArray *titleList;
@property (strong, nonatomic) NSMutableArray *limitDateList;
//メソッド定義
- (void)createFirstTable;
- (void)createDataSource;
- (BOOL)checkRunFirstTime;
- (int)countId;
@end

// 接続DB名を定数として用意
NSString *const AccessDatabaseName = @"test.db";
// 初回起動確認用のuserDefaultsのkey
static NSString *const CheckFirstRunTimeKey = @"firstRun";
// 表示するセルの判定ステータス
static NSString *const IndicateJudgeStatus = @"OFF";
// セルの高さ
static CGFloat const CellHeightValue = 80;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初回起動かを確認
    if ([self checkRunFirstTime]) {
        // 初回起動の場合、DBにテーブルを作成
        NSLog(@"初回起動です。");
        [self createFirstTable];
    }
    // カスタムセルの登録
    UINib *nib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}

// ロード後に毎回、セルの数を決定、リロードをかける
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // セルの数を決定する(初期化をしてから)
    self.cellCount = 0;
    self.cellCount = [self countId];
    // ここでDataSourceを作る
    [self createDataSource];
    // テーブルをリロード
    [self.tableView reloadData];
}

// DBと接続するメソッド
- (id)connectDataBase:(NSString *)dbName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir = paths[0];
    FMDatabase *database = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:dbName]];
    return database;
}

//DataSourceを作成
- (void)createDataSource {
    // DBの呼び出し
    FMDatabase *db = [self connectDataBase:AccessDatabaseName];
    //select文の作成（DB内のデータをlimitDateカラムに準ずる形で並べ替えて取り出す）
    // どのDBからデータを取得するかを指定
    NSString *select = [[NSString alloc] initWithFormat:@"SELECT * from tr_todo order by limit_date asc"];
    // DBを開く
    [db open];
    // FMResultSetにDB先をセット
    FMResultSet *resultSet = [db executeQuery:select];
    //　カラムtodoTitle,limitDateの値を格納する配列を用意
    self.todoIdList = [@[] mutableCopy];
    self.titleList = [@[] mutableCopy];
    self.limitDateList = [@[] mutableCopy];
    
    while([resultSet next]) {
        // ラベルに直接取り出した値を代入していく
        NSString *todoIdText = [resultSet stringForColumn:@"todo_id"];
        NSString *title = [resultSet stringForColumn:@"todo_title"];
        NSString *limit = [resultSet stringForColumn:@"limit_date"];
        NSString *deleteFlag = [resultSet stringForColumn:@"delete_flg"];
        
        if ([deleteFlag isEqualToString:IndicateJudgeStatus]) {
            [self.todoIdList addObject:todoIdText];
            [self.titleList addObject:title];
            [self.limitDateList addObject:limit];
        }
    }
    // DBを閉じる
    [db close];
}

// セルの数を決定（deleteフラグがOFFの要素のみ）
- (int)countId {
    // DB接続
    RegisterViewController *registerViewController = [[RegisterViewController alloc]init];
    FMDatabase *db = [self connectDataBase:AccessDatabaseName];
    //count文の作成
    NSString *countId = [[NSString alloc]initWithFormat:@"select count(*) as count from tr_todo where delete_flg='OFF'"];
    // DBをオープン
    [db open];
    // セットしたcount文を回して、todo_idの数を数える
    FMResultSet *countRequest = [db executeQuery:countId];
    if([countRequest next]) {
        registerViewController.todoId = [countRequest intForColumn:@"count"];
    }
    // DBを閉じる
    [db close];
    // 数えた値を返す
    return registerViewController.todoId;
}

// テーブルとカラムの作成
- (void)createFirstTable {
    // DBの呼び出し
    FMDatabase *db = [self connectDataBase:AccessDatabaseName];
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
- (BOOL)checkRunFirstTime {
    //UserDefaultsに接続
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    // 起動確認用の値が設定されていれば、NOを返し、されていなければ、起動証明として値を設定
    if ([userDefaults objectForKey:CheckFirstRunTimeKey]) {
        return NO;
    }
    // BoolをYESで保存
    [userDefaults setBool:YES forKey:CheckFirstRunTimeKey];
    // 即時反映
    [userDefaults synchronize];
    // 初回起動
    return YES;
}

// セルの数（必須メソッド）
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellCount;
}

// セルの作成（必須メソッド）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // インスタンス化
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    // セルの番号に合わせて配列からテキストを入れていく
    cell.titleLabel.text = self.titleList[indexPath.row];
    cell.limitDateLabel.text = [[NSString alloc] initWithFormat:@"期限日：%@", self.limitDateList[indexPath.row]];
    // セルを実装
    return cell;
}

// セルの編集機能を追加（スワイプで編集メニューが出る）
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 削除モードでボタンを押したとき
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 押されたセルのフラグをONにupdateする
        // DBの呼び出し
        FMDatabase *db = [self connectDataBase:AccessDatabaseName];
        // DBデータのdelete_flgに上書きするテキストを用意
        NSString *deleteFlagText = @"ON";
        // DB側で上書きするインデックスを作成
        NSString *deleteTodoIdIndex = self.todoIdList[indexPath.row];
        // updateコマンドを設定
        NSString *update = [[NSString alloc]initWithFormat:@"UPDATE tr_todo set delete_flg='%@' where id=%@", deleteFlagText, deleteTodoIdIndex];
        // DBへコマンドを実行
        [db open];
        [db executeUpdate:update];
        [db close];
        
        // 再度セル数の設定
        self.cellCount = [self countId];
        // 最新のデータソースを作成
        [self createDataSource];
        // テーブルビューを更新（非表示更新の際にアニメーションをつける(いらない場合はreloadDataでも可)）
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

// セルの幅を調節（今回はラベルが複数行にならないため、可変ではない）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeightValue;
}

@end
