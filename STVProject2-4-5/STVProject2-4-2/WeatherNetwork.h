//
//  WeatherNetwork.h
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/20.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherNetwork : NSObject
- (void)getWeatherData:(void (^)(NSDictionary *dictionary))block;
@end
