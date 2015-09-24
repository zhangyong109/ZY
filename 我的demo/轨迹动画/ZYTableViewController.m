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

@end

@implementation ZYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = @[@"ZYVC",
                   @"ContainerVC",
                   @"ZYImageTableViewController",
                   @"AutolayoutScrollView",
                   @"ZYScrollViewController"
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
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            ZYViewController *zyvc = (ZYViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ZYViewController"];
            [self.navigationController pushViewController:zyvc animated:YES];
        }
            break;
        case 1:{
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
            break;
        case 2:{
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            ZYImageTableViewController *zyvc = (ZYImageTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ZYImageTableViewController"];
            [self.navigationController pushViewController:zyvc animated:YES];
        }
            break;
        case 3:{
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            AutolayoutScrollViewController *autolayoutScrollView = (AutolayoutScrollViewController*)[storyboard instantiateViewControllerWithIdentifier:@"AutolayoutScrollViewController"];
            [self.navigationController pushViewController:autolayoutScrollView animated:YES];
        }
            break;
        case 4:{
            ZYScrollViewController *scrollViewController = [[ZYScrollViewController alloc]init];
            [self.navigationController pushViewController:scrollViewController animated:YES];
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
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
