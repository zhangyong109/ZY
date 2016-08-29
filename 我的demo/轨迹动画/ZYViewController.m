//
//  ZYViewController.m
//  轨迹动画
//
//  Created by ZY on 15/7/22.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ZYViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "RootViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreMotion/CoreMotion.h>

@interface ZYViewController (){
    NSTimer * checkShakeTimer;//检测震动
    ColorGradientView *progressView;

}

@property(nonatomic,strong)RootViewController * rtVC;
@property (strong) CMMotionManager* montionManager;

@end

@implementation ZYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.6 green:0.8 blue:0.9 alpha:1];
    self.navigationItem.title = @"测试";

    [self addProgressView];

    [self addPanGesturePopVC];
    
    WMHamburgerButton * wm = [[WMHamburgerButton alloc]initWithFrame:CGRectMake(10, 320, 30, 30)];
    [self.view addSubview:wm];
    
    [self checkDeviceShake];
    
    //runtime
    [Test getClassNameAndPropertyName];
    
    __weak NSString *str1 = @"wwww".lowercaseString;
    __weak NSString *str2;
    str2 = @"wwww".lowercaseString;
    NSLog(@"--%@--%@",str1,str2);
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // Starts the moving gradient effect
    [progressView startAnimating];
    
    // Continuously updates the progress value using random values
    [self simulateProgress];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [progressView stopAnimating];
}

#pragma mark - 
- (void)addProgressView {
    //颜色 渐变 view
    progressView = [[ColorGradientView alloc]initWithFrame:CGRectMake(0, 65.0f, CGRectGetWidth([[self view] bounds]), 5.0f)];
    progressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
}

- (void)simulateProgress {
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        CGFloat progress  = [progressView progress] + increment;
        [progressView setProgress:progress];
        if (progress < 1.0) {
            
            [self simulateProgress];
        }
    });
}


#pragma mark - method
-(void)downloadedImage{
    /**
     *  TableView中实现平滑滚动延迟加载图片利用CFRunLoopMode的特性，可以将图片的加载放到NSDefaultRunLoopMode的mode里，这样在滚动UITrackingRunLoopMode这个mode时不会被加载而影响到。
     */
    UIImage *downloadedImage;
    [[[UIImageView alloc]initWithImage:downloadedImage] performSelector:@selector(setImage:)
                                                             withObject:downloadedImage
                                                             afterDelay:0
                                                                inModes:@[NSDefaultRunLoopMode]];
}

- (IBAction)jump:(id)sender {
    [self jumpToOtherAPP];
    
}
- (IBAction)transitionButtonClicked:(UIButton *)sender {
    _rtVC = [[RootViewController alloc]init];
    //    [self showViewController:_rtVC sender:sender];
    [self.navigationController pushViewController:_rtVC animated:YES];
}

-(void)jumpToOtherAPP{
    static int i = 0;
    switch (i % 4) {
        case 0:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"taobao://item.taobao.com/item.htm?spm=a230r.1.14.304.DWeflI&id=37060015134&ns=1&abbucket=20#detail"]];
            
            break;
        case 1:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tmall://detail.tmall.com/item.htm?spm=a220m.1000858.1000725.46.N3nPcH&id=44737376781&areaId=110000&cat_id=2&rn=8b4feaafe0713cfef88b6aa8ae0ccc28&user_id=2227179486&is_b=1"]];
            break;
        case 2:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"taobao://item.taobao.com/item.htm?id=17401365271"]];
            
            break;
        case 3:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"openApp.jdMobile://item.jd.com/1515101139.html"]];
            
            
            //        if ([urlString hasPrefix:@"http://item.jd.com/"]) {
            //
            //            //            http://item.jd.com/1515101139.html
            //
            //            //            openApp.jdMobile://virtual?params={“category”:”jump”,”des”:”productDetail”,”skuId”:”1140722“,”sourceType”:”JSHOP_SOURCE_TYPE”,”sourceValue”:”JSHOP_SOURCE_VALUE”}
            //
            //            NSString * str1 = @"openApp.jdMobile://item.jd.com/1515101139.html";
            //            NSURL * u = [NSURL URLWithString:str1];
            //            if ([[UIApplication sharedApplication]canOpenURL:u]) {
            //                [[UIApplication sharedApplication]openURL:u];
            //                return NO;
            //            }
            //        }
            
            break;
            
        default:
            break;
    }
    
    i ++;
    //    http://item.taobao.com/item.htm?spm=a230r.1.14.304.DWeflI&id=37060015134&ns=1&abbucket=20#detail
    
    //    http://item.jd.com/1515101139.html
}

