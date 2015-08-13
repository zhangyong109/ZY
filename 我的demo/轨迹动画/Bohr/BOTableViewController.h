//
//  BOTableViewController.h
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOTableViewController : UITableViewController

/// The text color for all the headers in the table view.
@property (nonatomic, strong) IBInspectable UIColor *headerTitlesColor;

/// The text font for all the headers in the table view.
@property (nonatomic, strong) UIFont *headerTitlesFont;

/// The text color for all the footers in the table view.
@property (nonatomic, strong) IBInspectable UIColor *footerTitlesColor;

/// The text font for all the footers in the table view.
@property (nonatomic, strong) UIFont *footerTitlesFont;

/// The setup method for the controller.
- (void)setup;

@end
