//
//  BOTableViewCell.h
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOTableViewCell : UITableViewCell

/// The NSUserDefaults key associated with the cell.
@property (nonatomic, strong) IBInspectable NSString *key;

/// The main text color for the cell.
@property (nonatomic, strong) IBInspectable UIColor *mainColor;

/// The main text font for the cell.
@property (nonatomic, strong) UIFont *mainFont; // Apple pls rdar://19973159

/// The secondary or detail text color for the cell.
@property (nonatomic, strong) IBInspectable UIColor *secondaryColor;

/// The secondary or detail text font for the cell.
@property (nonatomic, strong) UIFont *secondaryFont;

/// The color for the selected state of the cell.
@property (nonatomic, strong) IBInspectable UIColor *selectedColor;

/// The default footer title for the cell.
@property (nonatomic, strong) IBInspectable NSString *defaultFooterTitle;

@end
