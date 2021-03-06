//
//  BOChoiceTableViewCell.m
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "BOChoiceTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@implementation BOChoiceTableViewCell

- (void)setup {
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

- (NSString *)footerTitle {
	NSInteger currentOption = [self.setting.value integerValue];
	
	if (currentOption < self.footerTitles.count) {
		return self.footerTitles[currentOption];
	}
	
	return [super footerTitle];
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	if (self.accessoryType != UITableViewCellAccessoryDisclosureIndicator) {
		NSInteger currentOption = [self.setting.value integerValue];
		
		if (currentOption < self.options.count-1) {
			self.setting.value = @(currentOption+1);
		} else {
			self.setting.value = @0;
		}
	}
}

- (void)settingValueDidChange {
	self.detailTextLabel.text = self.options[[self.setting.value integerValue]];
}

@end
