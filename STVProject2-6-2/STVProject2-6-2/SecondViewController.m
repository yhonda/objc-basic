//
//  SecondViewController.m
//  STVProject2-6-2
//
//  Created by kawaharadai on 2017/09/21.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UILabel *schemeLabel;
@property (weak, nonatomic) UILabel *queryLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setParameterText];
}

-(void)setParameterText {
    NSString *firstDivideText = @"&";
    NSString *secondDivideText = @"=";
    int ajastIndex = 1;
    NSRange firstDividePoint = [self.receiveQuery rangeOfString:firstDivideText];
    NSString *captionText = [self.receiveQuery substringToIndex:firstDividePoint.location];
    NSString *commentText = [self.receiveQuery substringFromIndex:firstDividePoint.location+ajastIndex];
    
    NSRange secondDividePoint = [self.receiveQuery rangeOfString:secondDivideText];
    NSString *firstHalfCaptionText = [captionText substringToIndex:secondDividePoint.location];
    NSString *secondHalfCaptionText = [captionText substringFromIndex:secondDividePoint.location+ajastIndex];
    NSString *firstHalfCommentText = [commentText substringToIndex:secondDividePoint.location];
    NSString *secondHalfCommentText = [commentText substringFromIndex:secondDividePoint.location+ajastIndex];
    self.captionLabel.text = [NSString stringWithFormat:@"%@：%@", firstHalfCaptionText, secondHalfCaptionText];
    self.commentLabel.text = [NSString stringWithFormat:@"%@：%@", firstHalfCommentText, secondHalfCommentText];
    self.urlLabel.text = self.receiveUrl;
    self.schemeLabel.text = self.receiveScheme;
}

@end
