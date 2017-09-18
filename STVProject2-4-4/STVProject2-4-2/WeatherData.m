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
}

- (void)updateWeatherDataSubThread:(NSString *)Id iconUrl:(NSData *)iconUrl {
    WeatherData *weatherData = [[WeatherData alloc]init];
    weatherData.Id = Id;
    weatherData.iconUrl = iconUrl;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    // 追加コマンド
    [WeatherData createOrUpdateInRealm:realm withValue:weatherData];
    [realm commitWriteTransaction];
}

- (void)updateWeatherDataMainThread:(NSString *)Id days:(NSString *)days weatherData:(NSString *)weather {
    WeatherData *weatherData = [[WeatherData alloc]init];
    weatherData.Id = Id;
    weatherData.days = days;
    weatherData.weather = weather;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    // 追加コマンド
    [WeatherData createOrUpdateInRealm:realm withValue:weatherData];
    [realm commitWriteTransaction];
}
@end
