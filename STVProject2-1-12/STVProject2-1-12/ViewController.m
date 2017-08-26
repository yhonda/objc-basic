//
//  ViewController.m
//  STVProject2-1-12
//
//  Created by kawaharadai on 2017/08/27.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // デリゲートを接続
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    // セル内のデータを用意
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    NSBundle *bundle = [NSBundle mainBundle];
    //読み込むプロパティリストのファイルパスを指定
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    //プロパティリストの中身データを取得
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    // キー値を元に各自データリストを取得
    self.cellImageList = [dictionary objectForKey:@"cellImageName"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

// セルの数を指定（必須）
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

// セルの表示内容を作成（必須）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // ストーリーボードのimageviewと接続
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    // imageviewにplistから取得した画像を順に設定していく
    imageView.image = [UIImage imageNamed:self.cellImageList[indexPath.row]];
    // セルの実装
    return cell;
}

// セルの大きさを指定
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((self.collectionView.bounds.size.width/3)-(self.collectionView.bounds.size.width/12), (self.collectionView.bounds.size.width/3)-(self.collectionView.bounds.size.width/12));
}

@end
