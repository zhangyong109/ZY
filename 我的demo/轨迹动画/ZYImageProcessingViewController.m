//
//  ZYImageProcessingViewController.m
//  轨迹动画
//
//  Created by ZY on 15/7/22.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ZYImageProcessingViewController.h"

@interface ZYImageProcessingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *containV;

@property (strong, nonatomic) CAGradientLayer *shadomLayer;
@end

@implementation ZYImageProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    CGPoint po = CGPointMake(self.view.layer.anchorPoint.x, self.view.layer.anchorPoint.y);
    NSLog(@"po:%f--%f",po.x,po.y);
    self.imageView1.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.imageView1.layer.anchorPoint = CGPointMake(0.5,1);
    self.imageView2.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    self.imageView2.layer.anchorPoint = CGPointMake(0.5,0);

    self.containV.userInteractionEnabled = YES;

    // 创建渐变图层
    CAGradientLayer *shadomLayer = [CAGradientLayer layer];
    // 设置渐变颜色
    shadomLayer.colors = @[(id)[UIColor clearColor],(id)[[UIColor blackColor] CGColor]];
    shadomLayer.frame = _imageView2.bounds;
    _shadomLayer = shadomLayer;
    // 设置不透明度 0
    shadomLayer.opacity = 0;
    [_imageView2.layer addSublayer:shadomLayer];
}
- (IBAction)panImage:(id)sender {
    
    // 获取手指偏移量
    CGPoint transP = [sender translationInView:_containV];
    // 初始化形变
    CATransform3D transform3D = CATransform3DIdentity;
    
    // 设置立体效果
    // 设置M34就有立体感(近大远小)。 -1 / z ,z表示观察者在z轴上的值,z越小，看起来离我们越近，东西越大。
    transform3D.m34 = -1 / 2000.0;
    // 计算折叠角度，因为需要逆时针旋转，所以取反
    CGFloat angle = -transP.y / 110.0 * M_PI;
    
    // 设置阴影不透明度
    _shadomLayer.opacity = transP.y * 1 /  110.0;
    
    _imageView1.layer.transform = CATransform3DRotate(transform3D, angle, 1, 0, 0);
    //    为了让折叠效果更加有效果，更加具有立体感，可以给形变设置m34属性，就能添加立体感。
    
    UIPanGestureRecognizer *sender1 = sender;
    if (sender1.state == UIGestureRecognizerStateEnded) {
        // 还原
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            _imageView1.layer.transform = CATransform3DIdentity;
            // 还原阴影
            _shadomLayer.opacity = 0;
        } completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
