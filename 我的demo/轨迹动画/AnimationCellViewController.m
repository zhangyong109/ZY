//
//  AnimationCellViewController.m
//  轨迹动画
//
//  Created by ZY on 15/8/13.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "AnimationCellViewController.h"
@interface AnimationCellViewController(){
    
    
}
@property (nonatomic,strong)NSMutableArray * dataArray;


@end
@implementation AnimationCellViewController

-(void)viewDidLoad{
    [super viewDidLoad];
//    [self addPanGesturePopVC];
    
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 30; i ++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"cell:%d",i]];
    }
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor blackColor];
//    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSLayoutConstraint * constraint1 = [NSLayoutConstraint constraintWithItem:self.tableView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:20];
    NSLayoutConstraint * constraint2 = [NSLayoutConstraint constraintWithItem:self.tableView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:20];
    NSLayoutConstraint * constraint3 = [NSLayoutConstraint constraintWithItem:self.tableView
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:20];
    NSLayoutConstraint * constraint4 = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeWidth
                                                                   multiplier:1.0
                                                                     constant:0];
    [self.view addConstraints:[NSArray arrayWithObjects:constraint1,constraint2,constraint3,constraint4, nil]];
}
- (void)btnAction:(NSInteger)index {
    //获取可见cells
    NSArray* visibleCells = _tableView.visibleCells;
    NSLog(@"%@",visibleCells);
    
    CGAffineTransform transform;
    double duration = 0.2;
    switch (index) {
        case 0:
            transform = CGAffineTransformMakeTranslation(MAINSCREENWIDTH, 0);
            for (UITableViewCell *cell in visibleCells) {
                [self cellAnimateWithCell:cell visibleCells:visibleCells transform:transform duration:duration isRemove:YES];
                duration+=0.1;
                
            }
            break;
        case 1:
            //        transform = CGAffineTransformMakeTranslation(- MAINSCREENWIDTH, 0);
            transform = CGAffineTransformMake(1, 0, 1, 1, - MAINSCREENWIDTH - 30, 0);
            for (UITableViewCell *cell in visibleCells) {
                [self cellAnimateWithCell:cell visibleCells:visibleCells transform:transform duration:duration isRemove:YES];
                duration+=0.1;
            }
            break;
        case 2:
            transform = CGAffineTransformMakeTranslation(0, 10);;

            for (UITableViewCell *cell in visibleCells) {
                [self cellAnimateWithCell:cell visibleCells:visibleCells transform:transform duration:duration isRemove:NO];
                duration+=0.1;
            }
            break;
        case 3:
            for (UITableViewCell *cell in visibleCells) {
                transform = CGAffineTransformRotate(cell.transform, M_PI_2);
                [self cellAnimateWithCell:cell visibleCells:visibleCells transform:transform duration:duration isRemove:NO];
                duration+=0.1;
            }
            break;
        case 4:
            for (UITableViewCell *cell in visibleCells) {
                transform = CGAffineTransformScale(cell.transform, 0.9, 0.9);
                [self cellAnimateWithCell:cell visibleCells:visibleCells transform:transform duration:duration isRemove:NO];
                duration+=0.2;
            }
            break;
        case 5:
            for (UITableViewCell *cell in visibleCells) {
                transform = CGAffineTransformTranslate(cell.transform, 0, 10);
                transform = CGAffineTransformRotate(transform, M_PI_2);
                transform = CGAffineTransformScale(transform, 0.5, 0.5);

                
                [self cellAnimateWithCell:cell visibleCells:visibleCells transform:transform duration:duration isRemove:NO];
                duration+=0.1;
            }
            break;
        default:
            break;
    }
}

-(void)cellAnimateWithCell:(UITableViewCell*)cell visibleCells:(NSArray *)visibleCells transform:(CGAffineTransform)transform  duration:(NSTimeInterval)duration isRemove:(BOOL)isRemove{
    [UIView animateWithDuration:duration delay:0 options:0  animations:^{
        cell.transform = transform;
        
    } completion:^(BOOL finished){
        if (isRemove) {
            static int count = 0;
            count ++;
            if (_dataArray.count) {
                //                 NSInteger i = cell.tag;
                //                 [_dataArray removeObjectAtIndex:i%_dataArray.count];
                
                if ([_dataArray containsObject:cell.textLabel.text]) {
                    [_dataArray removeObject:cell.textLabel.text];
                }
            }
            if (count == visibleCells.count) {
                [self.tableView reloadData];
                count = 0;
            }
        }else{
            cell.transform = CGAffineTransformMakeTranslation(0, 0);;
        }
    }];
    
}
#pragma mark- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"histroyCellList"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"histroyCellList"];
    }
    NSInteger i = indexPath.row;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataArray[i%_dataArray.count]];
    
//    http://www.cnblogs.com/pengyingh/articles/2378732.html
    //必须重置 cell 的transform，不然重用的 cell 将不能正常动画
    cell.transform = CGAffineTransformIdentity;//view.layer.transform = CATransform3DIdentity
    
    cell.tag = i%_dataArray.count;
    
    switch ((i%_dataArray.count) % 6) {
        case 0:
            cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
            break;
        case 1:
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
            break;
        case 2:
            cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
            break;
        case 3:
            cell.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
            break;
        case 4:
            cell.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1.0];
            break;
        case 5:
            cell.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
            break;
        default:
            break;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{

    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self btnAction:indexPath.row%6];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!tableView.editing)
        return UITableViewCellEditingStyleNone;
    else {
        return UITableViewCellEditingStyleDelete;
    }
}

@end
