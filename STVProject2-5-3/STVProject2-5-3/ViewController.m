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
@property (strong, nonatomic) NSData *getImageData;
@property (strong, nonatomic) UIImage *getImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"imageData"] != nil) {
        NSLog(@"画像ロード完了");
        self.getImageData = [defaults objectForKey:@"imageData"];
        self.getImage = [[UIImage alloc] initWithData:self.getImageData];
        self.imageView.image = self.getImage;
    }
}
-(void)getPictureImage:(UIImage *)image {
    
}


@end
