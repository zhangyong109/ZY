//
//  Test.m
//  轨迹动画
//
//  Created by ZY on 15/8/26.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "Test.h"

@implementation Test



//runtime iphone6上有问题
//    [self testOCRunTime];
+(void)getClassNameAndPropertyName{
    // 获取所有加载的Objective-C框架和动态库的名称
    const char ** objc_copyImageNames ( unsigned int *outCount );
    // 获取指定类所在动态库
    const char * class_getImageName (Class cls );
    // 获取指定库或框架中所有类的类名
    const char ** objc_copyClassNamesForImage ( const char *image, unsigned int *outCount );
    NSLog(@"获取指定类所在动态库");
    NSLog(@"UIView's Framework: %s", class_getImageName(NSClassFromString(@"PictureBrowseViewController")));
    NSLog(@"获取指定库或框架中所有类的类名");
    unsigned int outCount = 0;
    const char ** classes = objc_copyClassNamesForImage(class_getImageName(NSClassFromString(@"PictureBrowseViewController")), &outCount);
    for (int i = 0; i < outCount; i++) {
        NSLog(@"class name: %s", classes[i]);
    }
    objc_property_t * properties = class_copyPropertyList(NSClassFromString(@"PictureBrowseViewController"), &outCount);
    
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName: %@", propertyName);
        
        
    }
}
@end
