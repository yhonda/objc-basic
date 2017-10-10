//
//  TaskListCell.m
//  TaskManagerApp
//
//  Created by kawaharadai on 2017/10/08.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "TaskListCell.h"

@interface TaskListCell ()
@end

NSString *const taskListCellNibName = @"TaskListCell";
NSString *const taskListCellIdentifier = @"TaskListCell";

@implementation TaskListCell

+ (NSString *)taskListCellNibName {
    return taskListCellNibName;
}
+ (NSString *)taskListCellIdentifier {
    return taskListCellIdentifier;
}

@end
