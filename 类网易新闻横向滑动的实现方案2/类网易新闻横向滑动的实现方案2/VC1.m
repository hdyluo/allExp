//
//  VC1.m
//  类网易新闻横向滑动的实现方案2
//
//  Created by huangdeyu on 16/2/23.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import "VC1.h"

@interface VC1 ()

@end

@implementation VC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.layer.borderWidth = 1;
    [self.view addSubview:button];
    button.center = self.view.center;
    NSLog(@"VC1执行viewDidLoad方法");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"VC1视图即将出现");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
