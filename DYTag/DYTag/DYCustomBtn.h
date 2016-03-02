//
//  DYCustomBtn.h
//  DYTag
//
//  Created by huangdeyu on 16/1/21.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,DYBtnStatus) {
    DYBtnStatusNormal,
    DYBtnStatusChoosed
};
@interface DYCustomBtn : UIButton
@property(nonatomic,assign) DYBtnStatus status;
@property(nonatomic,assign) BOOL isArranged;    //位置已经被安排好的标志位

-(void)setupWithTitle:(NSString *)title andOrgin:(CGPoint) orgin andMaxWidth:(CGFloat)maxWidth;
@end
