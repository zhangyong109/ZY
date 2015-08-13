//
//  BOSetting.h
//  轨迹动画
//
//  Created by ZY on 15/8/10.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOSetting : NSObject

/// The NSUserDefaults key for the cell.
@property (nonatomic, readonly) NSString *key;

/// The NSUserDefaults value assigned for the key defined on the cell.
@property (nonatomic, assign) id value;

/// Instantiates a new BOSetting object with a key.
+ (instancetype)settingWithKey:(NSString *)key;

@end
