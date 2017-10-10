//
//  FolderListCell.h
//  TaskManagerApp
//
//  Created by kawaharadai on 2017/10/08.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FolderListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *folderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *haveTaskCountLabel;
+ (NSString *)folderListCellNibName;
+ (NSString *)folderListCellIdentifier;
@end
