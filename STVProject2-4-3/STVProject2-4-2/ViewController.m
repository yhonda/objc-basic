//
//  ViewController.m
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/05.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "WeatherForecastCell.h"

@interface ViewController ()
// プロパティを定義
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) NSMutableArray *threeDaysDateList;
@property (nonatomic, strong) NSMutableArray *threeDaysTelopList;
@property (nonatomic, strong) NSMutableArray *threeDaysTextList;
@property (nonatomic, strong) NSMutableArray *threeDaysIconImageUrlList;

// メソッドを定義
- (void)setTableView;
- (void)setAlertController;
- (UIAlertAction *)createTodayButton;
- (UIAlertAction *)createTomorrowButton;
- (UIAlertAction *)createAfterTomorrowButton;
- (UIAlertAction *)createCancelButton;
- (UIAlertAction *)createAllSelectButton;
- (void)createDataSoruceSubThread:(NSDictionary *)forecastsDictionary;
- (void)createDataSoruceMainThread:(NSDictionary *)forecastsDictionary descriptionDictionary:(NSDictionary *)descriptionDictionary;

- (NSData *)createImageData:(NSString *)imageDataText;

@end

// APIのURL用の定数を用意
static NSString *const apiUrl = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010";
// APIに日時指定をリクエストする用の定数
static int const TodayForecastApiNumber = 0;
static int const TomorrowForecastApiNumber = 1;
static int const AfterTomorrowForecastApiNumber = 2;
// ３日間全ての情報を取得する場合に使用する定数
static int const ThreeDaysForecastRequestNumber = 3;
// 画像読み込み中に表示する画像名
static NSString *const notFoundImageName = @"noImageIcon";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // アラートコントローラーとアクションを用意
    [self setAlertController];
    // テーブルビューをセット
    [self setTableView];
}