- (IBAction)pictureBrowseClicked:(UIButton *)sender {
    
    PictureBrowseViewController * pb = [[PictureBrowseViewController alloc]init];
    
    pb.currentImageIndex = 0;
    [self.navigationController pushViewController:pb animated:YES];
    
    //    [self presentViewController:pb animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - 检测晃动
-(void)checkDeviceShake{
    //检测晃动
    //TODO:开始停止设定
    checkShakeTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(autoChange) userInfo:nil repeats:YES];
    self.montionManager = [[CMMotionManager alloc]init];
    self.montionManager.accelerometerUpdateInterval = 0.1;
    [self.montionManager startAccelerometerUpdates];
}

-(void)autoChange{
    //上次与本次的差：X:0.15 Y:0.15 Z:0.2
    static double deltaX = 0.15;
    static double deltaY = 0.15;
    static double deltaZ = 0.15;
    
    static double lastX = 0.0;
    static double lastY = 0.0;
    static double lastZ = 1.0;
    
    double thisX = fabs(self.montionManager.accelerometerData.acceleration.x);
    double thisY = fabs(self.montionManager.accelerometerData.acceleration.y);
    double thisZ = fabs(self.montionManager.accelerometerData.acceleration.z);
    
    if (fabs(thisX - lastX) > deltaX || fabs(thisY - lastY) > deltaY || fabs(thisZ - lastZ) > deltaZ){
        NSLog(@"我晃动了 。。。。X:%lf--Y:%lf--Z:%lf", self.montionManager.accelerometerData.acceleration.x, self.montionManager.accelerometerData.acceleration.y, self.montionManager.accelerometerData.acceleration.z);
        lastX = thisX;
        lastY = thisY;
        lastZ = thisZ;
    }
}

