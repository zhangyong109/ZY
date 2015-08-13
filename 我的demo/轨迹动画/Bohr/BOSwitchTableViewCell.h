//
//  BOSwitchTableViewCell.h
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOSwitchTableViewCell : BOTableViewCell

/// The switch on the cell.
@property (nonatomic, strong) UISwitch *toggleSwitch;

/// The footer title when the toggle switch is on.
@property (nonatomic, strong) IBInspectable NSString *onFooterTitle;

/// The footer title when the toggle switch is off.
@property (nonatomic, strong) IBInspectable NSString *offFooterTitle;

@end
