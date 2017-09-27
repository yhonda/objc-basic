//
//  ViewController.m
//  STVProject2-1-13
//
//  Created by kawaharadai on 2017/08/27.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
// プロパティ定義
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *touristSpotAsia;
@property (strong, nonatomic) NSArray *touristSpotAmerika;
@property (strong, nonatomic) NSArray *touristSpotEurope;
@property (strong, nonatomic) NSArray *touristSpotOceania;
@property (strong, nonatomic) NSArray *touristSpotAfrica;
@property (strong, nonatomic) NSArray *sectionNameList;
// メソッド定義
- (void)getPlistData;
- (void)setupNibFile;
@end

// セルの大きさの割合を決める定数を用意
static double const CellSizeDivisionNumber  = 2.3;
// セクションの高さ
static CGFloat const SectionHeight = 40;
//　セル画像判別用の変数を定義
typedef NS_ENUM(NSUInteger, touristSpots) {
    AsiaSpot,
    AmerikaSpot,
    EuropeSpot,
    OceaniaSpot,
    AfurikaSpot
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNibFile];
    [self getPlistData];
}

// nibファイルの登録、セットアップ
- (void)setupNibFile {
    UINib *cellNibFile = [UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNibFile forCellWithReuseIdentifier:@"Cell"];
    
    UINib *headerNibFile = [UINib nibWithNibName:@"CustomCollectionReusableView" bundle:nil];
    [self.collectionView registerNib:headerNibFile forSupplementaryViewOfKind:UICollectionElementKindSectionHeader      withReuseIdentifier:@"Header"];
}

// 表示データの取得
- (void)getPlistData {
    // セル内のデータを用意
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    NSBundle *bundle = NSBundle.mainBundle;
    //読み込むプロパティリストのファイルパスを指定
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    //プロパティリストの中身データを取得
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    // キー値を元に各自データリストを取得
    self.touristSpotAsia = dictionary[@"touristSpotAsia"];
    self.touristSpotAmerika = dictionary[@"touristSpotAmerika"];
    self.touristSpotEurope = dictionary[@"touristSpotEurope"];
    self.touristSpotOceania = dictionary[@"touristSpotOceania"];
    self.touristSpotAfrica = dictionary[@"touristSpotAfrica"];
    self.sectionNameList = dictionary[@"sectionName"];
}

// セクションの数を指定
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionNameList.count;
}

// セッションの表示内容を作成
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath {

    CustomCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    
    header.headerLabel.text = self.sectionNameList[indexPath.section];
    
    // セクションの実装
    return header;
}

// セクションのサイズを設定
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat sectionWidth = self.collectionView.bounds.size.width;
    CGSize sectionSize = CGSizeMake(sectionWidth, SectionHeight);
    return sectionSize;
}

// セルの数を指定（必須）
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.touristSpotAsia.count;
}

// セルの表示内容を作成（必須）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // セクションごとに画像を持ってくる配列を選択する
    switch (indexPath.section) {
        case AsiaSpot:
            cell.cellImageView.image = [UIImage imageNamed:self.touristSpotAsia[indexPath.row]];
            break;
        case AmerikaSpot:
            cell.cellImageView.image = [UIImage imageNamed:self.touristSpotAmerika[indexPath.row]];
            break;
        case EuropeSpot:
            cell.cellImageView.image = [UIImage imageNamed:self.touristSpotEurope[indexPath.row]];
            break;
        case OceaniaSpot:
            cell.cellImageView.image = [UIImage imageNamed:self.touristSpotOceania[indexPath.row]];
            break;
        case AfurikaSpot:
            cell.cellImageView.image = [UIImage imageNamed:self.touristSpotAfrica[indexPath.row]];
            break;
        default:
            break;
    }
    // セルの実装
    return cell;
}

// セルの大きさを指定
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat CellSize = self.collectionView.bounds.size.width/CellSizeDivisionNumber;
    CGSize size = CGSizeMake(CellSize, CellSize);
    return size;
}

@end
