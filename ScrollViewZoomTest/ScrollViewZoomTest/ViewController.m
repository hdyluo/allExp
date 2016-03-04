//
//  ViewController.m
//  ScrollViewZoomTest
//
//  Created by huangdeyu on 16/3/4.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "ViewController.h"
#import "KWindowView.h"

@interface ViewController ()
@property(nonatomic,strong) UIView * horView;
@property(nonatomic,assign) BOOL needExit;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.layer.borderWidth = 1.0;
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.center = self.view.center;
    self.horView = [[UIView alloc] init];
    self.horView.frame = CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 40, 200);
    [self.view addSubview:self.horView];
    self.horView.backgroundColor = [UIColor orangeColor];
    self.horView.userInteractionEnabled = YES;
    self.horView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.horView.layer.shadowRadius = 5.0;
    self.horView.layer.shadowOpacity = 1.0;
    self.horView.layer.shadowOffset = CGSizeMake(0, 0);
    self.needExit = NO;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.horView addGestureRecognizer:tapGesture];
}
-(void)tapped:(UIGestureRecognizer *)gesture{
    
    if (!self.needExit) {
        self.needExit = YES;
        float value = 1.0;
        switch ([UIDevice currentDevice].orientation) {
            case UIDeviceOrientationLandscapeLeft:
                value = 1.0;
                break;
            case UIDeviceOrientationLandscapeRight:
                value = -1.0;
                break;
            default:
                break;
        }
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.horView.transform = CGAffineTransformMakeRotation(M_PI_2 * value);
            self.horView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.horView.transform = CGAffineTransformIdentity;
            self.horView.frame = CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 40, 200);
        } completion:^(BOOL finished) {
            self.needExit = NO;
        }];
    }
    
}

-(void)buttonClicked:(UIButton *)button{
//    KWindowView * kv = [[KWindowView alloc] initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 200)];
//    [kv show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