// テーブルビューを設定
- (void)setTableView {
    // nibファイルの登録
    UINib *nib = [UINib nibWithNibName:@"WeatherForecastCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    // セルの高さをセル内のレイアウトに準拠するように設定
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // セルの最低限の高さを設定
    self.tableView.estimatedRowHeight = 100.0;
}

// アラートコントローラーとアクションシートを用意
- (void)setAlertController {
    // アラートコントローラーの生成
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartTitle" value:nil table:@"Localizable"];
    NSString *messageText = [NSBundle.mainBundle localizedStringForKey:@"aleartMesaage" value:nil table:@"Localizable"];
    self.alertController =
    [UIAlertController alertControllerWithTitle:titleText
                                        message:messageText
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    // コントローラにアクションを追加
    [self.alertController addAction:[self createAllSelectButton]];
    [self.alertController addAction:[self createTodayButton]];
    [self.alertController addAction: [self createTomorrowButton]];
    [self.alertController addAction: [self createAfterTomorrowButton]];
    [self.alertController addAction: [self createCancelButton]];
}

- (UIAlertAction *)createAllSelectButton {
    // 当日の天気予報を出力するアクションを作成
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartActionTitleThreeDaysWeather" value:nil table:@"Localizable"];
    UIAlertAction *threeDaysWeatherForecast =
    [UIAlertAction actionWithTitle:titleText
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // 並列処理用のスレッドを用意
                               dispatch_queue_t mainQueue = dispatch_get_main_queue();
                               dispatch_queue_t subQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                               // 格納用の配列用意
                               self.threeDaysDateList = [@[] mutableCopy];
                               self.threeDaysTelopList = [@[] mutableCopy];
                               self.threeDaysTextList = [@[] mutableCopy];
                               self.threeDaysIconImageUrlList = [@[] mutableCopy];
                               // URLからJSONデータを取得
                               NSString *url = apiUrl;
                               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                               [manager GET : url parameters : nil progress:nil
                                     success:^(NSURLSessionTask *task, id responseObject) {
                                         // サブスレッド処理
                                         dispatch_async(subQueue, ^{
                                             // バックグラウンドで行う処理を記述
                                             for(int i=0; i<ThreeDaysForecastRequestNumber; i++) {
                                                 // 処理
                                                 NSDictionary *forecasts = responseObject[@"forecasts"][i];
                                                 [self createDataSoruceSubThread:forecasts];
                                                 // テーブルを更新
                                                 dispatch_async(mainQueue, ^{
                                                     // 終わった後の処理
                                                     [self.tableView reloadData];
                                                 });
                                             }
                                         });
                                         // メインスレッド処理
                                         dispatch_async(mainQueue, ^{
                                             for(int i=0; i<ThreeDaysForecastRequestNumber; i++) {
                                                 NSDictionary *forecasts = responseObject[@"forecasts"][i];
                                                 NSDictionary *description = responseObject[@"description"];
                                                 [self createDataSoruceMainThread:forecasts descriptionDictionary:description];
                                             }
                                         });
                                     } failure:^(NSURLSessionTask *operation, NSError *error) {
                                         // エラーの場合の処理
                                         NSLog(@"予報データの取得に失敗しました。");
                                     }
                                ];
                               
                           }];
    return threeDaysWeatherForecast;
}

- (UIAlertAction *)createTodayButton {
    // 当日の天気予報を出力するアクションを作成
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartActionTitleToday" value:nil table:@"Localizable"];
    UIAlertAction *todayWeatherForecast =
    [UIAlertAction actionWithTitle:titleText
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               // 並列処理用のスレッドを用意
                               dispatch_queue_t mainQueue = dispatch_get_main_queue();
                               dispatch_queue_t subQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                               // 格納用の配列用意
                               self.threeDaysDateList = [@[] mutableCopy];
                               self.threeDaysTelopList = [@[] mutableCopy];
                               self.threeDaysTextList = [@[] mutableCopy];
                               self.threeDaysIconImageUrlList = [@[] mutableCopy];
                               // URLからJSONデータを取得
                               NSString *url = apiUrl;
                               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                               [manager GET : url parameters : nil progress:nil
                                     success:^(NSURLSessionTask *task, id responseObject) {
                                         // サブスレッド処理
                                         dispatch_async(subQueue, ^{
                                             NSDictionary *forecasts = responseObject[@"forecasts"][TodayForecastApiNumber];
                                             [self createDataSoruceSubThread:forecasts];
                                             dispatch_async(mainQueue, ^{
                                                 [self.tableView reloadData];
                                             });
                                         });
                                         // メインスレッド処理
                                         dispatch_async(mainQueue, ^{
                                             NSDictionary *forecasts = responseObject[@"forecasts"][TodayForecastApiNumber];
                                             NSDictionary *description = responseObject[@"description"];
                                             [self createDataSoruceMainThread:forecasts descriptionDictionary:description];
                                         });
                                     } failure:^(NSURLSessionTask *operation, NSError *error) {
                                         // エラーの場合の処理
                                         NSLog(@"予報データの取得に失敗しました。");
                                     }
                                ];
                           }];
    return todayWeatherForecast;
}

- (UIAlertAction *)createTomorrowButton {
    // 翌日の天気予報を出力するアクションを作成
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartActionTitleTomorrow" value:nil table:@"Localizable"];
    UIAlertAction *tomorrowWeatherForecast =
    [UIAlertAction actionWithTitle:titleText
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               // 並列処理用のスレッドを用意
                               dispatch_queue_t mainQueue = dispatch_get_main_queue();
                               dispatch_queue_t subQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                               // 格納用の配列用意
                               self.threeDaysDateList = [@[] mutableCopy];
                               self.threeDaysTelopList = [@[] mutableCopy];
                               self.threeDaysTextList = [@[] mutableCopy];
                               self.threeDaysIconImageUrlList = [@[] mutableCopy];
                               // URLからJSONデータを取得
                               NSString *url = apiUrl;
                               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                               [manager GET : url parameters : nil progress:nil
                                     success:^(NSURLSessionTask *task, id responseObject) {
                                         // サブスレッド処理
                                         dispatch_async(subQueue, ^{
                                             NSDictionary *forecasts = responseObject[@"forecasts"][TomorrowForecastApiNumber];
                                             [self createDataSoruceSubThread:forecasts];
                                             dispatch_async(mainQueue, ^{
                                                 [self.tableView reloadData];
                                             });
                                         });
                                         // メインスレッド処理
                                         dispatch_async(mainQueue, ^{
                                             NSDictionary *forecasts = responseObject[@"forecasts"][TomorrowForecastApiNumber];
                                             NSDictionary *description = responseObject[@"description"];
                                             [self createDataSoruceMainThread:forecasts descriptionDictionary:description];
                                         });
                                     } failure:^(NSURLSessionTask *operation, NSError *error) {
                                         // エラーの場合の処理
                                         NSLog(@"予報データの取得に失敗しました。");
                                     }
                                ];
                           }];
    return tomorrowWeatherForecast;
}

