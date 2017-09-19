//
//  ViewController.m
//  STVProject2-1-11
//
//  Created by kawaharadai on 2017/08/25.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
// プロパティを定義
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *sectionNameList;
@property (strong, nonatomic) NSArray *cellImageList;
@property (strong, nonatomic) NSArray *cellTextList;
@property (strong, nonatomic) NSDictionary *plistDictionary;
// メソッドを定義
- (void)setupTableView;
- (void)getPlistData;
@end

// 旅行地方面をenumu定数で用意
typedef NS_ENUM(NSUInteger, travelPotion) {
    AsiaPotion = 0,
    AmerikaPotion,
    EuropePotion,
    OceaniaPotion,
    AfurikaPotion
};
// セクションの高さを用意
static int const CellHeight = 30;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self getPlistData];
}

// テーブルビューの設定
- (void)setupTableView {
    // セルの高さをセル内のレイアウトに準拠するように設定
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // セルの基本値の高さを確保
    self.tableView.estimatedRowHeight = 100.0;
}

// 表示データの取得
- (void)getPlistData {
    // セル内のデータを用意
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    NSBundle *bundle = NSBundle.mainBundle;
    //読み込むプロパティリストのファイルパスを指定
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    //プロパティリストの中身データを取得
    self.plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    // キー値を元に各自データリストを取得（セクションタイトル、セル内画像、セル内テキスト）
    self.sectionNameList = self.plistDictionary[@"destinationName"];
    self.cellImageList = self.plistDictionary[@"traveAsialImageName"];
    self.cellTextList = self.plistDictionary[@"travelAsiaExplainText"];
}

// セクション数を設定
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionNameList.count;
}

// セクションのヘッダータイトル
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionNameList[section];
}

// セクションの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CellHeight;
}

// セルの数（必須メソッド）
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX(self.cellImageList.count, self.cellTextList.count);
}

// セルの作成（必須メソッド）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // インスタンス化
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // セクションのインデックスによって別々のテキストと画像の配列を用意する
    switch (indexPath.section) {
        case AsiaPotion:
            self.cellImageList = self.plistDictionary[@"traveAsialImageName"];
            self.cellTextList = self.plistDictionary[@"travelAsiaExplainText"];
            break;
        case AmerikaPotion:
            self.cellImageList = self.plistDictionary[@"traveAmerikalImageName"];
            self.cellTextList = self.plistDictionary[@"travelAmerikaExplainText"];
            break;
        case EuropePotion:
            self.cellImageList = self.plistDictionary[@"travelEuropeImageName"];
            self.cellTextList = self.plistDictionary[@"travelEuropeExplainText"];
            break;
        case OceaniaPotion:
            self.cellImageList = self.plistDictionary[@"travelOceaniaImageName"];
            self.cellTextList = self.plistDictionary[@"travelOceaniaExplainText"];
            break;
        case AfurikaPotion:
            self.cellImageList = self.plistDictionary[@"traveAfurikalImageName"];
            self.cellTextList = self.plistDictionary[@"travelAfurikaExplainText"];
            break;
        default:
            break;
    }
    // ラベルテキストをセット
    cell.textLabel.text = self.cellTextList[indexPath.row];
    // 画像をセット
    cell.imageView.image = [UIImage imageNamed: self.cellImageList[indexPath.row]];
    // セルを実装
    return cell;
}

@end
