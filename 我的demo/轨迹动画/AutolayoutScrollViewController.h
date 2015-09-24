//
//  AutolayoutScrollViewController.h
//  轨迹动画
//
//  Created by ZY on 15/9/24.
//  Copyright © 2015年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutolayoutScrollViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *boxView;

@end
