//
//  ZYImageTableViewController.m
//  轨迹动画
//
//  Created by ZY on 15/9/7.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ZYImageTableViewController.h"

@interface ZYImageTableViewController (){
    
}

@property (nonatomic, assign) TableViewSlidingDirection tableViewSlidingDirection;

@end

@implementation ZYImageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    self.tableViewSlidingDirection = TableViewSlidingDirectionUpward;
    [self fetchDataFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didClickRefreshButton:(UIBarButtonItem *)sender {
    [self fetchDataFromServer];
}

- (void)fetchDataFromServer{
//    static NSString *apiURL = @"http://image.baidu.com/i?tn=resultjson_com&word=animal&rn=60";
    static NSString *apiURL = @"http://image.baidu.com/i?tn=resultjson_com&word=man&rn=60";
//    static NSString *apiURL = @"http://image.baidu.com/i?tn=resultjson_com&word=lion&rn=60";

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:apiURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"Request succeeded");
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 NSArray *originalData = [responseObject arrayForKey:@"data"];
                 NSMutableArray *data = [NSMutableArray array];
                 for (NSDictionary *item in originalData) {
                     if ([item isKindOfClass:[NSDictionary class]] && [[item stringForKey:@"hoverURL"] length] > 0) {
                         [data addObject:item];
                     }
                 }
                 self.data = data;
             } else {
                 self.data = nil;
             }
             [self.tableView reloadData];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Request falied:%@",error);
         }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZYImageTableViewCell" forIndexPath:indexPath];
    
    [self setupCell:cell withIndexPath:indexPath];

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *obj = [self objectForRow:indexPath.row];
    NSInteger width = [obj integerForKey:@"width"];
    NSInteger height = [obj integerForKey:@"height"];
    if (obj && width > 0 && height > 0) {
        CGFloat h = (tableView.frame.size.width - 16) / (float)width * (float)height;//减16是因为 tableview 左右各有8空白
        return h;
    }
    return 44.0;
}

- (void)setupCell:(ZYImageTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    static NSString *referer = @"http://image.baidu.com/i?tn=baiduimage&ipn=r&ct=201326592&cl=2&lm=-1&st=-1&fm=index&fr=&sf=1&fmq=&pv=&ic=0&nc=1&z=&se=1&showtab=0&fb=0&width=&height=&face=0&istype=2&ie=utf-8&word=cat&oq=cat&rsp=-1";
    SDWebImageDownloader *downloader = [[SDWebImageManager sharedManager] imageDownloader];
    [downloader setValue:referer forHTTPHeaderField:@"Referer"];
    
    NSDictionary *obj = [self objectForRow:indexPath.row];
    NSURL *targetURL = [NSURL URLWithString:[obj stringForKey:@"hoverURL"]];
    //    NSLog(@"%@ %@", self.tableView.dragging ? @"dragging":@"", self.tableView.decelerating ? @"decelerating":@"");
    if (![[cell.photoView sd_imageURL] isEqual:targetURL]) {
        cell.photoView.alpha = 0.0;
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        CGRect cellFrame = [self.tableView rectForRowAtIndexPath:indexPath];
        BOOL shouldLoadImage = YES;
        if (self.targetRect && !CGRectIntersectsRect([self.targetRect CGRectValue], cellFrame)) {
            SDImageCache *cache = [manager imageCache];
            NSString *key = [manager cacheKeyForURL:targetURL];
            if (![cache imageFromMemoryCacheForKey:key]) {
                shouldLoadImage = NO;
            }
        }
        if (shouldLoadImage) {
            [cell.photoView sd_setImageWithURL:targetURL placeholderImage:nil options:SDWebImageHandleCookies completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error && [imageURL isEqual:targetURL]) {
                    // fade in animation
//                    [UIView animateWithDuration:0.25 animations:^{
//                        cell.photoView.alpha = 1.0;
//                    }];
                    
                    // or flip animation
                    if (self.tableViewSlidingDirection == TableViewSlidingDirectionUpward) {
                        [UIView transitionWithView:cell duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                            cell.photoView.alpha = 1.0;
                        } completion:^(BOOL finished) {
                        }];
                    }else{
                        [UIView transitionWithView:cell duration:0.1 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                            cell.photoView.alpha = 1.0;
                        } completion:^(BOOL finished) {
                        }];
                    }
                    
                }
            }];
        }
    }
}

- (NSDictionary *)objectForRow:(NSInteger)row{
    if (row < self.data.count) {
        return self.data[row];
    }
    return nil;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    UIColor * color = [UIColor colorWithRed:MIN(1, offsetY/scrollView.contentSize.height) green:175/255.0 blue:240/255.0 alpha:1];
    
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = 0.6 * MIN(1, (1 - (NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];

    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.targetRect = nil;
    [self loadImageForVisibleCells];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGRect targetRect = CGRectMake(targetContentOffset->x, targetContentOffset->y, scrollView.frame.size.width, scrollView.frame.size.height);
    self.targetRect = [NSValue valueWithCGRect:targetRect];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    if (translation.y > 0) {
        self.tableViewSlidingDirection = TableViewSlidingDirectionDown;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else if(translation.y < 0){
        self.tableViewSlidingDirection = TableViewSlidingDirectionUpward;
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.targetRect = nil;
    [self loadImageForVisibleCells];
}

- (void)loadImageForVisibleCells{
    NSArray *cells = [self.tableView visibleCells];
    for (ZYImageTableViewCell *cell in cells) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self setupCell:cell withIndexPath:indexPath];
    }
}


@end
