//
//  WeatherForecastCell.h
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/16.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherForecastCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *forecastLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
