//
//  ZYPlaceholderTextView.h
//  ZYPlaceholderTextView
//
//  Created by ZY on 16/8/13.
//  Copyright © 2016年 scorpio. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ZYPlaceholderTextView : UITextView

/** 
 占位文字 
 */
@property (nonatomic, copy)NSString *placeholder;

/** 
 占位文字颜色 
 */
@property (nonatomic, strong)UIColor *placeholderColor;


@end
