//
//  ViewController.h
//  STVProject2-1-12
//
//  Created by kawaharadai on 2017/08/27.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

// デリゲート接続
@interface ViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
// プロパティ宣言
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray *cellImageList;

@end

