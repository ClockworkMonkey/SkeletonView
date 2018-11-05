//
//  UIView+Skeleton.m
//  SkeletonView
//
//  Created by Rango on 5/11/2018.
//  Copyright © 2018 Ruiguo Wang. All rights reserved.
//

#import "UIView+Skeleton.h"
#import "SkeletonAnimation.h"
#import <objc/runtime.h>

@implementation UIView (Skeleton)

- (BOOL)skeletonable {
    BOOL skeletonable = objc_getAssociatedObject(self, @selector(skeletonable));
    return skeletonable;
}

- (void)setSkeletonable:(BOOL)skeletonable {
    objc_setAssociatedObject(self, @selector(skeletonable), @(skeletonable), OBJC_ASSOCIATION_ASSIGN);
}

- (SkeletonStyle)skeletonStyle {
    NSNumber *value = objc_getAssociatedObject(self, @selector(skeletonStyle));
    return value.unsignedIntegerValue;
}

- (void)setSkeletonStyle:(SkeletonStyle)skeletonStyle {
    objc_setAssociatedObject(self, @selector(skeletonStyle), @(skeletonStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (SkeletonStatus)skeletonStatus {
    NSNumber *value = objc_getAssociatedObject(self, @selector(skeletonStatus));
    return value.unsignedIntegerValue;
}

- (void)setSkeletonStatus:(SkeletonStatus)skeletonStatus {
    objc_setAssociatedObject(self, @selector(skeletonStatus), @(skeletonStatus), OBJC_ASSOCIATION_ASSIGN);
}


/**
 交换 layoutSubviews 和 layoutSkeletonViews 方法
 */
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod([self class], @selector(layoutSubviews));
        Method newMethod = class_getInstanceMethod([self class], @selector(layoutSkeletonViews));
        IMP newIMP = method_getImplementation(newMethod);
        BOOL isAdd = class_addMethod([self class], @selector(layoutSkeletonViews), newIMP, method_getTypeEncoding(newMethod));
        if (isAdd) {
            class_replaceMethod([self class], @selector(layoutSubviews), newIMP, method_getTypeEncoding(newMethod));
        } else {
            method_exchangeImplementations(originMethod, newMethod);
        }
    });
}

/**
 开始或移除动画
 */
- (void)layoutSkeletonViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.skeletonStatus != SkeletonStatusRunning ) {
            [[SkeletonAnimation sharedSkeletonAnimation] beginOrEndAnimationForView:self];
        }
    });
}

@end
