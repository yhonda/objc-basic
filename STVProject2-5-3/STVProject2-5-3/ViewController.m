//
//  ViewController.m
//  STVProject2-5-3
//
//  Created by kawaharadai on 2017/09/09.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 保存状態を初期化しておく
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    [defaults setObject:nil forKey:@"imageData"];
    [defaults synchronize];
}

// 保存した画像があればメイン画像に設定する
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    if ([defaults objectForKey:@"imageData"] != nil) {
        NSData *getImageData = [defaults objectForKey:@"imageData"];
        UIImage *getImage = [[UIImage alloc] initWithData:getImageData];
        self.imageView.image = getImage;
    }
}

- (IBAction)presentCameraViewController:(id)sender {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    // 遷移先のViewControllerをインスタンス化
    CameraViewController *cameraViewController = [secondStoryBoard instantiateInitialViewController];
    // 遷移実行
    [self presentViewController: cameraViewController animated:YES completion: nil];
}
@end
