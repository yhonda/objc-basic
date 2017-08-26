//
//  ViewController.h
//  STVProject2-1-13
//
//  Created by kawaharadai on 2017/08/27.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

// デリゲート宣言
@interface ViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
// プロパティ定義
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray *touristSpotList1;
@property NSArray *touristSpotList2;
@property NSArray *touristSpotList3;
@property NSArray *touristSpotList4;
@property NSArray *touristSpotList5;
@property NSArray *sectionNameList;

@end

