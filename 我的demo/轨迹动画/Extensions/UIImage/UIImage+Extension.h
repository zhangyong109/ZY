//
//  UIImage+Extension.h
//  轨迹动画
//
//  Created by ZY on 16/8/29.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


/** 设置圆形图片*/
- (UIImage *)circleImage;

//通过图片Data数据第一个字节,获取图片扩展名
- (NSString *)contentTypeForImageData:(NSData *)data;



@end
