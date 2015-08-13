//
//  BOTableViewCell+Subclass.h
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "BOTableViewCell.h"

#import "BOTableViewController.h"
#import "BOSetting.h"

@interface BOTableViewCell ()

/// The current index path of the cell relative to its table view.
@property (nonatomic, strong) NSIndexPath *indexPath;

/// The setting object which the cell represents.
@property (nonatomic, strong) BOSetting *setting;

/// The setup method for the cell, where you may set up all the views and constraints necessary for the cell to work.
- (void)setup;

/// The method in charge of updating the appearance of the main cell view components, through properties as mainColor, mainFont, secondaryColor, secondaryFont.
- (void)updateAppearance;

/// You may return the height for the cell to be expanded when tapped.
- (CGFloat)expansionHeight;

/// You may return the footer text for the cell to be set on its section.
- (NSString *)footerTitle;

/// This method gets called whenever a cell gets selected, passing its parent view controller as an argument.
- (void)wasSelectedFromViewController:(BOTableViewController *)viewController;

/// This method gets called when the cell setting value gets changed externally, so that such change can be represented on the cell.
- (void)settingValueDidChange;

@end
