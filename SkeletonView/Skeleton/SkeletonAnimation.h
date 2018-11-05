//
//  SkeletonAnimation.h
//  SkeletonView
//
//  Created by 王瑞果 on 2018/10/19.
//  Copyright © 2018年 Ruiguo Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+Skeleton.h"
#import "UIView+Rect.h"

NS_ASSUME_NONNULL_BEGIN

@interface SkeletonAnimation : NSObject
+ (SkeletonAnimation *)sharedSkeletonAnimation;
- (void)beginOrEndAnimationForView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
