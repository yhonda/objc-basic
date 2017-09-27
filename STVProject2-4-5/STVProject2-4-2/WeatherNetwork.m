//
//  WeatherNetwork.m
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherNetwork.h"
#import "AFNetworking.h"

@interface WeatherNetwork ()

@end

// APIのURL用の定数を用意
static NSString *const apiUrl = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010";

@implementation WeatherNetwork

- (void)getWeatherData:(void (^)(NSDictionary *dictionary))block {
    NSString *url = apiUrl;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    [manager GET: url parameters: nil progress: nil
         success:^(NSURLSessionTask *task, id responseObject) {
             if (block) block(responseObject);
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             if (block) block(nil);
         }
     ];
}
@end
