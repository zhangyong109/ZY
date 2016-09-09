//
//  UIImage+Color.h
//  UIImage+Categories
//
//  Created by ZY on 16/8/4.
//  Copyright © 2016年 HYZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/** 
 根据颜色生成纯色图片 
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/** 
 取图片某一像素的颜色 
 */
+ (UIColor *)image:(UIImage *)image colorAtPixel:(CGPoint)point;
- (UIColor *)colorAtPixel:(CGPoint)point;

/** 
 获得灰度图 
 */
+ (UIImage *)imageConvertToGrayImage:(UIImage *)image;
- (UIImage *)convertToGrayImage;

@end
