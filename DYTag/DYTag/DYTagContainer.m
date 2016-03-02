//
//  DYTagContainer.m
//  DYTag
//
//  Created by huangdeyu on 16/1/21.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import "DYTagContainer.h"
#import "DYCustomBtn.h"
#define SW ([UIScreen mainScreen].bounds.size.width)
#define SH ([UIScreen mainScreen].bounds.size.height)
#define SELFWIDTH self.frame.size.width
@implementation DYTagContainer
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.buttontags = [NSMutableArray array];
        self.currentChoosedText = [NSMutableArray array];
        NSArray * titles = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tags" ofType:@"plist"]];
        [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DYCustomBtn * customBtn = [DYCustomBtn buttonWithType:UIButtonTypeSystem];
            [customBtn setupWithTitle:obj andOrgin:CGPointMake(0, 0) andMaxWidth:frame.size.width];    //先初始化为0，0位置，再计算位置。
            customBtn.tag = idx;
            [customBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:customBtn];
            [self.buttontags addObject:customBtn];
        }];
        [self caculatePos2];
    }
    return self;
}
-(void)caculatePos{
    [self.buttontags sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        DYCustomBtn * btn1 = obj1;
        DYCustomBtn * btn2 = obj2;
        return btn1.frame.size.width < btn2.frame.size.width;
    }];

    float lastWidth = 0;
    float currentFrameHeight = 0;
    float currentHeight = 0;
    for (int i = 0; i < self.buttontags.count; i++) {
        DYCustomBtn * btn = self.buttontags[i];
        if (lastWidth == 0 && !btn.isArranged) {
            btn.frame = CGRectMake(0,  currentFrameHeight, btn.frame.size.width, btn.frame.size.height);
            lastWidth += btn.frame.size.width;
            btn.isArranged = YES;
            currentHeight  = btn.frame.size.height;
        }
        for (int k = i+1; k <self.buttontags.count ; k++) {
            DYCustomBtn * btnK = self.buttontags[k];
            if (!btnK.isArranged) { //已经排列好的标签不在计算返回内。
                if (btnK.frame.size.width + lastWidth < SELFWIDTH) {
                    if (lastWidth == 0) {
                         btnK.frame = CGRectMake(lastWidth,  currentFrameHeight, btnK.frame.size.width, btnK.frame.size.height);
                    }else{
                         btnK.frame = CGRectMake(lastWidth + 10, currentFrameHeight, btnK.frame.size.width, btnK.frame.size.height);
                    }
                    lastWidth += btnK.frame.size.width + 10;
                    btnK.isArranged = YES;
                    currentHeight = btn.frame.size.height;
                }
            }
        }
        lastWidth = 0;
        currentFrameHeight += currentHeight + 8;
        currentHeight = 0;
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, currentFrameHeight);
    NSLog(@"排列完成");
}

-(void)caculatePos2{
    float heightPos = 0;
    float widthPos = 0;
    float spaceHor = 5;
    float spaceVer = 5;
    for (int i = 0; i < self.buttontags.count; i++) {
        DYCustomBtn * buttonI = self.buttontags[i];
        if (!buttonI.isArranged) {
            buttonI.isArranged = YES;
            buttonI.frame = CGRectMake(0, heightPos, buttonI.frame.size.width, buttonI.frame.size.height);
            widthPos = buttonI.frame.size.width + spaceHor;
            float testHeight = buttonI.frame.size.height;
            for (int k = i+1; k < self.buttontags.count ; k++) {
                DYCustomBtn * buttonK = self.buttontags[k];
                if (!buttonK.isArranged) {
                    if (buttonK.frame.size.width + widthPos < self.frame.size.width) {
                        buttonK.isArranged = YES;
                        buttonK.frame = CGRectMake(widthPos, heightPos, buttonK.frame.size.width, buttonK.frame.size.height);
                        widthPos += buttonK.frame.size.width + spaceHor;
                    }
                }
            }
            heightPos += testHeight  + spaceVer;

        }
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, heightPos);
}

#pragma mark -action
-(void)buttonClicked:(UIButton *)button{
    if (button.tag < 0) {
    }else{
        DYCustomBtn * btn = (DYCustomBtn *)button;
        switch (btn.status) {
            case DYBtnStatusNormal:
                btn.status = DYBtnStatusChoosed;
                [self.currentChoosedText addObject:btn.titleLabel.text];
                [self.delegate ChooseTags:self.currentChoosedText];
                break;
            case DYBtnStatusChoosed:
                btn.status = DYBtnStatusNormal;
                [self.currentChoosedText removeObject:btn.titleLabel.text];
                [self.delegate ChooseTags:self.currentChoosedText];
                break;
            default:
                break;
        }
    }
}

@end
