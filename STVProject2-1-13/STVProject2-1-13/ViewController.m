//
//  ViewController.m
//  STVProject2-1-13
//
//  Created by kawaharadai on 2017/08/27.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// プロパティ定義
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *touristSpotList1;
@property (strong, nonatomic) NSArray *touristSpotList2;
@property (strong, nonatomic) NSArray *touristSpotList3;
@property (strong, nonatomic) NSArray *touristSpotList4;
@property (strong, nonatomic) NSArray *touristSpotList5;
@property (strong, nonatomic) NSArray *sectionNameList;
// メソッド定義
- (void)setupCollectionView;
- (void)getPlistData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    [self getPlistData];
}

// collectionviewの設定
- (void)setupCollectionView {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

// 表示データの取得
- (void)getPlistData {
    // セル内のデータを用意
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    NSBundle *bundle = [NSBundle mainBundle];
    //読み込むプロパティリストのファイルパスを指定
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    //プロパティリストの中身データを取得
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    // キー値を元に各自データリストを取得
    self.touristSpotList1 = @[];
    self.touristSpotList2 = @[];
    self.touristSpotList3 = @[];
    self.touristSpotList4 = @[];
    self.touristSpotList5 = @[];
    self.sectionNameList = @[];
    
    self.touristSpotList1 = dictionary[@"touristSpot1"];
    self.touristSpotList2 = dictionary[@"touristSpot2"];
    self.touristSpotList3 = dictionary[@"touristSpot3"];
    self.touristSpotList4 = dictionary[@"touristSpot4"];
    self.touristSpotList5 = dictionary[@"touristSpot5"];
    self.sectionNameList = dictionary[@"sectionName"];
}

// セクションの数を指定
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

// セッションの表示内容を作成
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath {
    // ストーリーボードのヘッダーをインスタンス化
    UICollectionReusableView* header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"
                                                                                 forIndexPath:indexPath];
    // ストーリーボードのラベルと接続
    UILabel *label = [header viewWithTag:1];
    // セクション番号に沿ったセクションネームを持ってくる
    label.text = self.sectionNameList[indexPath.section];
    // セクションの実装
    return header;
}

// セクションの高さを設定
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.bounds.size.width, 40);
}

// セルの数を指定（必須）
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

// セルの表示内容を作成（必須）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // ストーリーボードのimageviewと接続
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:2];
    // セクションごとに画像を持ってくる配列を選択する
    switch (indexPath.section) {
        case 0:
            imageView.image = [UIImage imageNamed:self.touristSpotList1[indexPath.row]];
            break;
        case 1:
            imageView.image = [UIImage imageNamed:self.touristSpotList2[indexPath.row]];
            break;
        case 2:
            imageView.image = [UIImage imageNamed:self.touristSpotList3[indexPath.row]];
            break;
        case 3:
            imageView.image = [UIImage imageNamed:self.touristSpotList4[indexPath.row]];
            break;
        case 4:
            imageView.image = [UIImage imageNamed:self.touristSpotList5[indexPath.row]];
            break;
        default:
            break;
    }
    // セルの実装
    return cell;
}

// セルの大きさを指定
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((self.collectionView.bounds.size.width/2)-(self.collectionView.bounds.size.width/15), (self.collectionView.bounds.size.width/2)-(self.collectionView.bounds.size.width/15));
}

@end
