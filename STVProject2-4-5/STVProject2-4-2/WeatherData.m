//
//  WeatherData.m
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/10.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherData.h"

@interface WeatherData ()
// プロパティを定義
@property NSString  *Id;
@property NSString *days;
@property NSString *weather;
@property NSData *iconUrl;
@end

@implementation WeatherData

// メソッドを定義
+ (NSString *)primaryKey {
    return @"Id";
}

- (void)saveWeatherData:(NSString *)Id days:(NSString *)days weatherData:(NSString *)weather iconUrl:(NSData *)iconUrl {
    WeatherData *weatherData = [[WeatherData alloc]init];
    weatherData.Id = Id;
    weatherData.days = days;
    weatherData.weather = weather;
    weatherData.iconUrl = iconUrl;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    // 追加コマンド
    [realm addObject:weatherData];
    [realm commitWriteTransaction];
}

- (NSData *)updateWeatherDataSubThread:(NSDictionary *)imageDictionary index:(int)index {
    // 画像URLデータをNSDataとしてrealmに保存
    NSData *imageData = [self createImageData:imageDictionary[@"url"]];
    NSString *indexId = [NSString stringWithFormat:@"%d",index];
    // realm
    self.Id = indexId;
    self.iconUrl = imageData;
    // 値をセットして追加、更新コマンドを実行
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    // 追加コマンド
    [WeatherData createOrUpdateInRealm:realm withValue:self];
    [realm commitWriteTransaction];
    // realmから値を取り出してNSDataとして返す
    RLMResults *results = [WeatherData objectsWhere:[NSString stringWithFormat:@"Id='%@'", indexId]];
    NSLog(@"%@", results);
    NSData *imageDataSource = results[0][@"iconUrl"];
    
    return imageDataSource;
}

- (NSArray *)updateWeatherDataMainThread:(NSDictionary *)forecastDictionary descriptionDictionary:(NSDictionary *)descriptionDictionary index:(int)index {

    // 保存するデータを取り出す
    NSString *indexId = [NSString stringWithFormat:@"%d",index];
        NSString *dateData = forecastDictionary[@"date"];
    NSString *telopData = forecastDictionary[@"telop"];
    // realmをインスタンス化
    self.Id = indexId;
    self.days = dateData;
    self.weather = telopData;
    // 値をセットして追加、更新コマンドを実行
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    // 追加コマンド
    [WeatherData createOrUpdateInRealm:realm withValue:self];
    [realm commitWriteTransaction];
    RLMResults *results = [WeatherData objectsWhere:[NSString stringWithFormat:@"Id='%@'", indexId]];
    NSArray *textDataSource = @[results[0][@"days"], results[0][@"weather"], descriptionDictionary[@"text"]];
    
    return textDataSource;
}

// NSString型データをNSData型に変換する
- (NSData *)createImageData:(NSString *)imageDataText {
    NSURL *imageUrl = [NSURL URLWithString:imageDataText];
    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
    return data;
}

@end
