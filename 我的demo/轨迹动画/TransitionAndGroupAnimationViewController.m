//
//  TransitionAndGroupAnimationViewController.m
//  轨迹动画
//
//  Created by ZY on 15/7/13.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "TransitionAndGroupAnimationViewController.h"

@interface TransitionAndGroupAnimationViewController ()

@property(nonatomic,assign) int index;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation TransitionAndGroupAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.index = 1;
    self.iconView.image = [UIImage imageNamed: [NSString stringWithFormat:@"image%d.jpg",self.index]];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.iconView.layer removeAllAnimations];
}

#pragma mark  CATransition
/*!
 转场动画简单介绍
 
 CAAnimation的子类，用于做转场动画，能够为层提供移出屏幕和移入屏幕的动画效果。iOS比Mac OS X的转场动画效果少一点
 
 UINavigationController就是通过CATransition实现了将控制器的视图推入屏幕的动画效果
 
 属性解析:
 
 type：动画过渡类型
 
 subtype：动画过渡方向
 
 startProgress：动画起点(在整体动画的百分比)
 
 endProgress：动画终点(在整体动画的百分比)
 */

- (IBAction)preOnClick:(UIButton *)sender {
    
    self.index--;
    if (self.index < 1) {
        self.index = 4;
    }
    self.iconView.image = [UIImage imageNamed: [NSString stringWithFormat:@"image%d.jpg",self.index]];
    
    //创建核心动画
    CATransition *ca = [CATransition animation];
    //告诉要执行什么动画
    //设置过度效果
    
    /* The name of the transition. Current legal transition types include
     * `fade', `moveIn', `push' and `reveal'. Defaults to `fade'. */
    
    ca.type = @"cube";
//    ca.type = @"moveIn";
    //设置动画的过度方向（向左）
    ca.subtype = kCATransitionFromLeft;
    //设置动画的时间
    ca.duration = 2.0;
    //添加动画
    [self.iconView.layer addAnimation:ca forKey:nil];
    
}

- (IBAction)nextOnClick:(UIButton *)sender {
    
    self.index++;
    if (self.index > 4) {
        self.index = 1;
    }
    self.iconView.image = [UIImage imageNamed: [NSString stringWithFormat:@"image%d.jpg",self.index]];
    
    //1.创建核心动画
    CATransition *ca = [CATransition animation];
    
    //1.1告诉要执行什么动画
    //1.2设置过度效果
    ca.type = @"cube";
//    ca.type = @"moveIn";

    //1.3设置动画的过度方向（向右）
    ca.subtype = kCATransitionFromRight;
    //1.4设置动画的时间
    ca.duration = 2.0;
    //1.5设置动画的起点
//    ca.startProgress = 0.5;
    //1.6设置动画的终点
    //    ca.endProgress=0.5;
    
    //2.添加动画
    [self.iconView.layer addAnimation:ca forKey:nil];
    
}

#pragma mark  CAAnimationGroup

/*!
 组动画简单说明
 
 CAAnimation的子类，可以保存一组动画对象，将CAAnimationGroup对象加入层后，组中所有动画对象可以同时并发运行
 
 属性解析：
 
 animations：用来保存一组动画对象的NSArray
 
 默认情况下，一组动画对象是同时运行的，也可以通过设置动画对象的beginTime属性来更改动画的开始时间
*/
- (IBAction)groupAnimation:(UIButton *)sender {
    // 平移动画
    CABasicAnimation *a1 = [CABasicAnimation animation];
    a1.keyPath = @"transform.translation.y";
    a1.toValue = @(100);
    // 缩放动画
    CABasicAnimation *a2 = [CABasicAnimation animation];
    a2.keyPath = @"transform.scale";
    a2.toValue = @(0.0);
    // 旋转动画
    CABasicAnimation *a3 = [CABasicAnimation animation];
    a3.keyPath = @"transform.rotation";
    a3.toValue = @(M_PI);
    
    // 组动画
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    
    groupAnima.animations = @[a1, a2, a3];
    
    //设置组动画的时间
    groupAnima.duration = 2;
    groupAnima.fillMode = kCAFillModeRemoved;//kCAFillModeForwards
    groupAnima.removedOnCompletion = NO;
    
    groupAnima.delegate = self;
    [self.iconView.layer addAnimation:groupAnima forKey:nil];
}



#pragma mark CAAnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"开始动画");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"结束动画");
    //    [self.imageView.layer addAnimation:keyAnima forKey:@"imageViewAnimation2"];
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
