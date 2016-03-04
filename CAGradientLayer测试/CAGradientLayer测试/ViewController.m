//
//  ViewController.m
//  CAGradientLayer测试
//
//  Created by huangdeyu on 16/3/3.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer * layer = [[CAGradientLayer alloc] init];
    layer.colors = @[[UIColor grayColor],[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
