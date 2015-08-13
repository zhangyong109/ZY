//
//  BOChoiceTableViewCell.h
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOChoiceTableViewCell : BOTableViewCell

/// An array defining (in short) all the options availables on the cell.
@property (nonatomic, strong) NSArray *options;

/// An array defining all the footer titles for each option assigned to the cell.
@property (nonatomic, strong) IBInspectable NSArray *footerTitles;

@end
