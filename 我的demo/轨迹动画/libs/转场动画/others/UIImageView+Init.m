//
//  UIImageView+Init.m
//  ZY
//
//  Created by ZY on 15/7/30.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "UIImageView+Init.h"

@implementation UIImageView (Init)

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image        = image;
    
    return imageView;
}

@end
