//
//  BOOptionTableViewCell.m
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "BOOptionTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@implementation BOOptionTableViewCell

- (void)setup {
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	NSInteger optionIndex = [viewController.tableView indexPathForCell:self].row;
	self.setting.value = @(optionIndex);
}

- (void)settingValueDidChange {
	NSInteger optionIndex = [self.setting.value integerValue];
	
    if (optionIndex == self.indexPath.row) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
