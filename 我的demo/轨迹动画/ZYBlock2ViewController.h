//
//  ZYBlock2ViewController.h
//  轨迹动画
//
//  Created by ZY on 15/7/22.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NextViewControllerDelegate <NSObject>
- (void)passTextValue:(NSString *)tfText;
@end

@interface ZYBlock2ViewController : UIViewController

@property(nonatomic,weak) id<NextViewControllerDelegate>delegate;
@property (nonatomic, copy) void (^NextViewControllerBlock)(NSString *tfText);//copy
@end
