//
//  WeatherData.h
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/10.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Realm/Realm.h>

@interface WeatherData : RLMObject
// メソッドを定義
- (void)saveWeatherData:(NSString *)Id days:(NSString *)days weatherData:(NSString *)weather iconUrl:(NSData *)iconUrl;
- (NSData *)updateWeatherDataSubThread:(NSDictionary *)imageDictionary index:(int)index;
- (NSArray *)updateWeatherDataMainThread:(NSDictionary *)forecastDictionary descriptionDictionary:(NSDictionary *)descriptionDictionary index:(int)index;

@end
