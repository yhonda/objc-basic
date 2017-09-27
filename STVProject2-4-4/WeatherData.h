//
//  WeatherData.h
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/10.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Realm/Realm.h>

@interface WeatherData : RLMObject
// プロパティを定義
@property NSString  *Id;
@property NSString *days;
@property NSString *weather;
@property NSData *iconUrl;
// メソッドを定義
- (void)saveWeatherData:(NSString *)Id days:(NSString *)days weatherData:(NSString *)weather iconUrl:(NSData *)iconUrl;
- (void)updateWeatherDataSubThread:(NSString *)Id iconUrl:(NSData *)iconUrl;
- (void)updateWeatherDataMainThread:(NSString *)Id days:(NSString *)days weatherData:(NSString *)weather;

@end
