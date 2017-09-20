//
//  ViewController.m
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/05.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"
#import "WeatherData.h"
#import "WeatherForecastCell.h"
#import "WeatherNetwork.h"

@interface ViewController ()  <UITableViewDelegate,UITableViewDataSource>
// プロパティを定義
@property (nonatomic, strong) UIAlertController *alertController;

@end

// APIに日時指定をリクエストする用の定数
static int const TodayForecastApiNumber = 0;
static int const TomorrowForecastApiNumber = 1;
static int const AfterTomorrowForecastApiNumber = 2;
static int const AllDaysDataCountReturnApi = 3;
// 画像読み込み中に表示する画像名
static NSString *const notFoundImageName = @"noImageIcon";
// userDefaultsで初回起動を確認する際のキー値
static NSString *const CheckFirstTimeRunKey = @"firstRun";
// セルの基準値の高さ
static CGFloat CellEstimatedRowHeight = 100.0;

// 配列要素指定用
typedef NS_ENUM(NSUInteger, saveData) {
    dateDataValue,
    weatherDataValue,
    textDataValue,
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初回起動かを確認
    if ([self CheckRunfirstTime]) {
        NSLog(@"初回起動です。");
        WeatherData *weatherData = [[WeatherData alloc]init];
        [weatherData saveWeatherData:@"0" days:@"" weatherData:@"" iconUrl:nil];
    }
    [self setAlertController];
    [self setTableView];
}

// 初回起動を確認するメソッド
- (BOOL)CheckRunfirstTime {
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    // 起動確認用の値が設定されていれば、NOを返し、されていなければ、起動証明として値を設定
    if ([userDefaults objectForKey:CheckFirstTimeRunKey]) {
        return NO;
    }
    [userDefaults setBool:YES forKey:CheckFirstTimeRunKey];
    [userDefaults synchronize];
    return YES;
}

