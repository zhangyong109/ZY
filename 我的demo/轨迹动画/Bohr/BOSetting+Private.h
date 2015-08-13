//
//  BOSetting+Private.h
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "BOSetting.h"

@interface BOSetting ()

typedef void(^BOSettingValueDidChangeBlock)(void);

@property (nonatomic, copy) BOSettingValueDidChangeBlock valueDidChangeBlock;

@end
