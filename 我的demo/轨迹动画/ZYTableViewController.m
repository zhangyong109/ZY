//
//  ZYTableViewController.m
//  轨迹动画
//
//  Created by ZY on 15/8/27.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ZYTableViewController.h"

@interface ZYTableViewController (){
    
}
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, strong) HADirect *direct;
@end

@implementation ZYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZYCollectionCell *cell = [[ZYCollectionCell alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:cell];
    
    _dataArray = @[@"ZYVC",
                   @"ContainerVC",
                   @"ZYImageTableViewController",
                   @"AutolayoutScrollView",
                   @"ZYScrollViewController",
                   @"HADirect-图片轮播"
                   ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    for (NSInteger i = 0; i < _dataArray.count; i ++) {
        if (i == indexPath.row) {
            cell.textLabel.text = _dataArray[i];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            [self pushToZYViewController];
        }
            break;
        case 1:{
            [self pushToContainerViewController];
        }
            break;
        case 2:{
            [self pushToZYImageTableViewController];
        }
            break;
        case 3:{
            [self pushToAutolayoutScrollViewController];
        }
            break;
        case 4:{
            [self pushToZYScrollViewController];
        }
            break;
        case 5:{
            [self addHADirect];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

#pragma mark - clicked methods

- (void)pushToZYViewController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ZYViewController *zyvc = (ZYViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ZYViewController"];
    [self.navigationController pushViewController:zyvc animated:YES];
}

- (void)pushToContainerViewController {
    ContainerViewController * containerViewController = [[ContainerViewController alloc]init];
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (int i=0; i<5; i++){
        PageViewController *page = [[PageViewController alloc] init];
        [tmpArray addObject:page];
    }
    AnimationCellViewController *animationCellViewController = [[AnimationCellViewController alloc] init];
    //            animationCellViewController.tableView.frame = CGRectMake(10, 110, MAINSCREENWIDTH - 20, MAINSCREENHEIGHT - 110*2);
    [tmpArray addObject:animationCellViewController];
    
    // set these as sub VCs
    [containerViewController setSubViewControllers:tmpArray];
    
    [self.navigationController pushViewController:containerViewController animated:YES];
}

- (void)pushToZYImageTableViewController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ZYImageTableViewController *zyvc = (ZYImageTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ZYImageTableViewController"];
    [self.navigationController pushViewController:zyvc animated:YES];
}

- (void)pushToAutolayoutScrollViewController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AutolayoutScrollViewController *autolayoutScrollView = (AutolayoutScrollViewController*)[storyboard instantiateViewControllerWithIdentifier:@"AutolayoutScrollViewController"];
    [self.navigationController pushViewController:autolayoutScrollView animated:YES];
}

- (void)pushToZYScrollViewController {
    ZYScrollViewController *scrollViewController = [[ZYScrollViewController alloc]init];
    [self.navigationController pushViewController:scrollViewController animated:YES];
}

- (void)addHADirect {
    static int i = 0;
    if (i%2 == 0) {
        _direct = [HADirect direcWithtFrame:CGRectMake(100, 100, 200, 250)
                                            ImageArr:@[
                                                       @"background.jpg",
                                                       @"cat@2x",
                                                       @"Default-568h@2x",
                                                       @"image2.jpg"
                                                       ]
                                  AndImageClickBlock:^(NSInteger index) {
                                      NSLog(@"AndImageClickBlock:%ld",(long)index);
                                      [_direct removeFromSuperview];
                                  }];
        _direct.tag = 1111;
        [[UIApplication sharedApplication].keyWindow addSubview:_direct];
    } else {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:1111] removeFromSuperview];
    }
    i ++;
}

@end
