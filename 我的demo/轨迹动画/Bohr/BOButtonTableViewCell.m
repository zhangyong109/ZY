//
//  BOButtonTableViewCell.m
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "BOButtonTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@implementation BOButtonTableViewCell

- (void)setup {
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
	self.textLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	if ([self.target respondsToSelector:self.action]) {
		[self.target performSelector:self.action];
	}
}

- (void)setTarget:(id)target action:(SEL)action {
	self.target = target;
	self.action = action;
}

@end
