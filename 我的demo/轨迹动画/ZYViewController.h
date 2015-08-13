//
//  ZYViewController.h
//  轨迹动画
//
//  Created by ZY on 15/7/22.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYObject.h"
#import "PictureBrowseViewController.h"
#import "UIViewController+PanGesturePop.h"

@interface ZYViewController : UIViewController<UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property (copy, nonatomic)  NSString *str1;

-(void)www;
-(void)www1;
-(void)www2;
-(void)www3;

@end
