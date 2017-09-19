//
//  ViewController.m
//  STVProject2-1-18
//
//  Created by kawaharadai on 2017/08/28.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)pushSecondViewController:(id)sender {
    // 遷移先のストーリーボードをインスタンス化
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"SecondViewController" bundle:nil];
    // 遷移先のViewControllerをインスタンス化
    SecondViewController *secondViewController = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    // 遷移を実行
    [self.navigationController pushViewController:secondViewController animated:YES];
}

@end
