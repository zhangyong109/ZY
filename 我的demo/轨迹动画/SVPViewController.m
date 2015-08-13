//
//  SVPViewController.m
//  轨迹动画
//
//  Created by ZY on 15/7/28.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "SVPViewController.h"
#import "SVProgressHUD.h"

@interface SVPViewController ()

@end

@implementation SVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Notification Methods Sample

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
}

- (void)handleNotification:(NSNotification *)notif
{
    NSLog(@"Notification recieved: %@", notif.name);
    NSLog(@"Status user info key: %@", [notif.userInfo objectForKey:SVProgressHUDStatusUserInfoKey]);
}


#pragma mark - Show Methods Sample

- (void)show {
    [SVProgressHUD show];
}

- (void)showWithStatus {
    [SVProgressHUD showWithStatus:@"Doing Stuff"];
}

static float progress = 0.0f;

- (IBAction)showWithProgress:(id)sender {
    progress = 0.0f;
    [SVProgressHUD showProgress:0 status:@"Loading"];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
}

- (void)increaseProgress {
    progress+=0.1f;
    [SVProgressHUD showProgress:progress status:@"Loading"];
    
    if(progress < 1.0f)
        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
    else
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
}


#pragma mark - Dismiss Methods Sample

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (IBAction)dismissInfo{
    [SVProgressHUD showInfoWithStatus:@"Useful Information."];
}

- (void)dismissSuccess {
    [SVProgressHUD showSuccessWithStatus:@"Great Success!"];
}

- (void)dismissError {
    [SVProgressHUD showErrorWithStatus:@"Failed with Error"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
