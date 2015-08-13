//
//  BOTimeTableViewCell.h
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOTimeTableViewCell : BOTableViewCell <UIPickerViewDataSource, UIPickerViewDelegate>

/// The minute interval showed on the time picker view.
@property (nonatomic) IBInspectable NSInteger minuteInterval;

@end
