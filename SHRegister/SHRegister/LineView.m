//
//  LineView.m
//  SHRegister
//
//  Created by huangdeyu on 16/3/9.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "LineView.h"

@implementation LineView
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        self.sharpLayer = [CAShapeLayer layer];
        self.sharpLayer.lineWidth = 3;
        self.sharpLayer.strokeColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:self.sharpLayer];
    }
    return self;
}
@end
