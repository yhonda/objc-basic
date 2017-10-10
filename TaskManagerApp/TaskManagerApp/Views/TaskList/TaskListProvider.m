//
//  TaskListProvider.m
//  TaskManagerApp
//
//  Created by kawaharadai on 2017/10/08.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "TaskListProvider.h"
#import "TaskListCell.h"
#import "Database.h"

@interface TaskListProvider ()

@end

@implementation TaskListProvider

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.taskListDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskListCell *cell = [tableView dequeueReusableCellWithIdentifier:[TaskListCell taskListCellIdentifier] forIndexPath:indexPath];
    
    cell.taskNameLabel.text = self.taskListDataList[indexPath.row].taskName;
    cell.updateTaskDateLabel.text = [self chengeDateData:self.taskListDataList[indexPath.row].updateTaskDate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Database *database = [[Database alloc] init];
        [database deleteTaskId:self.taskListDataList[indexPath.row] folderData:self.folderData index:indexPath];
        
        if ([self.delegate respondsToSelector:@selector(deleteTaskListCell:)]) {
            [self.delegate deleteTaskListCell:indexPath];
        }
    }
}

- (NSString *)chengeDateData:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateText = [formatter stringFromDate:date];
    return dateText;
}

@end