// テーブルビューを設定
- (void)setTableView {
    UINib *nib = [UINib nibWithNibName:@"WeatherForecastCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = CellEstimatedRowHeight;
}

//// アラートコントローラーとアクションシートを用意
- (void)setAlertController {
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartTitle" value:nil table:@"Localizable"];
    NSString *messageText = [NSBundle.mainBundle localizedStringForKey:@"aleartMesaage" value:nil table:@"Localizable"];
    self.alertController =
    [UIAlertController alertControllerWithTitle:titleText
                                        message:messageText
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    // コントローラにアクションを追加
    [self.alertController addAction:[self createAllSelectButton]];
    [self.alertController addAction:[self createTodayButton]];
    [self.alertController addAction:[self createTomorrowButton]];
    [self.alertController addAction:[self createAfterTomorrowButton]];
    [self.alertController addAction:[self createCancelButton]];
}

- (UIAlertAction *)createAllSelectButton {
    // ３日間分の天気予報を出力するアクションを作成
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
                               
                               // サブスレッド処理（画像データリストを作成、保存、更新を繰り返す）
                               WeatherNetwork *weatherNetwork = [[WeatherNetwork alloc]init];
                               [weatherNetwork getWeatherData:^(NSDictionary *weatherDataDictionary) {
                                   if (weatherDataDictionary[@"forecasts"] && weatherDataDictionary[@"description"]) {
                                       dispatch_async(subQueue, ^{
                                           // 通知用変数
                                           int countIndexSub = 0;
                                           // realem機能用クラスを用意
                                           WeatherData *weatherData = [[WeatherData alloc]init];
                                           for (NSDictionary *forecasts in weatherDataDictionary[@"forecasts"]) {
                                               NSData *imageDataSource = [weatherData updateWeatherDataSubThread:forecasts index:countIndexSub];
                                               // realmに投げて保存して、受け取る
                                               [self.threeDaysIconImageUrlList addObject:imageDataSource];
                                               countIndexSub ++;
                                               
                                               dispatch_async(mainQueue, ^{
                                                   // 終わった後の処理
                                                   [self.tableView reloadData];
                                               });
                                           }
                                       });
                                       // メインスレッド処理（テキストデータの作成、保存、更新を繰り返す）
                                       dispatch_async(mainQueue, ^{
                                           int countIndexMain = 0;
                                           
                                           WeatherData *weatherData = [[WeatherData alloc]init];
                                           NSDictionary *description = weatherDataDictionary[@"description"];
                                           
                                           for (NSDictionary *forecasts in weatherDataDictionary[@"forecasts"]) {
                                               // realmに投げて保存して、受け取った後にリロードまで
                                               NSArray *textDataSource = [weatherData updateWeatherDataMainThread:forecasts descriptionDictionary:description index:countIndexMain];
                                               // 値を格納
                                               [self.threeDaysDateList addObject:textDataSource[dateDataValue]];
                                               [self.threeDaysTelopList addObject:textDataSource[weatherDataValue]];
                                               [self.threeDaysTextList addObject:textDataSource[textDataValue]];
                                               // 通知用カウントを増やす
                                               countIndexMain ++;
                                               // リロード
                                               [self.tableView reloadData];
                                           }
                                       });
                                   } else {
                                       // 失敗時の処理
                                       NSLog(@"データの取得に失敗しました。");
                                   }
                               }];
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
                               // 並列処理用のスレッドを用意
                               dispatch_queue_t mainQueue = dispatch_get_main_queue();
                               dispatch_queue_t subQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                               // 格納用の配列用意
                               self.threeDaysDateList = [@[] mutableCopy];
                               self.threeDaysTelopList = [@[] mutableCopy];
                               self.threeDaysTextList = [@[] mutableCopy];
                               self.threeDaysIconImageUrlList = [@[] mutableCopy];
                               
                               // サブスレッド処理（画像データリストを作成、保存、更新を繰り返す）
                               WeatherNetwork *weatherNetwork = [[WeatherNetwork alloc]init];
                               [weatherNetwork getWeatherData:^(NSDictionary *weatherDataDictionary) {
                                   if (weatherDataDictionary[@"forecasts"] && weatherDataDictionary[@"description"]) {
                                       // 成功時の処理
                                       dispatch_async(subQueue, ^{
                                           // realem機能用クラスを用意
                                           WeatherData *weatherData = [[WeatherData alloc]init];
                                           NSDictionary *forecasts = weatherDataDictionary[@"forecasts"][TodayForecastApiNumber];
                                           
                                           NSData *imageDataSource = [weatherData updateWeatherDataSubThread:forecasts index:TodayForecastApiNumber];
                                           // realmに投げて保存して、受け取る
                                           [self.threeDaysIconImageUrlList addObject:imageDataSource];
                                           
                                           dispatch_async(mainQueue, ^{
                                               // 終わった後の処理
                                               [self.tableView reloadData];
                                           });
                                       });
                                       // メインスレッド処理（テキストデータの作成、保存、更新を繰り返す）
                                       dispatch_async(mainQueue, ^{
                                           // realem機能用クラスを用意
                                           WeatherData *weatherData = [[WeatherData alloc]init];
                                           NSDictionary *forecasts = weatherDataDictionary[@"forecasts"][TodayForecastApiNumber];
                                           NSDictionary *description = weatherDataDictionary[@"description"];
                                           // realmに投げて保存して、受け取った後にリロードまで
                                           NSArray *textDataSource = [weatherData updateWeatherDataMainThread:forecasts descriptionDictionary:description index:TodayForecastApiNumber];
                                           // 値を格納
                                           [self.threeDaysDateList addObject:textDataSource[dateDataValue]];
                                           [self.threeDaysTelopList addObject:textDataSource[weatherDataValue]];
                                           [self.threeDaysTextList addObject:textDataSource[textDataValue]];
                                           // リロード
                                           [self.tableView reloadData];
                                       });
                                   } else {
                                       // 失敗時の処理
                                       NSLog(@"データの取得に失敗しました。");
                                   }
                               }];
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
                               // 並列処理用のスレッドを用意
                               dispatch_queue_t mainQueue = dispatch_get_main_queue();
                               dispatch_queue_t subQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                               // 格納用の配列用意
                               self.threeDaysDateList = [@[] mutableCopy];
                               self.threeDaysTelopList = [@[] mutableCopy];
                               self.threeDaysTextList = [@[] mutableCopy];
                               self.threeDaysIconImageUrlList = [@[] mutableCopy];
                               
                               // サブスレッド処理（画像データリストを作成、保存、更新を繰り返す）
                               WeatherNetwork *weatherNetwork = [[WeatherNetwork alloc]init];
                               [weatherNetwork getWeatherData:^(NSDictionary *weatherDataDictionary) {
                                   if (weatherDataDictionary[@"forecasts"] && weatherDataDictionary[@"description"]) {
                                       // 成功時の処理
                                       dispatch_async(subQueue, ^{
                                           // realem機能用クラスを用意
                                           WeatherData *weatherData = [[WeatherData alloc]init];
                                           NSDictionary *forecasts = weatherDataDictionary[@"forecasts"][TomorrowForecastApiNumber];
                                           
                                           NSData *imageDataSource = [weatherData updateWeatherDataSubThread:forecasts index:TomorrowForecastApiNumber];
                                           // realmに投げて保存して、受け取る
                                           [self.threeDaysIconImageUrlList addObject:imageDataSource];
                                           
                                           dispatch_async(mainQueue, ^{
                                               // 終わった後の処理
                                               [self.tableView reloadData];
                                           });
                                       });
                                       // メインスレッド処理（テキストデータの作成、保存、更新を繰り返す）
                                       dispatch_async(mainQueue, ^{
                                           // realem機能用クラスを用意
                                           WeatherData *weatherData = [[WeatherData alloc]init];
                                           NSDictionary *forecasts = weatherDataDictionary[@"forecasts"][TomorrowForecastApiNumber];
                                           NSDictionary *description = weatherDataDictionary[@"description"];
                                           // realmに投げて保存して、受け取った後にリロードまで
                                           NSArray *textDataSource = [weatherData updateWeatherDataMainThread:forecasts descriptionDictionary:description index:TodayForecastApiNumber];
                                           // 値を格納
                                           [self.threeDaysDateList addObject:textDataSource[dateDataValue]];
                                           [self.threeDaysTelopList addObject:textDataSource[weatherDataValue]];
                                           [self.threeDaysTextList addObject:textDataSource[textDataValue]];
                                           // リロード
                                           [self.tableView reloadData];
                                       });
                                   } else {
                                       // 失敗時の処理
                                       NSLog(@"データの取得に失敗しました。");
                                   }
                               }];
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
                               // 並列処理用のスレッドを用意
                               dispatch_queue_t mainQueue = dispatch_get_main_queue();
                               dispatch_queue_t subQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                               // 格納用の配列用意
                               self.threeDaysDateList = [@[] mutableCopy];
                               self.threeDaysTelopList = [@[] mutableCopy];
                               self.threeDaysTextList = [@[] mutableCopy];
                               self.threeDaysIconImageUrlList = [@[] mutableCopy];
                               
                               // サブスレッド処理（画像データリストを作成、保存、更新を繰り返す）
                               WeatherNetwork *weatherNetwork = [[WeatherNetwork alloc]init];
                               [weatherNetwork getWeatherData:^(NSDictionary *weatherDataDictionary) {
                                   if (weatherDataDictionary[@"forecasts"] && weatherDataDictionary[@"description"]) {
                                       // 成功時の処理
                                       NSArray *checkInfomationList = weatherDataDictionary[@"forecasts"];
                                       if (checkInfomationList.count == AllDaysDataCountReturnApi) {
                                           dispatch_async(subQueue, ^{
                                               // realem機能用クラスを用意
                                               WeatherData *weatherData = [[WeatherData alloc]init];
                                               NSDictionary *forecasts = weatherDataDictionary[@"forecasts"][AfterTomorrowForecastApiNumber];
                                               
                                               NSData *imageDataSource = [weatherData updateWeatherDataSubThread:forecasts index:AfterTomorrowForecastApiNumber];
                                               // realmに投げて保存して、受け取る
                                               [self.threeDaysIconImageUrlList addObject:imageDataSource];
                                               
                                               dispatch_async(mainQueue, ^{
                                                   // 終わった後の処理
                                                   [self.tableView reloadData];
                                               });
                                           });
                                           // メインスレッド処理（テキストデータの作成、保存、更新を繰り返す）
                                           dispatch_async(mainQueue, ^{
                                               // realem機能用クラスを用意
                                               WeatherData *weatherData = [[WeatherData alloc]init];
                                               NSDictionary *forecasts = weatherDataDictionary[@"forecasts"][AfterTomorrowForecastApiNumber];
                                               NSDictionary *description = weatherDataDictionary[@"description"];
                                               // realmに投げて保存して、受け取った後にリロードまで
                                               NSArray *textDataSource = [weatherData updateWeatherDataMainThread:forecasts descriptionDictionary:description index:AfterTomorrowForecastApiNumber];
                                               // 値を格納
                                               [self.threeDaysDateList addObject:textDataSource[dateDataValue]];
                                               [self.threeDaysTelopList addObject:textDataSource[weatherDataValue]];
                                               [self.threeDaysTextList addObject:textDataSource[textDataValue]];
                                               // リロード
                                               [self.tableView reloadData];
                                           });
                                       } else {
                                           NSLog(@"明後日の予報データはまだ存在していません。");
                                       }
                                   } else {
                                       // 失敗時の処理
                                       NSLog(@"データの取得に失敗しました。");
                                   }
                               }];
                           }];
    return afterTomorrowWeatherForecast;
}

- (UIAlertAction *)createCancelButton {
    // キャンセルアクションを生成
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartActionTitleCancel" value:nil table:@"Localizable"];
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:titleText
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                               NSLog(@"ボタン操作をキャンセルしました。");
                           }];
    return cancelAction;
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
