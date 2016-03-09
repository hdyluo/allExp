//
//  ViewController.m
//  SHRegister
//
//  Created by huangdeyu on 16/3/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "ViewController.h"
#import "FXBlurView.h"
#import "RegisterView.h"

#import "LineView.h"
@interface ViewController ()<RegisgerViewDelegate>
@property(nonatomic,strong)RegisterView * registerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerView = [[RegisterView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.registerView];
    self.registerView.delegate = self;
    [self registerClicked];
    
    
    CAShapeLayer * sharpLayer = [CAShapeLayer layer];
    sharpLayer.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3].CGColor;
    sharpLayer.lineWidth = 5;
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(100, 100)];
    sharpLayer.path = path.CGPath;
    [self.view.layer addSublayer:sharpLayer];
}


-(void)registerClicked{

    self.registerView.buttonClickedBlock = ^(UIButton * button){
        NSLog(@"当前点击的按钮是：%ld",button.tag);
    };
}


-(void)registerBtnsClicked:(UIButton *)button message:(NSString *)message{
    button.enabled = YES;
    if (message) {
        NSLog(@"当前消息是：%@",message);
    }else{
        NSLog(@"当前按钮的tag值是：%ld",button.tag);
        switch (button.tag) {
            case 100://需要进入第二页
                NSLog(@"模拟发送验证码成功");
                self.registerView.currentBtn = 1;
                break;
            case 101:
                NSLog(@"模拟重新发送验证码成功");
                self.registerView.currentBtn = 1;
                break;
            case 102://需要进入第三页
                NSLog(@"模拟验证成功");
                self.registerView.currentBtn = 2;
                break;
            case 104:
                NSLog(@"模拟注册成功");
            default:
                break;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
