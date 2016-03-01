//
//  DYTitleView.h
//  类网易新闻横向滑动的实现方案2
//
//  Created by huangdeyu on 16/2/23.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYTitleView : UIScrollView
@property(nonatomic,copy) void (^buttonClickBlock)(UIButton * button);
-(instancetype)initWithTitles:(NSArray *)titles frame:(CGRect)frame;
@property(nonatomic,assign)CGFloat currentOffset;
@end
