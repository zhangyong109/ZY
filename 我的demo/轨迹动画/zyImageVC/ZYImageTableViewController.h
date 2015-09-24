//
//  ZYImageTableViewController.h
//  轨迹动画
//
//  Created by ZY on 15/9/7.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYImageTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <NSDictionary+Accessors.h>
#import "UINavigationBar+Awesome.h"

#define NAVBAR_CHANGE_POINT 50


typedef NS_ENUM(NSUInteger, TableViewSlidingDirection) {
    TableViewSlidingDirectionUpward = 1,
    TableViewSlidingDirectionDown   = 2,

};


/**
 *  实现延时加载
 */
@interface ZYImageTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@property (copy  , nonatomic) NSArray *data;
@property (strong, nonatomic) NSValue *targetRect;
@end
