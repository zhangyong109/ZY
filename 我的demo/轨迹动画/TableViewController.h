//
//  TableViewController.h
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "Bohr.h"

@interface TableViewController : BOTableViewController

@property (weak, nonatomic) IBOutlet BOTextTableViewCell *textCell;
@property (weak, nonatomic) IBOutlet BOChoiceTableViewCell *choiceCell;
@property (weak, nonatomic) IBOutlet BOChoiceTableViewCell *choiceDisclosureCell;
@property (weak, nonatomic) IBOutlet BOButtonTableViewCell *buttonCell;

@end

