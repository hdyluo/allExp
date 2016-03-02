//
//  DYCustomBtn.m
//  DYTag
//
//  Created by huangdeyu on 16/1/21.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import "DYCustomBtn.h"

#define TITLECOLOR [UIColor whiteColor]
#define FONTSIZE 15


@implementation DYCustomBtn


-(void)setupWithTitle:(NSString *)title andOrgin:(CGPoint) orgin andMaxWidth:(CGFloat)maxWidth{
    self.status = DYBtnStatusNormal;
    self.backgroundColor = [UIColor orangeColor];
    NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:FONTSIZE]};
    CGRect rect = [title boundingRectWithSize:CGSizeMake(maxWidth - 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    self.frame = CGRectMake(orgin.x, orgin.y, rect.size.width+16, rect.size.height+10);
    self.layer.cornerRadius = self.frame.size.height * 0.5;
    [self setTitleColor:TITLECOLOR forState:UIControlStateNormal];
    self.titleLabel.numberOfLines = 10;
    [self.titleLabel setFont:[UIFont systemFontOfSize:FONTSIZE]];
    [self setTitle:title forState:UIControlStateNormal];
    self.isArranged = NO;
}


-(void)setStatus:(DYBtnStatus)status{
    _status = status;
    switch (status) {
        case DYBtnStatusNormal:
            [self handleTagNormal];
            break;
        case DYBtnStatusChoosed:
           [ self handleTagChooseState];
            break;
        default:
            break;
    }
}
-(void)handleTagChooseState{
    self.backgroundColor = [UIColor grayColor];
}
-(void)handleTagNormal{
    self.backgroundColor = [UIColor orangeColor];
}
#pragma mark - 初始化


@end
