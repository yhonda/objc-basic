//
//  WeatherData.m
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/10.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherData.h"

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
    NSLog(@"DB内データの作成完了");
}

- (void)updateWeatherData:(NSString *)Id days:(NSString *)days weatherData:(NSString *)weather iconUrl:(NSData *)iconUrl {
    
    WeatherData *weatherData = [[WeatherData alloc]init];
    weatherData.Id = Id;
    weatherData.days = days;
    weatherData.weather = weather;
    weatherData.iconUrl = iconUrl;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    // 追加コマンド
    [WeatherData createOrUpdateInRealm:realm withValue:weatherData];
    [realm commitWriteTransaction];
    NSLog(@"DB内データの更新完了");
}

@end
