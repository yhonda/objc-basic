//
//  ViewController.m
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/05.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "WeatherData.h"

@interface ViewController ()
// プロパティを定義
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *telop;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSData *iconImageUrl;

// メソッドを定義
- (void)setTableView;
- (void)setAlertController;
- (IBAction)outputWeatherForecastButton:(id)sender;
@end

// APIのURL用の定数を用意
static NSString *const apiUrl = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初回起動かを確認
    if ([self CheckRunfirstTime]) {
        // 初回起動の場合の処理
        NSLog(@"初回起動です。");
        WeatherData *weatherData = [[WeatherData alloc]init];
        [weatherData saveWeatherData:@"0" days:@"" weatherData:@"" iconUrl:nil];
    }

    // アラートコントローラーとアクションを用意
    [self setAlertController];
    
    // テーブルビューをセット
    [self setTableView];
}

// 初回起動を確認するメソッド
- (BOOL)CheckRunfirstTime {
    //UserDefaultsに接続
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 起動確認用の値が設定されていれば、NOを返し、されていなければ、起動証明として値を設定
    if ([userDefaults objectForKey:@"firstRun"]) {
        return NO;
    }
    // BoolをYESで保存
    [userDefaults setBool:YES forKey:@"firstRun"];
    // 即時反映
    [userDefaults synchronize];
    // 初回起動
    return YES;
}

// テーブルビューを設定
- (void)setTableView {
    // デリゲートを設定
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // セルの高さをセル内のレイアウトに準拠するように設定
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // セルの最低限の高さを設定
    self.tableView.estimatedRowHeight = 60.0;
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
                                         // テーブルビューデリゲートメソッドをセット
                                         [self setTableView];
                                         
                                         // 天気概況文を取得
                                         NSDictionary *description = responseObject[@"description"];
                                         self.text = description[@"text"];
                                         
                                         // forecastパラメータを取得(realmに保存)
                                         NSDictionary *forecasts = responseObject[@"forecasts"][0];
                                         
                                         // アイコン画像のurlを取得(realmに保存)
                                         NSDictionary *image = forecasts[@"image"];
                                         NSString *urlString = image[@"url"];
                                         NSURL *url = [NSURL URLWithString:urlString];
                                         NSData *data = [NSData dataWithContentsOfURL:url];
                                         
                                         // realm内情報update
                                         WeatherData *weatherData = [[WeatherData alloc]init];
                                         [weatherData updateWeatherData:@"0" days:forecasts[@"date"] weatherData:forecasts[@"telop"] iconUrl:data];
                                         
                                         
                                        // その他の情報はrealmから取り出して表示してみる
                                         RLMResults *results = [WeatherData objectsWhere:@"Id='0'"];
                                         
                                         // 日付を取得
                                         self.date = results[0][@"days"];

                                         // 天気を取得
                                         self.telop = results[0][@"weather"];
                                         // 画像のURLを取得(realm内から取得するためキャッシュされている)
                                         self.iconImageUrl = results[0][@"iconUrl"];
                                         
                                         [self.tableView reloadData];
                                         
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
                                         // テーブルビューデリゲートメソッドをセット
                                         [self setTableView];
                                         
                                         // 天気概況文を取得
                                         NSDictionary *description = responseObject[@"description"];
                                         self.text = description[@"text"];
                                         
                                         // forecastパラメータを取得(realmに保存)
                                         NSDictionary *forecasts = responseObject[@"forecasts"][1];
                                         
                                         // アイコン画像のurlを取得(realmに保存)
                                         NSDictionary *image = forecasts[@"image"];
                                         NSString *urlString = image[@"url"];
                                         NSURL *url = [NSURL URLWithString:urlString];
                                         NSData *data = [NSData dataWithContentsOfURL:url];
                                         
                                         // realm内情報update
                                         WeatherData *weatherData = [[WeatherData alloc]init];
                                         [weatherData updateWeatherData:@"1" days:forecasts[@"date"] weatherData:forecasts[@"telop"] iconUrl:data];
                                         
                                         
                                         // その他の情報はrealmから取り出して表示してみる
                                         RLMResults *results = [WeatherData objectsWhere:@"Id='1'"];

                                         // 日付を取得
                                         self.date = results[0][@"days"];
                                         
                                         // 天気を取得
                                         self.telop = results[0][@"weather"];
                                         // 画像のURLを取得
                                         self.iconImageUrl = results[0][@"iconUrl"];
                                         
                                         [self.tableView reloadData];
                                         
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
                                         // テーブルビューデリゲートメソッドをセット
                                         [self setTableView];
                                         
                                         // 天気概況文を取得
                                         NSDictionary *description = responseObject[@"description"];
                                         self.text = description[@"text"];
                                         
                                         // forecastパラメータを取得(realmに保存)
                                         NSDictionary *forecasts = responseObject[@"forecasts"][2];
                                         
                                         // アイコン画像のurlを取得(realmに保存)
                                         NSDictionary *image = forecasts[@"image"];
                                         NSString *urlString = image[@"url"];
                                         NSURL *url = [NSURL URLWithString:urlString];
                                         NSData *data = [NSData dataWithContentsOfURL:url];
                                         
                                         // realm内情報update
                                         WeatherData *weatherData = [[WeatherData alloc]init];
                                         [weatherData updateWeatherData:@"2" days:forecasts[@"date"] weatherData:forecasts[@"telop"] iconUrl:data];
                                         
                                         
                                         // その他の情報はrealmから取り出して表示してみる
                                         RLMResults *results = [WeatherData objectsWhere:@"Id='2'"];
                                         
                                         // 日付を取得
                                         self.date = results[0][@"days"];
                                         
                                         // 天気を取得
                                         self.telop = results[0][@"weather"];
                                         // 画像のURLを取得
                                         self.iconImageUrl = results[0][@"iconUrl"];
                                         
                                         [self.tableView reloadData];
                                         
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

// セルの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // 表示するラベルを用意
    UILabel *dateLabel = [cell viewWithTag:1];
    dateLabel.text = self.date;
    UILabel *telopLabel = [cell viewWithTag:2];
    telopLabel.text = self.telop;
    UITextView *textView = [cell viewWithTag:3];
    textView.text = self.text;
    
    // 表示するアイコンを用意
    UIImageView *weatherIcon = [cell viewWithTag:4];
    weatherIcon.image = [[UIImage alloc]initWithData:self.iconImageUrl];
    
    // セルを出力
    return cell;
}

@end
