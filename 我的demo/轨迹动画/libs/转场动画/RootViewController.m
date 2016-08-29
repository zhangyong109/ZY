//
//  RootViewController.m
//  ZY
//
//  Created by ZY on 15/7/30.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "RootViewController.h"
#import "GlobalValue.h"
#import "UIButton+inits.h"
#import "SecondViewController.h"
#import "PushAnimator.h"

@interface RootViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation RootViewController

#pragma mark -
- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setup];
    
    [super.navigationController setNavigationBarHidden:NO animated:NO];

    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.imageView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // 关闭手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.navigationController.delegate = self;
    
    self.imageView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.imageView.hidden = YES;
    self.navigationController.delegate = nil;//不设为 nil 返回后再进会崩
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    // 激活手势
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
#pragma mark -
- (BOOL)prefersStatusBarHidden{
    return NO; // 返回NO表示要显示，返回YES将hiden
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}
- (void)setup {
    
    // 获取手势代理
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)initViews {

    self.imageView = [[UIImageView alloc] initWithFrame:IMAGE_FRAME_NORMAL
                                                  image:SHOW_IMAGE];
    [self.view addSubview:self.imageView];
    
    
    // 按钮
    UIButton *pushButton = [UIButton createButtonWithFrame:CGRectMake(Width - 100, Height - 40, 90, 30)
                                                buttonType:BUTTON_NORMAL
                                                     title:@"Push"
                                                       tag:0
                                                    target:self
                                                    action:@selector(buttonsEvent:)];
    [self.view addSubview:pushButton];
}

- (void)buttonsEvent:(UIButton *)button {
    
    [self.navigationController pushViewController:[SecondViewController new]
                                         animated:YES];
}

#pragma mark - 动画代理
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[SecondViewController class]]) {
        
        PushAnimator *transition = [[PushAnimator alloc] init];
        return transition;
        
    }else{
        
        return nil;
    }
}


@end
