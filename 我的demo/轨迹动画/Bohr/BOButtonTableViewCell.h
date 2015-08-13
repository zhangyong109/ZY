//
//  BOButtonTableViewCell.h
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOButtonTableViewCell : BOTableViewCell

/// The target of the cell action.
@property (nonatomic) id target;

/// The action defined by the cell, triggered when it's tapped.
@property (nonatomic) SEL action;

/// Sets both the target and action for the cell to be performed.
- (void)setTarget:(id)target action:(SEL)action;

@end
