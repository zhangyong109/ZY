//
//  ColorGradientView.h
//  轨迹动画
//
//  Created by ZY on 15/10/13.
//  Copyright © 2015年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorGradientView : UIView


@property (nonatomic, readonly, getter=isAnimating) BOOL animating;
@property (nonatomic, readwrite, assign) CGFloat progress;

- (void)startAnimating;
- (void)stopAnimating;


//为了增加一个标识进度的进行，我们可以使用mask属性来屏蔽一部分，在头文件中添加两个属性：
@property (nonatomic, readonly) CALayer *maskLayer;

@end
