//
//  RegisterView.h
//  SHRegister
//
//  Created by huangdeyu on 16/3/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisgerViewDelegate <NSObject>

@required
-(void)registerBtnsClicked:(UIButton *)button message:(NSString *)message;

@end


@interface RegisterView : UIView
@property(nonatomic,strong) NSMutableArray * upButtons;
@property(nonatomic,strong)NSMutableArray * bgImages;
@property(nonatomic,strong)CALayer * bgLayer;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,assign) NSInteger currentBtn;

@property(nonatomic,copy) void (^buttonClickedBlock)(UIButton *);
@property(nonatomic,weak) id<RegisgerViewDelegate> delegate;
@end
