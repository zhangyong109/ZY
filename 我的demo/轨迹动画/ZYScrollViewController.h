//
//  ZYScrollViewController.h
//  ZYScrollViewController
//
//  Created by ZY on 15/9/24.
//  Copyright © 2015年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYScrollViewController : UIViewController

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UILabel *bottomLabel;
@property (strong, nonatomic) UIView *boxView;

@end