- (UIAlertAction *)createAfterTomorrowButton {
    // 明後日の天気予報を出力するアクションを作成
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartActionTitleAfterTomorrow" value:nil table:@"Localizable"];
    UIAlertAction *afterTomorrowWeatherForecast =
    [UIAlertAction actionWithTitle:titleText
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               // 並列処理用のスレッドを用意
                               dispatch_queue_t mainQueue = dispatch_get_main_queue();
                               dispatch_queue_t subQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                               // 格納用の配列用意
                               self.threeDaysDateList = [@[] mutableCopy];
                               self.threeDaysTelopList = [@[] mutableCopy];
                               self.threeDaysTextList = [@[] mutableCopy];
                               self.threeDaysIconImageUrlList = [@[] mutableCopy];
                               // URLからJSONデータを取得
                               NSString *url = apiUrl;
                               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                               [manager GET : url parameters : nil progress:nil
                                     success:^(NSURLSessionTask *task, id responseObject) {
                                         // サブスレッド処理
                                         dispatch_async(subQueue, ^{
                                             NSDictionary *forecasts = responseObject[@"forecasts"][AfterTomorrowForecastApiNumber];
                                             [self createDataSoruceSubThread:forecasts];
                                             dispatch_async(mainQueue, ^{
                                                 [self.tableView reloadData];
                                             });
                                         });
                                         // メインスレッド処理
                                         dispatch_async(mainQueue, ^{
                                             NSDictionary *forecasts = responseObject[@"forecasts"][AfterTomorrowForecastApiNumber];
                                             NSDictionary *description = responseObject[@"description"];
                                             [self createDataSoruceMainThread:forecasts descriptionDictionary:description];
                                         });
                                     } failure:^(NSURLSessionTask *operation, NSError *error) {
                                         // エラーの場合の処理
                                         NSLog(@"予報データの取得に失敗しました。");
                                     }
                                ];
                           }];
    return afterTomorrowWeatherForecast;
}

- (UIAlertAction *)createCancelButton {
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartActionTitleCancel" value:nil table:@"Localizable"];
    // キャンセルアクションを生成
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:titleText
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"ボタン操作をキャンセルしました。");
                           }];
    return cancelAction;
}

// datasourceを非同期で作成（サブスレッド）
- (void)createDataSoruceSubThread:(NSDictionary *)forecastsDictionary {
    NSDictionary *image = forecastsDictionary[@"image"];
    NSData *imageData = [self createImageData:image[@"url"]];
    [self.threeDaysIconImageUrlList addObject:imageData];
}

// datasourceを非同期で作成（メインスレッド）
- (void)createDataSoruceMainThread:(NSDictionary *)forecastsDictionary descriptionDictionary:(NSDictionary *)descriptionDictionary {
    // 値を格納
    [self.threeDaysDateList addObject:forecastsDictionary[@"date"]];
    [self.threeDaysTelopList addObject:forecastsDictionary[@"telop"]];
    [self.threeDaysTextList addObject:descriptionDictionary[@"text"]];
    [self.tableView reloadData];
}

// NSString型データをNSData型に変換する
- (NSData *)createImageData:(NSString *)imageDataText {
    NSURL *imageUrl = [NSURL URLWithString:imageDataText];
    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
    return data;
}

// 天気予報出力ボタン押した時のアクション
- (IBAction)outputWeatherForecastButton:(id)sender {
    // アクションシートを出力
    [self presentViewController:self.alertController animated:YES completion:nil];
}

// セルの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.threeDaysDateList.count;
}

// セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeatherForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.dateLabel.text = self.threeDaysDateList[indexPath.row];
    cell.forecastLabel.text = self.threeDaysTelopList[indexPath.row];
    cell.introductionTextLabel.text = self.threeDaysTextList[indexPath.row];
    
    if (self.threeDaysIconImageUrlList.count > indexPath.row) {
        cell.iconImage.image = [[UIImage alloc]initWithData:self.threeDaysIconImageUrlList[indexPath.row]];
    } else {
        cell.iconImage.image = [UIImage imageNamed:notFoundImageName];
    }
    
    return cell;
}

@end
