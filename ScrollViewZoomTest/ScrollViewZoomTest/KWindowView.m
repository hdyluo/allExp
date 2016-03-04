//
//  KWindowView.m
//  ScrollViewZoomTest
//
//  Created by huangdeyu on 16/3/4.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "KWindowView.h"

@interface KWindowView()
@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong) UIImageView * imageView;
@end

@implementation KWindowView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

-(void)show{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    window.windowLevel = UIWindowLevelStatusBar + 10.0;//隐藏状态栏
    UIView * contentView = [[UIView alloc] init];
    contentView.frame = window.bounds;
    contentView.backgroundColor = [UIColor orangeColor];
    [window addSubview:contentView];
    [contentView addSubview:self];
    self.backgroundColor = [UIColor redColor];
}

@end
