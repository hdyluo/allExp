//
//  ViewController.m
//  DYDragBtn
//
//  Created by huangdeyu on 16/3/4.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong) UIDynamicAnimator * animator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(0, 0, 100, 100);
    self.button.center = self.view.center;
    self.button.layer.borderWidth = 1;
    self.button.backgroundColor = [UIColor blackColor];
    [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureComing:)];
    [self.button addGestureRecognizer:panGesture];
    [self.view addSubview:self.button];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

-(void)gestureComing:(UIGestureRecognizer *)gesture{
    static CGPoint beginPoint;// = [gesture locationInView:self.view];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self.animator removeAllBehaviors];
            beginPoint = [gesture locationInView:self.view];

            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint dragPoint = [gesture locationInView:self.view];
            self.button.center = CGPointMake(self.button.center.x + (dragPoint.x - beginPoint.x)* 1.0, self.button.center.y + (dragPoint.y - beginPoint.y) * 1.0);//乘以0.9的目的是拖动延后的效果
            beginPoint = dragPoint;

        }
           
            break;
        case UIGestureRecognizerStateEnded:{
            [self.animator removeAllBehaviors];
            CGPoint targetPos = self.button.center;
            if (targetPos.y < 200 || targetPos.y > self.view.frame.size.height - 200 ) {
                if (targetPos.y < 200) {
                    targetPos.y = self.button.frame.size.height * 0.5;
                }else{
                    targetPos.y= self.view.frame.size.height - self.button.frame.size.height * 0.5;
                }
            }else {
                if (targetPos.x < self.view.frame.size.width * 0.5) {
                    targetPos.x = self.button.frame.size.width * 0.5;
                }else{
                    targetPos.x = self.view.frame.size.width - self.button.frame.size.width * 0.5;
                }
            }
          
            UISnapBehavior * snapBehaivor = [[UISnapBehavior alloc] initWithItem:self.button snapToPoint:targetPos];
            snapBehaivor.damping = 1.0;
            [self.animator addBehavior:snapBehaivor];
        }
            break;
        default:
            break;
    }
}

-(void)buttonClicked:(UIButton *)button{
    NSLog(@"点击事件");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
