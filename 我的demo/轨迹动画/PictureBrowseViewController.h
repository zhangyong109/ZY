//
//  PictureBrowseViewController.h
//  轨迹动画
//
//  Created by ZY on 15/8/7.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureBrowseViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrV;
@property (strong, nonatomic) UIPageControl *pageC;
@property (strong, nonatomic) UIImageView *imgVLeft;
@property (strong, nonatomic) UIImageView *imgVCenter;
@property (strong, nonatomic) UIImageView *imgVRight;
@property (strong, nonatomic) UILabel *lblImageDesc;
@property (strong, nonatomic) NSMutableDictionary *mDicImageData;
@property (assign, nonatomic) NSUInteger currentImageIndex;

/**
 *  加载图片数据
 */
- (void)loadImageData;

/**
 *  添加滚动视图
 */
- (void)addScrollView;

/**
 *  添加三个图片视图到滚动视图内
 */
- (void)addImageViewsToScrollView;

/**
 *  添加分页控件
 */
- (void)addPageControl;

/**
 *  添加标签；用于图片描述
 */
- (void)addLabel;

/**
 *  根据当前图片索引设置信息
 *
 *  @param currentImageIndex 当前图片索引；即中间
 */
- (void)setInfoByCurrentImageIndex:(NSUInteger)currentImageIndex;

/**
 *  设置默认信息
 */
- (void)setDefaultInfo;

/**
 *  重新加载图片
 */
- (void)reloadImage;

- (void)layoutUI;
@end