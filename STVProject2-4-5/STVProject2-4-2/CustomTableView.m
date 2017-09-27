//
//  CustomTableView.m
//  STVProject2-4-2
//
//  Created by kawaharadai on 2017/09/21.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "CustomTableView.h"

@implementation CustomTableView


- (void)setup {
    
}

// セルの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

// セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
   cell.textLabel.text = @"ddddd";
    
    return cell;
}

@end
