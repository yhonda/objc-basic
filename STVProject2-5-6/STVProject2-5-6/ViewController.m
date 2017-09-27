//
//  ViewController.m
//  STVProject2-5-6
//
//  Created by kawaharadai on 2017/09/18.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, retain) CLLocationManager *locationManager;
// 緯度
- (void)getLocationData;
- (void)outputLocationDataAction;
@end

static int const DeviceVersion = 8.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)getLocationData {
    // 取得可能かをチェック
    if ([CLLocationManager locationServicesEnabled]) {
        // 初回起動の場合、初期化を行う
        if (self.locationManager == nil) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            // iOS8以降の端末のみユーザー承認を表示
            if (UIDevice.currentDevice.systemVersion.floatValue >= DeviceVersion) {
                [self.locationManager requestWhenInUseAuthorization];
            }
        } else {
            // データの出力
            [self outputLocationDataAction];
        }
    } else {
        // CLLocationManagerが何らかの理由で使えない時
        NSLog(@"現在地情報の取得に失敗しました。");
    }
}

// 位置情報を出力するメソッド
- (void)outputLocationDataAction {
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    NSLog(@"現在地の緯度は（%f）、経度は（%f）",
          self.locationManager.location.coordinate.latitude,
          self.locationManager.location.coordinate.longitude);
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}

// ボタンアクション
- (IBAction)outputLocation:(id)sender {
    [self getLocationData];
}

// 初回、許可アクション後の処理
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self outputLocationDataAction];
    }
}

@end
