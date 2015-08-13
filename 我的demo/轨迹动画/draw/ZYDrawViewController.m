//
//  ZYDrawViewController.m
//  轨迹动画
//
//  Created by ZY on 15/8/7.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ZYDrawViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ZYDrawViewController () <UIActionSheetDelegate> {
    IBOutlet DrawView *drawingView;
}

- (IBAction)loadArchived:(id)sender;
- (IBAction)saveDrawing:(id)sender;
- (IBAction)animateDrawing:(id)sender;
- (IBAction)signatureMode:(id)sender;
@end

@implementation ZYDrawViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    self.navigationItem.title = @"画吧";
    UIBarButtonItem *animateButton = [[UIBarButtonItem alloc] initWithTitle:@"清理" style:UIBarButtonItemStylePlain target:drawingView action:@selector(clearDrawing)];
    animateButton.tintColor = [UIColor magentaColor];
//    UIBarButtonItem *archivedButton = [[UIBarButtonItem alloc] initWithTitle:@"加载本地" style:UIBarButtonItemStylePlain target:self action:@selector(loadArchived:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:animateButton, nil];
    
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
//    backItem.title = @"返回";
//    self.navigationItem.backBarButtonItem = backItem;
//    self.navigationItem.backBarButtonItem.tintColor = [UIColor magentaColor];
    
//    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]}];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background.jpg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"cat@2x"] forBarMetrics:UIBarMetricsCompact];
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    // Drawing view setup.
    drawingView.strokeColor = [UIColor blackColor];
    drawingView.strokeWidth = 10.0f;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //透明
    //导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bargound.png"] forBarMetrics:UIBarMetricsDefault];
    
    //导航栏底部线
    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bargound.png"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    //导航栏底部线
    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@""];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loadArchived:(id)sender{
    
    UIBezierPath *path = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"test-path" ofType:@"txt"]];
    // Display archived path.
    [drawingView drawBezier:path];
}
- (IBAction)animateDrawing:(id)sender{
    [drawingView animatePath];
}
- (IBAction)saveDrawing:(id)sender{
    UIActionSheet *saveSheet = [[UIActionSheet alloc] initWithTitle:@"保存" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照片",@"UIImage",@"UIBezierPath", nil];
    [saveSheet showInView:self.view];
}
- (IBAction)signatureMode:(id)sender{
    [drawingView setMode:SignatureMode];
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [drawingView refreshCurrentMode];
}
#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex != actionSheet.cancelButtonIndex){
        if (buttonIndex == 0){
            UIImage *drawingImage = [drawingView imageRepresentation];
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeImageToSavedPhotosAlbum:drawingImage.CGImage orientation:ALAssetOrientationUp completionBlock:^(NSURL *assetURL, NSError *error) {
                NSLog(@"%@",assetURL);
                NSLog(@"%@",error);
            }];
        }else if (buttonIndex == 1){
            UIImage *drawingImage = [drawingView imageRepresentation];
            NSLog(@"%@",drawingImage);
        }else if (buttonIndex == 2){
            UIBezierPath *path = [drawingView bezierPathRepresentation];
            NSLog(@"%@",path);
        }
    }
}
@end
