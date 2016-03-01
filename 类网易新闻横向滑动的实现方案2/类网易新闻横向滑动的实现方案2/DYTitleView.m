//
//  DYTitleView.m
//  类网易新闻横向滑动的实现方案2
//
//  Created by huangdeyu on 16/2/23.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import "DYTitleView.h"

#define SW [UIScreen mainScreen].bounds.size.width
#define SH [UIScreen mainScreen].bounds.size.height
#define SELECTSCALE 1.2

@interface DYTitleView()
@property(nonatomic,assign)NSInteger currentTitleIndex;

@property(nonatomic,strong)NSMutableArray * titleButtons;
@property(nonatomic,assign)CGFloat buttonWidth;
@property(nonatomic,strong)UIView * lineView;
@end

@implementation DYTitleView
-(instancetype)initWithTitles:(NSArray *)titles frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.currentTitleIndex = 0;
        
        self.titleButtons = [NSMutableArray array];
        
        if (titles.count < 5) {
            self.buttonWidth = SW / titles.count;
        }else{
            self.buttonWidth = SW / 4;
        }
        self.contentSize = CGSizeMake(self.buttonWidth * titles.count, 0);
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 3, self.buttonWidth, 3)];
        self.lineView.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.lineView];
        
        [titles  enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(self.buttonWidth * idx, 0, self.buttonWidth, frame.size.height);
            [self addSubview:button];
            [button setTitle:obj forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = idx;
            if (button.tag == self.currentTitleIndex) {
                [button setSelected:YES];
                button.transform = CGAffineTransformMakeScale(SELECTSCALE, SELECTSCALE);
            }
            [self.titleButtons addObject:button];
        }];
    }
    self.currentOffset = 0;
    return self;
}

#pragma mark - action
-(void)buttonClicked:(UIButton *)button{
    if (self.buttonClickBlock) {
        if (button.tag != self.currentTitleIndex) {
            [self.titleButtons[self.currentTitleIndex] setSelected:NO];
            UIButton * selectBtn = self.titleButtons[self.currentTitleIndex];
            selectBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            button.transform = CGAffineTransformMakeScale(SELECTSCALE, SELECTSCALE);
            self.currentTitleIndex = button.tag;
            [self.titleButtons[self.currentTitleIndex] setSelected:YES];
            [UIView animateWithDuration:0.3 animations:^{
                self.lineView.center = CGPointMake(self.buttonWidth * 0.5 + button.tag * self.buttonWidth, self.lineView.center.y);
            }];
        }
        self.buttonClickBlock(button);
    }
   
    NSLog(@"当前点击的标题是:%ld",button.tag);
}

#pragma  mark - setter
-(void)setCurrentOffset:(CGFloat)currentOffset{
    _currentOffset = currentOffset * self.buttonWidth / SW;
     self.lineView.center = CGPointMake(_currentOffset + self.buttonWidth * 0.5, self.lineView.center.y);
    UIButton * lastBtn = self.titleButtons[self.currentTitleIndex];
    CGFloat distance =  self.buttonWidth * lastBtn.tag;
    CGFloat offset = distance - _currentOffset;
  
    if (distance - _currentOffset < -self.buttonWidth / 2) {
        self.currentTitleIndex = lastBtn.tag+1;
        [lastBtn setSelected:NO];
        NSLog(@"当前tag是：%ld",self.currentTitleIndex);
    }else if(distance - _currentOffset > self.buttonWidth / 2){
        [lastBtn setSelected:NO];
        self.currentTitleIndex = lastBtn.tag-1;
    }else{
        float percent =  fabs(distance - _currentOffset) / (self.buttonWidth / 2) *(SELECTSCALE - 1.0);
        NSLog(@"当前偏移量是%f",percent);
        lastBtn.transform = CGAffineTransformMakeScale(SELECTSCALE - percent, SELECTSCALE- percent);
    }
    [self.titleButtons[self.currentTitleIndex] setSelected:YES];
   
}
@end
