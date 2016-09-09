//
//  UIImage+SubImage.m
//  UIImage+Categories
//
//  Created by ZY on 16/8/4.
//  Copyright © 2016年 HYZX. All rights reserved.
//

#import "UIImage+SubImage.h"

@implementation UIImage (SubImage)

// 截取当前image对象rect区域内的图像
- (UIImage *)subImageWithRect:(CGRect)rect {
    CGImageRef newImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    
    return newImage;
}

// 压缩图片至指定尺寸
- (UIImage *)rescaleImageToSize:(CGSize)size {
    CGRect rect = (CGRect){CGPointZero, size};
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self drawInRect:rect];
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
}

// 压缩图片至指定像素
- (UIImage *)rescaleImageToPX:(CGFloat )toPX {
    CGSize size = self.size;
    
    if(size.width <= toPX && size.height <= toPX) {
        return self;
    }
    
    CGFloat scale = size.width / size.height;
    
    if(size.width > size.height) {
        size.width = toPX;
        size.height = size.width / scale;
    } else {
        size.height = toPX;
        size.width = size.height * scale;
    }
    
    return [self rescaleImageToSize:size];
}

// 指定大小生成一个平铺的图片
- (UIImage *)getTiledImageWithSize:(CGSize)size {
    UIView *tempView = [[UIView alloc] init];
    tempView.bounds = (CGRect){CGPointZero, size};
    tempView.backgroundColor = [UIColor colorWithPatternImage:self];
    
    UIGraphicsBeginImageContext(size);
    [tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return bgImage;
}

// UIView转化为UIImage
+ (UIImage *)imageFromView:(UIView *)view {
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// 将两个图片生成一张图片
+ (UIImage*)mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage {
    CGImageRef firstImageRef = firstImage.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    CGImageRef secondImageRef = secondImage.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    UIGraphicsBeginImageContext(mergedSize);
    [firstImage drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [secondImage drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
