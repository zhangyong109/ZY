//
//  ZYBlockViewController.h
//  轨迹动画
//
//  Created by ZY on 15/7/22.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYBlock2ViewController.h"

@interface ZYBlockViewController : UIViewController<NextViewControllerDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textLable;

@end
