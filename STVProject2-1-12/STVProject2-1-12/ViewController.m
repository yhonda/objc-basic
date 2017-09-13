//
//  ViewController.m
//  STVProject2-1-12
//
//  Created by kawaharadai on 2017/08/27.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// プロパティ宣言
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *cellImageList;
// メソッド定義
- (void)getPlistData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"Cell"];
    [self getPlistData];
}

// 表示データを取得
- (void)getPlistData {
    // セル内のデータを用意
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    NSBundle *bundle = NSBundle.mainBundle;
    //読み込むプロパティリストのファイルパスを指定
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    //プロパティリストの中身データを取得
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    // キー値を元に各自データリストを取得
    self.cellImageList = @[];
    self.cellImageList = dictionary[@"cellImageName"];
}

// セルの数を指定（必須）
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

// セルの表示内容を作成（必須）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.cellImageView.image = [UIImage imageNamed:self.cellImageList[indexPath.row]];
    return cell;
}

// セルの大きさを指定
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 大きさ比率調整用の定数を定義
    static int const divisionNumber = 4;
    // 幅と高さに使用する変数を用意
    CGFloat CellSize = 0;
    CellSize = collectionView.bounds.size.width/divisionNumber;
    // インスタンスを生成（セルは正方形とする）
    CGSize size = CGSizeMake(CellSize, CellSize);

    return size;
}

@end
