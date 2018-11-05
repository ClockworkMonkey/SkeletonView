//
//  ViewController.m
//  SkeletonView
//
//  Created by 王瑞果 on 2018/10/18.
//  Copyright © 2018年 Ruiguo Wang. All rights reserved.
//

#import "ViewController.h"
#import "SkeletonAnimation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testDemo];
}

- (void)testDemo {
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(50, 200, 250, 70)];
    [self.view addSubview:aView];
    aView.skeletonStyle = SkeletonStyleFlex;
    
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(50, 350, 250, 70)];
    [self.view addSubview:bView];
    bView.skeletonStyle = SkeletonStyleGradient;
    
    UIView *cView = [[UIView alloc] initWithFrame:CGRectMake(50, 500, 250, 70)];
    [self.view addSubview:cView];
    cView.skeletonStyle = SkeletonStyleShine;
    
    
    self.view.skeletonStatus = SkeletonStatusBegin;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.view.skeletonStatus = SkeletonStatusEnd;
        [self.view layoutSubviews];
        aView.backgroundColor = [UIColor orangeColor];
        bView.backgroundColor = [UIColor orangeColor];
        cView.backgroundColor = [UIColor orangeColor];
    });
}

@end
