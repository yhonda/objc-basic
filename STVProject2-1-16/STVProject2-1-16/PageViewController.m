//
//  PageViewController.m
//  STVProject2-1-16
//
//  Created by kawaharadai on 2017/08/29.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageViewController.h"

@interface PageViewController ()
// プロパティを定義
@property (strong, nonatomic) NSArray *viewControllerList;
@property (strong, nonatomic) UIViewController *viewcontroller;
@property int viewControllerIndex;
// メソッドを定義
-(void)setupPageviewController;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageviewController];
}

// pageviewcontrollerの用意、設定
-(void)setupPageviewController {
    //　pageviewcontrollerのデリゲートを接続
    self.delegate = self;
    self.dataSource = self;
    
    // pageviewcontrollerで管理するUiViewControllerのIDを配列にする
    self.viewControllerList = @[@"ViewController",
                                @"SecondViewController",
                                @"ThirdViewController"];
    
    // ページロード後、初めに表示するUiViewControllerのindexを指定する
    self.viewControllerIndex = 0;
    
    // 指定されたUiViewControllerをセット
    self.viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerList[0]];
    
    // 表示しているUiViewControllerを確認するためにタグ番号をつける(初めに表示するUiViewControllerのindex位置に合わせる)
    self.viewcontroller.view.tag = self.viewControllerIndex;
    
    // pageviewcontrollerに指定のUiViewControllerをセットし、表示させる
    [self setViewControllers:@[self.viewcontroller] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

// ページを左方向にスライドした時の処理（戻り方向）
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    // 表示中のUIViewControllerに振られたタグ番号を取得
    self.viewControllerIndex = (int)viewController.view.tag;
    
    // タグが0または読み込めなかった場合は、nilを返す（ページングできない）
    if( (self.viewControllerIndex == 0) || (self.viewControllerIndex == NSNotFound) ) {
        return nil;
    }
    
    // 現在のタグから-1し、その番号に応じたUIViewControllerを配列から取り出し、表示する（タグをつけ直すのを忘れずに）
    self.viewControllerIndex--;
    
    self.viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerList[self.viewControllerIndex]];
    
    self.viewcontroller.view.tag = self.viewControllerIndex;
    
    // 新たに取り出したUIViewControllerを表示する
    return self.viewcontroller;
}

// ページを右方向にスライドした時の処理（進み方向）
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    // 表示中のUIViewControllerに振られたタグ番号を取得
    self.viewControllerIndex = (int)viewController.view.tag;
    
    // 現在のタグから+1し、その番号に応じたUIViewControllerを配列から取り出し、表示する（足した後にタグをつけ直すのを忘れずに）
    self.viewControllerIndex++;
    
    // タグが、用意したUIViewControllerの数以上または読み込めなかった場合は、nilを返す（ページングできないようにする）
    
    if ( (self.viewControllerIndex >= self.viewControllerList.count) || (self.viewControllerIndex == NSNotFound) ) {
        return nil;
    }
    
    self.viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerList[self.viewControllerIndex]];
    
    self.viewcontroller.view.tag = self.viewControllerIndex;
    
    // 新たに取り出したUIViewControllerを表示する
    return self.viewcontroller;
}

@end
