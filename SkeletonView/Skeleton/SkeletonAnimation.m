//
//  SkeletonAnimation.m
//  SkeletonView
//
//  Created by 王瑞果 on 2018/10/19.
//  Copyright © 2018年 Ruiguo Wang. All rights reserved.
//

#import "SkeletonAnimation.h"

#define COLOR_RGBA(r, g, b) [UIColor colorWithRed:(r / 255.f) green:(g / 255.f) blue:(b / 255.f) alpha:1.0]
#define COLOR_LIGHT COLOR_RGBA(201, 214, 222)
#define COLOR_DARK COLOR_RGBA(109, 134, 150)

@interface SkeletonAnimation ()

@end

@implementation SkeletonAnimation

+ (SkeletonAnimation *)sharedSkeletonAnimation {
    static SkeletonAnimation *_skeletonAnimation;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _skeletonAnimation = [[SkeletonAnimation alloc] init];
    });
    return _skeletonAnimation;
}

- (void)beginOrEndAnimationForView:(UIView *)view {
    
    // 添加动画
    switch (view.skeletonStatus) {
            
        case SkeletonStatusBegin: {
            view.skeletonStatus = SkeletonStatusRunning;
            for (UIView *subview in view.subviews) {
                if (subview.skeletonStyle != SkeletonStyDefault) {
                    subview.skeletonable = YES;
                    [self addLayerAnimationWithView:subview superview:view];
                }
            }
            break;
        }
            
        // 移除动画
        case SkeletonStatusEnd: {
            for (UIView *subview in view.subviews) {
                if (subview.skeletonable == YES) {
                    subview.skeletonable = NO;
                    for (CALayer *sublayer in subview.layer.sublayers) {
                        [sublayer removeFromSuperlayer];
                    }
                }
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)addLayerAnimationWithView:(UIView *)view superview:(UIView *)superview {
    
    switch (view.skeletonStyle) {
        case SkeletonStyleFlex: {
            [self addFlexAnimationToView:view];
            break;
        }
            
        case SkeletonStyleGradient: {
            [self addGradientAnimationToView:view];
            break;
        }
            
        case SkeletonStyleShine: {
            [self addShineAnimationToView:view];
            break;
        }
            
        default:
            break;
    }
    
}


/**
 伸缩动画的实现

 @param view 添加到 view.layer
 */
- (void)addFlexAnimationToView:(UIView *)view {
    
    CALayer *layer = [[CALayer alloc] init];
    [view.layer addSublayer:layer];
    layer.frame = CGRectMake(0, 0, view.width, view.height);
    layer.backgroundColor = COLOR_LIGHT.CGColor;
    layer.anchorPoint = CGPointMake(0, 0);
    layer.position = CGPointMake(0, 0);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.removedOnCompletion = NO;
    animation.duration = 1.0;
    animation.autoreverses = YES;
    animation.repeatCount = MAXFLOAT;
    animation.fromValue = [NSNumber numberWithFloat:0.8];
    animation.toValue = [NSNumber numberWithFloat:1.2];
    [layer addAnimation:animation forKey:nil];
}

/**
 高亮从左到右动画的实现
 
 @param view 添加到 view.layer
 */
- (void)addGradientAnimationToView:(UIView *)view {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [view.layer addSublayer:gradientLayer];
    gradientLayer.frame = CGRectMake(0, 0, view.width, view.height);
    NSArray *colors = @[(id)COLOR_LIGHT.CGColor, (id)COLOR_DARK.CGColor, (id)COLOR_LIGHT.CGColor];
    gradientLayer.colors = colors;
    gradientLayer.locations = @[@-0.9, @-0.6, @-0.3];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.6);
    gradientLayer.type = kCAGradientLayerAxial;
    
    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradientAnimation.fromValue = @[@-0.9, @-0.6, @-0.3];
    gradientAnimation.toValue = @[@1.3, @1.6, @1.9];
    gradientAnimation.duration = 1.0;
    gradientAnimation.repeatCount = MAXFLOAT;
    [gradientLayer addAnimation:gradientAnimation forKey:nil];
}

/**
 高亮闪烁动画的实现
 
 @param view 添加到 view.layer
 */
- (void)addShineAnimationToView:(UIView *)view {
    
    CALayer *shineLayer = [[CALayer alloc] init];
    [view.layer addSublayer:shineLayer];
    shineLayer.frame = CGRectMake(0, 0, view.width, view.height);
    shineLayer.backgroundColor = COLOR_DARK.CGColor;
    shineLayer.anchorPoint = CGPointMake(0, 0);
    shineLayer.position = CGPointMake(0, 0);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.fromValue = (id)COLOR_DARK.CGColor;
    animation.toValue = (id)COLOR_LIGHT.CGColor;
    animation.duration = 1.0;
    animation.repeatCount = MAXFLOAT;
    animation.autoreverses = YES;
    [shineLayer addAnimation:animation forKey:nil];
}

@end
