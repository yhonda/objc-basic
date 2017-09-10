//
//  ViewController.m
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/05.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()
// プロパティを定義
@property (strong, nonatomic) UIAlertController *alertController;
// メソッドを定義
- (void)setAlertController;
- (IBAction)outputWeatherForecastButton:(id)sender;
@end

//　定数を定義
// APIのURL
static NSString *const apiUrl = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // アラートコントローラーとアクションを用意
    [self setAlertController];
    
}

// アラートコントローラーとアクションシートを用意
- (void)setAlertController {
    // アラートコントローラーの生成
    self.alertController =
    [UIAlertController alertControllerWithTitle:@"日付選択"
                                        message:@"いつの予報を出力しますか？"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    // 当日の天気予報を出力するアクションを作成
    UIAlertAction *todayWeatherForecast =
    [UIAlertAction actionWithTitle:@"今日"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               // URLからJSONデータを取得
                               NSString *url = apiUrl;
                               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                               [manager GET : url parameters : nil progress:nil
                                     success:^(NSURLSessionTask *task, id responseObject) {
                                         // json取得に成功した場合の処理
                                         // 予報都市名を取得
                                         NSDictionary *location = responseObject[@"location"];
                                         NSString *city = location[@"city"];
                                         
                                         // 当日の予報情報（forecasts）を習得（index番号忘れない）
                                         NSDictionary *forecasts = responseObject[@"forecasts"][0];
                                         NSString *date = forecasts[@"date"];
                                         NSString *dateLabel = forecasts[@"dateLabel"];
                                         NSString *telop = forecasts[@"telop"];
                                         NSLog(@"%@、%@の%@の天気は、%@です。", dateLabel, date, city, telop);
                                         
                                     } failure:^(NSURLSessionTask *operation, NSError *error) {
                                         // エラーの場合の処理
                                         NSLog(@"予報データの取得に失敗しました。");
                                     }
                                ];
                           }];
    
    // 翌日の天気予報を出力するアクションを作成
    UIAlertAction *tomorrowWeatherForecast =
    [UIAlertAction actionWithTitle:@"明日"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               // URLからJSONデータを取得
                               NSString *url = apiUrl;
                               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                               [manager GET : url parameters : nil progress:nil
                                     success:^(NSURLSessionTask *task, id responseObject) {
                                         // json取得に成功した場合の処理
                                         // 予報都市名を取得
                                         NSDictionary *location = responseObject[@"location"];
                                         NSString *city = location[@"city"];
                                         
                                         // 当日の予報情報（forecasts）を習得（index番号忘れない）
                                         NSDictionary *forecasts = responseObject[@"forecasts"][1];
                                         NSString *date = forecasts[@"date"];
                                         NSString *dateLabel = forecasts[@"dateLabel"];
                                         NSString *telop = forecasts[@"telop"];
                                         NSLog(@"%@、%@の%@の天気は、%@です。", dateLabel, date, city, telop);
                                         
                                     } failure:^(NSURLSessionTask *operation, NSError *error) {
                                         // エラーの場合の処理
                                         NSLog(@"予報データの取得に失敗しました。");
                                     }
                                ];
                           }];
    
    // 明後日の天気予報を出力するアクションを作成
    UIAlertAction *afterTomorrowWeatherForecast =
    [UIAlertAction actionWithTitle:@"明後日"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               // URLからJSONデータを取得
                               NSString *url = apiUrl;
                               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                               [manager GET : url parameters : nil progress:nil
                                     success:^(NSURLSessionTask *task, id responseObject) {
                                         // json取得に成功した場合の処理
                                         // 予報都市名を取得
                                         NSDictionary *location = responseObject[@"location"];
                                         NSString *city = location[@"city"];
                                         
                                         // 当日の予報情報（forecasts）を習得（index番号忘れない）
                                         NSDictionary *forecasts = responseObject[@"forecasts"][2];
                                         NSString *date = forecasts[@"date"];
                                         NSString *dateLabel = forecasts[@"dateLabel"];
                                         NSString *telop = forecasts[@"telop"];
                                         NSLog(@"%@、%@の%@の天気は、%@です。", dateLabel, date, city, telop);
                                         
                                     } failure:^(NSURLSessionTask *operation, NSError *error) {
                                         // エラーの場合の処理
                                         NSLog(@"予報データの取得に失敗しました。");
                                     }
                                ];
                           }];
    
    // キャンセルアクションを生成
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"ボタン操作をキャンセルしました。");
                           }];
    
    // コントローラにアクションを追加
    [self.alertController addAction: todayWeatherForecast];
    [self.alertController addAction: tomorrowWeatherForecast];
    [self.alertController addAction: afterTomorrowWeatherForecast];
    [self.alertController addAction: cancelAction];
    
}

// 天気予報出力ボタン押した時のアクション
- (IBAction)outputWeatherForecastButton:(id)sender {
    // アクションシートを出力
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
