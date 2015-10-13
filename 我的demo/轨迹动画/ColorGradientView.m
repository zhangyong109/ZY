//
//  ColorGradientView.m
//  轨迹动画
//
//  Created by ZY on 15/10/13.
//  Copyright © 2015年 ZY. All rights reserved.
//

#import "ColorGradientView.h"

NSString *animateGradient = @"animateGradient";

@implementation ColorGradientView

- (void)dealloc {
    _animating = NO;
}

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        // Use a horizontal gradient
        
        CAGradientLayer *layer = (id)[self layer];
        [layer setStartPoint:CGPointMake(0.0, 0.5)];
        [layer setEndPoint:CGPointMake(1.0, 0.5)];
        
        // Create the gradient colors using hues in 5 degree increments
        
        NSMutableArray *colors = [NSMutableArray array];
        for (NSInteger deg = 0; deg <= 360; deg += 50) {
            
            UIColor *color;
            color = [UIColor colorWithHue:1.0 * deg / 360.0
                               saturation:1.0
                               brightness:1.0
                                    alpha:1.0];
            [colors addObject:(id)[color CGColor]];
        }
        [layer setColors:[NSArray arrayWithArray:colors]];
        
        // Create another layer to use as a mask. The width of this layer will
        // be modified to reflect the current progress value.
        
        _maskLayer = [CALayer layer];
        [_maskLayer setFrame:CGRectMake(0, 0, 0, frame.size.height)];
        [_maskLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
        [layer setMask:_maskLayer];
    }
    return self;
}

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (void)setProgress:(CGFloat)value {
    
    if (_progress != value) {
        
        // progress values go from 0.0 to 1.0
        
        _progress = MIN(1.0, fabs(value));
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    
    // Resize our mask layer based on the current progress
    
    CGRect maskRect = [_maskLayer frame];
    maskRect.size.width = CGRectGetWidth([self bounds]) * _progress;
    [_maskLayer setFrame:maskRect];
}

- (NSArray *)shiftColors:(NSArray *)colors {
    
    // Moves the last item in the array to the front
    // shifting all the other elements.
    
    NSMutableArray *mutable = [colors mutableCopy];
    id last = [mutable lastObject];
    [mutable removeLastObject];
    [mutable insertObject:last atIndex:0];
    return [NSArray arrayWithArray:mutable];
}

- (void)performAnimation {
    
    // Update the colors on the model layer
    
    CAGradientLayer *layer = (id)[self layer];
    NSArray *fromColors = [layer colors];
    NSArray *toColors = [self shiftColors:fromColors];
    [layer setColors:toColors];
    
    // Create an animation to slowly move the hue gradient left to right.
    
    CABasicAnimation *animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setFromValue:fromColors];
    [animation setToValue:toColors];
    [animation setDuration:0.08];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setDelegate:self];
    
    // Add the animation to our layer
    
    [layer addAnimation:animation forKey:animateGradient];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    if ([self isAnimating]) {
        [self performAnimation];
    }
}

- (void)startAnimating {
    
    if (![self isAnimating]) {
        
        _animating = YES;
        
        [self performAnimation];
    }
}

- (void)stopAnimating {
    
    if ([self isAnimating]) {
        
        _animating = NO;
    }
}


@end
