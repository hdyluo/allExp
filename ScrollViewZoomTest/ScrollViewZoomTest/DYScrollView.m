//
//  DYScrollView.m
//  ScrollViewZoomTest
//
//  Created by huangdeyu on 16/3/4.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "DYScrollView.h"

@interface DYScrollView()
@property(nonatomic,strong)UIButton * button;
@property(nonatomic,assign)BOOL isHorizontal;
@end

@implementation DYScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowRadius = 5.0;
        self.isHorizontal = NO;
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

-(UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
       // _button.backgroundColor = [UIColor redColor];
        [_button setTitle:@"点我" forState:UIControlStateNormal];
    }
    return _button;
}
@end
