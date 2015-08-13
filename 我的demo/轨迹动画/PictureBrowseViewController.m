//
//  PictureBrowseViewController.m
//  轨迹动画
//
//  Created by ZY on 15/8/7.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "PictureBrowseViewController.h"

#define kWidthOfScreen [[UIScreen mainScreen] bounds].size.width
#define kHeightOfScreen [[UIScreen mainScreen] bounds].size.height
#define kImageViewCount 3

@interface PictureBrowseViewController (){
    NSArray * imageNames;
}

@property (assign, nonatomic) NSUInteger imageCount;

@end

@implementation PictureBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self layoutUI];

//    //透明导航栏背景
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bargound.png"] forBarMetrics:UIBarMetricsDefault];
//    
//    //导航栏底部线
//    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bargound.png"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    //导航栏背景
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    
//    //导航栏底部线
//    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@""];
    
    [super.navigationController setNavigationBarHidden:NO animated:NO];

}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}

- (BOOL)prefersStatusBarHidden{
    return YES; // 返回NO表示要显示，返回YES将hiden
}

- (void)layoutUI {
    self.view.backgroundColor = [UIColor blackColor];
    [self addBackButton];
    [self loadImageData];
    [self addScrollView];
    [self addImageViewsToScrollView];
    [self addPageControl];
    [self addLabel];
    [self setDefaultInfo];
}

-(void)addBackButton{
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:backBtn];

}

-(void)backBtnClicked:(UIButton *) sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [sender removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadImageData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ImageInfo" ofType:@"plist"];
    _mDicImageData = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    _imageCount = _mDicImageData.count;
}

- (void)addScrollView {
    _scrV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    _scrV.contentSize = CGSizeMake(kWidthOfScreen * kImageViewCount, 0);
    _scrV.contentOffset = CGPointMake(kWidthOfScreen, 0.0);
    _scrV.pagingEnabled = YES;
    _scrV.showsHorizontalScrollIndicator = NO;
    _scrV.delegate = self;
//    _scrV.backgroundColor = [UIColor orangeColor];
    _scrV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrV];
}

- (void)addImageViewsToScrollView {
    //图片视图；左边
    _imgVLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, kWidthOfScreen, kHeightOfScreen - 0)];
    _imgVLeft.contentMode = UIViewContentModeScaleAspectFit;
    [_scrV addSubview:_imgVLeft];
    
    //图片视图；中间
    _imgVCenter = [[UIImageView alloc] initWithFrame:CGRectMake(kWidthOfScreen, 0.0, kWidthOfScreen, kHeightOfScreen - 0)];
    _imgVCenter.contentMode = UIViewContentModeScaleAspectFit;
    [_scrV addSubview:_imgVCenter];
    
    //图片视图；右边
    _imgVRight = [[UIImageView alloc] initWithFrame:CGRectMake(kWidthOfScreen * 2.0, 0.0, kWidthOfScreen, kHeightOfScreen - 0)];
    _imgVRight.contentMode = UIViewContentModeScaleAspectFit;
    [_scrV addSubview:_imgVRight];
}

- (void)addPageControl {
    _pageC = [UIPageControl new];
    CGSize size= [_pageC sizeForNumberOfPages:_imageCount]; //根据页数返回 UIPageControl 合适的大小
    _pageC.bounds = CGRectMake(0.0, 0.0, size.width, size.height);
    _pageC.center = CGPointMake(kWidthOfScreen / 2.0, kHeightOfScreen - 80.0);
    _pageC.numberOfPages = _imageCount;
    _pageC.pageIndicatorTintColor = [UIColor orangeColor];
    _pageC.currentPageIndicatorTintColor = [UIColor magentaColor];
    _pageC.userInteractionEnabled = NO; //设置是否允许用户交互；默认值为 YES，当为 YES 时，针对点击控件区域左（当前页索引减一，最小为0）右（当前页索引加一，最大为总数减一），可以编写 UIControlEventValueChanged 的事件处理方法
    [self.view addSubview:_pageC];
}

- (void)addLabel {
    _lblImageDesc = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 20.0, kWidthOfScreen, 25.0)];
    _lblImageDesc.textAlignment = NSTextAlignmentCenter;
    _lblImageDesc.textColor = [UIColor whiteColor];
    _lblImageDesc.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    _lblImageDesc.text = @"qqq now.";
    [self.view addSubview:_lblImageDesc];
}

- (void)setInfoByCurrentImageIndex:(NSUInteger)currentImageIndex {
    imageNames = [_mDicImageData allKeys];
//    NSString *currentImageNamed = [NSString stringWithFormat:@"%lu.png", (unsigned long)currentImageIndex];

    
    _imgVCenter.image = [UIImage imageNamed:imageNames[currentImageIndex]];
    _imgVLeft.image = [UIImage imageNamed:imageNames[(_currentImageIndex - 1 + _imageCount) % _imageCount]];
    _imgVRight.image = [UIImage imageNamed:imageNames[((_currentImageIndex + 1) % _imageCount)]];
    
    _pageC.currentPage = currentImageIndex;
    
    _lblImageDesc.text = _mDicImageData[imageNames[currentImageIndex]];
}

- (void)setDefaultInfo {
    if (!_currentImageIndex) {
        _currentImageIndex = 0;
    }
    [self setInfoByCurrentImageIndex:_currentImageIndex];
}

- (void)reloadImage {
    CGPoint contentOffset = [_scrV contentOffset];
    if (contentOffset.x > kWidthOfScreen) { //向左滑动
        _currentImageIndex = (_currentImageIndex + 1) % _imageCount;
    } else if (contentOffset.x < kWidthOfScreen) { //向右滑动
        _currentImageIndex = (_currentImageIndex - 1 + _imageCount) % _imageCount;
    }
    
    [self setInfoByCurrentImageIndex:_currentImageIndex];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadImage];
    
    _scrV.contentOffset = CGPointMake(kWidthOfScreen, 0);
    _pageC.currentPage = _currentImageIndex;
    
//    NSString *currentImageNamed = [NSString stringWithFormat:@"%lu.png", (unsigned long)_currentImageIndex];
    _lblImageDesc.text = _mDicImageData[imageNames[_currentImageIndex]];
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
