//
//  ViewController.m
//  STVProject2-5-7
//
//  Created by kawaharadai on 2017/09/18.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) CLLocationManager *locationManager;
-(void)setMyPosition;
-(void)addPinAction;
@end

static CLLocationDegrees const stvPositionLatitude = 35.623654;
static CLLocationDegrees const stvPositionLongitude = 139.724858;
static CLLocationDegrees const myPositionSpan = 0.1;
static CLLocationDegrees const stvPositionSpan = 0.01;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMyPosition];
}

-(void)setMyPosition {
    //ユーザーによる位置情報サービスの許可状態をチェック
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        //ユーザーはこのアプリによる位置情報サービスの利用を許可していない、または「設定」で無効にしている
        NSLog(@"位置情報へのアクセスが許可されていません。");
    }
    else {
        //位置情報サービスを利用できる、またはまだ利用許可要求を行っていない状態
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        //利用許可要求をまだ行っていない状態であれば要求
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
            //許可の要求
            [self.locationManager requestWhenInUseAuthorization];
        }
        //現在地取得
        [self.locationManager startUpdatingLocation];
        // 縮尺を指定
        MKCoordinateRegion myLocation = self.mapView.region;
        myLocation.center = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
        myLocation.span.latitudeDelta = myPositionSpan;
        myLocation.span.longitudeDelta = myPositionSpan;
        [self.mapView setRegion:myLocation animated:NO];
        [self.locationManager stopUpdatingLocation];
        
    }
}

-(void)addPinAction {
    // ピンを全て削除
    [self.mapView removeAnnotations: self.mapView.annotations];
    
    // ピン内容作成
    MKPointAnnotation *targetPinAnnnotation = [[MKPointAnnotation alloc]init];
    NSString *title = [NSBundle.mainBundle localizedStringForKey:@"pinAnnnotationTitle" value:nil table:@"Localizable"];
    NSString *subTitle = [NSBundle.mainBundle localizedStringForKey:@"pinAnnnotationSubTitle" value:nil table:@"Localizable"];
    
    targetPinAnnnotation.title = title;
    targetPinAnnnotation.subtitle = subTitle;
    targetPinAnnnotation.coordinate = CLLocationCoordinate2DMake(stvPositionLatitude, stvPositionLongitude);
    
    // 縮尺を指定
    MKCoordinateRegion stvPoint = self.mapView.region;
    stvPoint.center = CLLocationCoordinate2DMake(stvPositionLatitude, stvPositionLongitude);
    stvPoint.span.latitudeDelta = stvPositionSpan;
    stvPoint.span.longitudeDelta = stvPositionSpan;
    [self.mapView setRegion:stvPoint animated:NO];
    
    // ピンを追加
    [self.mapView addAnnotation:targetPinAnnnotation];
}

- (IBAction)addPin:(id)sender {
    [self addPinAction];
}

@end