//#pragma mark - RunTime
//-(void)testOCRunTime{
//    
//    [self testRuntime];
//
//    //    在一个函数找不到时，Objective-C提供了三种方式去补救：
//    //
//    //    1、调用resolveInstanceMethod给个机会让类添加这个实现这个函数
//    //    2、调用forwardingTargetForSelector让别的对象去执行这个函数
//    //    3、调用methodSignatureForSelector（函数符号制造器）和forwardInvocation（函数执行器）灵活的将目标函数以其他形式执行。
//    //
//    //    如果都不中，调用doesNotRecognizeSelector抛出异常。
//    //    http://www.cnblogs.com/biosli/p/NSObject_inherit_2.html
//    [self www];
//    [self www1];
//    [self www2];
//    [self www3];
//    
//}
//+(BOOL)resolveInstanceMethod:(SEL)sel{
//    if (sel == @selector(www)){
//        //        参数说明：
//        //        cls：被添加方法的类
//        //        name：可以理解为方法名，
//        //        imp：实现这个方法的函数
//        //        types：一个定义该函数返回值类型和参数类型的字符串
//        //http://blog.csdn.net/lvmaker/article/details/32396167
//        //https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
//        class_addMethod([self class], sel, (IMP) sayHello, "v@:");
//        return YES;
//    }
//    if (sel == @selector(www1)){
//        
//        return NO;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//
////将消息转出某对象
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    NSLog(@"MyTestObject _cmd: %@", NSStringFromSelector(_cmd));
//    
//    ZYObject *none = [[ZYObject alloc] init];
//    if ([none respondsToSelector: aSelector]) {
//        return none;
//    }
//    return [super forwardingTargetForSelector: aSelector];
//}
//
////真正执行从methodSignatureForSelector:返回的NSMethodSignature。在这个函数里可以将NSInvocation多次转发到多个对象中，这也是这种方式灵活的地方。（forwardingTargetForSelector只能以Selector的形式转向一个对象）
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector{
//    NSString *sel = NSStringFromSelector(selector);
//    if ([sel isEqualToString:NSStringFromSelector(@selector(www2))] ) {
//        //动态造一个 setter函数
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }else{
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
//}
//
//- (void)forwardInvocation:(NSInvocation *)invocation{
//    //拿到函数名
//    NSString *key = NSStringFromSelector([invocation selector]);
//    
//    if ([key isEqualToString:NSStringFromSelector(@selector(www2))] ) {
//        
//        ZYObject *none = [[ZYObject alloc] init];
//        if ([none respondsToSelector: @selector(key)]) {
//            [none www2];
//        }
//    }else{
//        //        [self doesNotRecognizeSelector:@selector(www3)];
//        
//    }
//}
//
//
////此函数通常是不需要重载的，但是在动态实现了查找过程后，需要重载此函数让对外接口查找动态实现函数的时候返回YES，保证对外接口的行为统一。
//- (BOOL) respondsToSelector:(SEL)aSelector{
//    if (@selector(www) == aSelector ||
//        @selector(www1) == aSelector ||
//        @selector(www2) == aSelector)
//    {
//        return YES;
//    }
//    
//    return [super respondsToSelector: aSelector];
//}
//
//void sayHello(id self, SEL _cmd){
//    NSLog(@"ZYViewController 没有 www 方法，自动创建了");
//}
//
//

//- (id)fetchSSIDInfo{
//    //获取当前所连接 wifi
//    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
//    NSLog(@"%s: Supported interfaces: %@", __func__, ifs);
//    id info = nil;
//    for (NSString *ifnam in ifs) {
//        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
//        //        if (info) {
//        //            break;
//        //        }
//    }
//    return info;
//}
//
//#pragma mark - Runtime
//-(void)testRuntime{
//    
//    //    http://justsee.iteye.com/blog/2163777
//    id LenderClass = objc_getClass("ZYViewController");
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList(LenderClass, &outCount);
//    for (i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        fprintf(stdout, "%s---%s\n", property_getName(property), property_getAttributes(property));
//    }
////    [ZYViewController load];
//}
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        // When swizzling a class method, use the following:
//        // Class class = object_getClass((id)self);
//        SEL originalSelector = @selector(viewWillAppear:);
//        SEL swizzledSelector = @selector(xxx_viewWillAppear:);
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        BOOL didAddMethod =
//        class_addMethod(class,
//                        originalSelector,
//                        method_getImplementation(swizzledMethod),
//                        method_getTypeEncoding(swizzledMethod));
//        if (didAddMethod) {
//            class_replaceMethod(class,
//                                swizzledSelector,
//                                method_getImplementation(originalMethod),
//                                method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}
//
//#pragma mark - Method Swizzling
////- (void)xxx_viewWillAppear:(BOOL)animated {
////    [self xxx_viewWillAppear:animated];
////    NSLog(@"viewWillAppear: %@", self);
////}
//
////-(void)viewWillAppear:(BOOL)animated{
////    [self viewWillAppear:animated];
////    NSLog(@"viewWillAppear--: %@", self);
////
////}
//-(void)testString{
//    NSString* constString1 = nil;
//    NSString* constString2 = @"";
//    NSString* constString3 = @"Hello, World!";
//    NSString* constString4 = @"哈喽,世界!"; // 汉字+半角标点混合
//    
//    NSLog(@"constString1[size,length] = [%zd, %zd]", sizeof(constString1),constString1.length); // [8,0]
//    NSLog(@"constString2[size,length] = [%zd, %zd]", sizeof(constString2),constString2.length); // [8,0]
//    NSLog(@"constString3[size,length] = [%zd, %zd]", sizeof(constString3),constString3.length); // [8,13]
//    NSLog(@"constString4[size,length] = [%zd, %zd]", sizeof(constString4),constString4.length); // [8,6]
//    
//    unichar ch = [constString3 characterAtIndex:7];
//    NSLog(@"ch = %c", ch); // W
//    unichar* cBuf = malloc(sizeof(unichar)*constString3.length);
//    [constString3 getCharacters:cBuf];
//    NSString* stringFromCharacters1 = [[NSString alloc] initWithCharacters:cBuf length:constString3.length];
//    NSLog(@"stringFromCharacters1 = %@", stringFromCharacters1); // @"Hello, World!"
//    
//    NSLog(@"constString3 = %@", constString3);
//    [constString3 getCharacters:cBuf range:NSMakeRange(7, 6)];
//    NSLog(@"constString3 = %@", constString3);
//    NSString* stringFromCharacters2 = [NSString stringWithCharacters:cBuf length:constString3.length];
//    NSLog(@"stringFromCharacters2 = %@", stringFromCharacters2);  // @"World! World!"     //???
//    
//    
//    //    Class _alertManager = NSClassFromString([NSString stringWithFormat:@"_UIAlertManager"]);
//    //    SEL methodSel = NSSelectorFromString([NSString stringWithFormat:@"topMostAlert"]);
//    //    if ([_alertManager respondsToSelector:methodSel])
//    //    {
//    //        id topView  = objc_msgSend(self,@selector(testString));
//    //        objc_msgSend(self, @selector(test));
//    //    }
//}


@end
