//
//  ViewController.m
//  轨迹动画
//
//  Created by ZY on 15/4/21.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController
- (IBAction)stopOnClick:(UIButton *)sender {
    
//    [self.imageView.layer removeAnimationForKey:@"imageViewRotation"];
    
    [self.imageView.layer removeAllAnimations];
}
- (IBAction)beginOnClick:(UIButton *)sender {
    
//    [self.imageView.layer removeAllAnimations];
    
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
    keyAnima.keyPath = @"transform.rotation";
    //设置动画时间
    keyAnima.duration = 10;
    //设置图标抖动弧度
    keyAnima.values = @[@(-0),@(M_PI*2),@(0)];
    //设置动画的重复次数(设置为最大值)
    keyAnima.repeatCount = MAXFLOAT;
    
    keyAnima.fillMode=kCAFillModeForwards;
    keyAnima.removedOnCompletion = NO;
    keyAnima.delegate = self;
    //2.添加动画
    [self.imageView.layer addAnimation:keyAnima forKey:@"imageViewRotation"];
    
}

- (IBAction)animation2:(id)sender {
    
//    [self.imageView.layer removeAllAnimations];
    
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
    //平移
    keyAnima.keyPath = @"position";
    //1.1告诉系统要执行什么动画
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(100,                    200)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(MAINSCREENWIDTH - 100,  200)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(MAINSCREENWIDTH - 100,  MAINSCREENHEIGHT - 100)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(100,                    MAINSCREENHEIGHT - 100)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(100,                    200)];
    keyAnima.values = @[value1,value2,value3,value4,value5];
    
    //可以设置一个CGPathRef\CGMutablePathRef,让层跟着路径移动。path只对CALayer的anchorPoint和position起作用。如果你设置了path，那么values将被忽略
//    keyAnima.path = CGPathRef
    
    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion = NO;
    //1.3设置保存动画的最新状态
    keyAnima.fillMode = kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyAnima.duration = 4.0;
    
    //为对应的关键帧指定对应的时间点,其取值范围为0到1.0,keyTimes中的每一个时间值都对应values中的每一帧.当keyTimes没有设置的时候,各个关键帧的时间是平分的
    keyAnima.keyTimes = @[@0,@0.1,@0.8,@0.9,@1];
    
    //1.5设置动画的节奏
    keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //设置动画的重复次数(设置为最大值)
    keyAnima.repeatCount = MAXFLOAT;
    //设置代理，开始—结束
    keyAnima.delegate = self;
    //2.添加核心动画
    [self.imageView.layer addAnimation:keyAnima forKey:@"imageViewAnimation2"];
}

- (IBAction)animation3:(UIButton *)sender {
    
//    [self.imageView.layer removeAllAnimations];
    
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    //平移
    keyAnima.keyPath = @"position";
    //1.1告诉系统要执行什么动画
    //创建一条路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置一个圆的路径
    CGPathAddEllipseInRect(path, NULL, CGRectMake(50, 200, MAINSCREENWIDTH - 100, MAINSCREENWIDTH - 100));
    keyAnima.path = path;
    
    //有create就一定要有release
    CGPathRelease(path);
    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion = NO;
    //1.3设置保存动画的最新状态
    keyAnima.fillMode = kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyAnima.duration = 3.0;
    //1.5设置动画的节奏
    keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //设置动画的重复次数(设置为最大值)
    keyAnima.repeatCount = MAXFLOAT;
    //设置代理，开始—结束
    keyAnima.delegate = self;
    //2.添加核心动画
    [self.imageView.layer addAnimation:keyAnima forKey:nil];
}

- (IBAction)animation4:(id)sender {
    
    //1.创建动画
    CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"transform"];
    //1.1设置动画执行时间
    anima.duration = 3.0;
    //1.2修改属性，执行动画
    anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI*2 - 1.101, 0.5, 0.5, 0.5)];
    //1.3设置动画执行完毕后不删除动画
    anima.removedOnCompletion = NO;
    //1.4设置保存动画的最新状态
    anima.fillMode = kCAFillModeForwards;
    anima.repeatCount = MAXFLOAT;
    //2.添加动画到layer
    [self.imageView.layer addAnimation:anima forKey:nil];
}

//图片亮度
- (UIImage*) getBrighterImage:(UIImage *)originalImage
{
    
    UIImage *brighterImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:originalImage.CGImage];
    
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:inputImage forKey:kCIInputImageKey];
    NSValue * va1 = [lighten valueForKey:@"inputBrightness"];
    NSLog(@"lighten--value-:%@",va1);
//    [lighten setValue:@(1) forKey:@"inputBrightness"];
    NSValue * va2 = [lighten valueForKey:@"inputBrightness"];
    NSLog(@"lighten--value-:%@",va2);

    //  饱和度      0---2
//    [lighten setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputSaturation"];
    //  亮度  10   -1---1
//    [lighten setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputBrightness"];
    //  对比度 -11  0---4
    [lighten setValue:[NSNumber numberWithFloat:4] forKey:@"inputContrast"];
    
    CIImage *result = [lighten valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    brighterImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return brighterImage;
}

#pragma mark CAAnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"开始动画");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"结束动画");
//    [self.imageView.layer addAnimation:keyAnima forKey:@"imageViewAnimation2"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    TouchView *tv=[[TouchView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    tv.backgroundColor=[UIColor redColor];
////    tv.pointArray = [NSArray arrayWithObjects:, nil]
//    [self.view addSubview:tv];
    
//   UIImage * imagee = [self getBrighterImage:[UIImage imageNamed:@"manualInputView1"]];
    
    self.imageView.image = [UIImage imageNamed:@"image1.jpg"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    NSLog(@"屏幕亮度: %f",[[UIScreen mainScreen] brightness]);

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.imageView.layer removeAllAnimations];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
