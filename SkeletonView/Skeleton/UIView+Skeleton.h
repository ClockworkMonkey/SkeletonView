//
//  UIView+Skeleton.h
//  SkeletonView
//
//  Created by Rango on 5/11/2018.
//  Copyright © 2018 Ruiguo Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Skeleton 动画类型

 - SkeletonStyDefault: 默认没有动画
 - SkeletonStyleFlex: 长短伸缩
 - SkeletonStyleGradient: 高亮从左到右
 - SkeletonStyleShine: 高亮闪烁
 */
typedef NS_ENUM(NSUInteger, SkeletonStyle) {
    SkeletonStyDefault = 0,
    SkeletonStyleFlex,
    SkeletonStyleGradient,
    SkeletonStyleShine
};

/**
 Skeleton 动画状态

 - SkeletonStatusDefault: 默认
 - SkeletonStatusBegin: 开始
 - SkeletonStatusRunning: 正在进行
 - SkeletonStatusEnd: 结束
 */
typedef NS_ENUM(NSUInteger, SkeletonStatus) {
    SkeletonStatusDefault = 0,
    SkeletonStatusBegin,
    SkeletonStatusRunning,
    SkeletonStatusEnd
};

@interface UIView (Skeleton)

/**
 View 是否需要 skeleton 动画
 */
@property (nonatomic, assign) BOOL skeletonable;

/**
 Skeleton 动画类型
 */
@property (nonatomic, assign) SkeletonStyle skeletonStyle;

/**
 Skeleton 动画状态
 */
@property (nonatomic, assign) SkeletonStatus skeletonStatus;

@end

NS_ASSUME_NONNULL_END
