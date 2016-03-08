//
//  RegisterView.m
//  SHRegister
//
//  Created by huangdeyu on 16/3/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "RegisterView.h"
#import "FXBlurView.h"
#import <Masonry.h>
#define  RSW [UIScreen mainScreen].bounds.size.width
#define  RSH [UIScreen mainScreen].bounds.size.height
@interface RegisterView()<UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)FXBlurView * blurView;

@property(nonatomic,strong)UITextField * phoneNumTextField; //第一页中的电话号码
@property(nonatomic,strong)UITextField * codeTextField;     //第二页中的验证码
@property(nonatomic,strong)UITextField * pwdTextField;      //第三页中的密码
@property(nonatomic,strong)UITextField * verifyTextField;   //第三页中的确认密码

@property(nonatomic,strong)UIButton * getCodeBtn;       //第二页中的验证码倒计时按钮
@property(nonatomic,strong)NSTimer * timer;               //倒计时
@property(nonatomic,assign)NSInteger currentTime;       //当前时间
@end

@implementation RegisterView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.currentBtn = 0;
       
        self.bgLayer = [[CALayer alloc] init];
        self.bgLayer.frame = self.bounds;
        self.bgLayer.contents = (id)((UIImage *)self.bgImages[0]).CGImage;
        [self.layer addSublayer:self.bgLayer];
        
//        self.blurView.frame = frame;
//        self.blurView.blurRadius = 80;
//        self.blurView.tintColor = [UIColor clearColor];
//        self.blurView.dynamic = YES;
//        [self addSubview:self.blurView];
        int i = 0;
        CGFloat space = (RSW - 240 -40) / 2;
        for (UIButton * button in self.upButtons) {
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(20 + i * (space + 80));
                make.top.equalTo(self).offset(100);
            }];
            UILabel * label = [[UILabel alloc] init];
            [self addSubview:label];
            [label setFont:[UIFont systemFontOfSize:16]];
            label.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
            label.textAlignment = NSTextAlignmentCenter;
            switch (i) {
                case 0:
                    label.text = @"获取验证码";
                    break;
                case 1:
                    label.text = @"输入验证码";
                    break;
                case 2:
                    label.text = @"设置密码";
                    break;
                default:
                    break;
            }
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(button.mas_centerX);
                make.top.equalTo(button.mas_bottom).offset(10);
            }];
            i++;
        }
        [self setupScrollView];
    }
    return self;
}


#pragma mark - scrollView设置
-(void)setupScrollView{
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    //self.scrollView.scrollEnabled = NO;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(240, 0, 0, 0));
    }];
    
    UIView * content0 = [[UIView alloc] init];
    [self.scrollView addSubview:content0];
    [content0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView);
        make.bottom.equalTo(self.scrollView);
        make.width.mas_equalTo(RSW);
        make.height.mas_equalTo(200);
    }];
    
    self.phoneNumTextField = [[UITextField alloc] init];
    self.phoneNumTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    self.phoneNumTextField.placeholder = @"请输入手机号";
    [self.phoneNumTextField setFont:[UIFont systemFontOfSize:20]];
    self.phoneNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneNumTextField.returnKeyType = UIReturnKeyDone;
    self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTextField.textColor = [UIColor whiteColor];
    self.phoneNumTextField.delegate = self;
    [content0 addSubview:self.phoneNumTextField];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content0).offset(15);
        make.right.equalTo(content0).offset(-15);
        make.top.equalTo(content0).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    UIButton * button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button0 setTitle:@"获取验证码" forState:UIControlStateNormal];
    button0.layer.cornerRadius = 5.0;
    button0.layer.masksToBounds = YES;
    [button0.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [button0 setBackgroundColor:[UIColor blueColor]];
    button0.tag = 100;  //获取验证码的按钮的tag值是100
    [button0 addTarget:self action:@selector(getCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [content0 addSubview:button0];
    [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumTextField.mas_bottom).offset(15);
        make.left.equalTo(self.phoneNumTextField.mas_left);
        make.right.equalTo(self.phoneNumTextField.mas_right);
        make.height.mas_equalTo(55);
    }];
    [self setupPageTwo];
    [self setupPageThree];
}

-(void)setupPageTwo{
    UIView * content0 = [[UIView alloc] init];
    [self.scrollView addSubview:content0];
    [content0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_left).offset(RSW);
        make.top.equalTo(self.scrollView);
        make.bottom.equalTo(self.scrollView);
        make.width.mas_equalTo(RSW);
        make.height.mas_equalTo(200);
    }];
    
    self.codeTextField = [[UITextField alloc] init];
    self.codeTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    self.codeTextField.placeholder = @"请输入验证码";
    [self.codeTextField setFont:[UIFont systemFontOfSize:20]];
    self.codeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.codeTextField.returnKeyType = UIReturnKeyDone;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.textColor = [UIColor whiteColor];
    self.codeTextField.delegate = self;
    [content0 addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content0).offset(15);
        make.top.equalTo(content0).offset(0);
        make.height.mas_equalTo(55);
        make.width.mas_equalTo(RSW * 0.6);
    }];
    
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getCodeBtn setTitle:@"点击重发" forState:UIControlStateNormal];
    self.getCodeBtn.layer.cornerRadius = 5.0;
    self.getCodeBtn.layer.masksToBounds = YES;
    [self.getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.getCodeBtn setBackgroundColor:[UIColor blueColor]];
    self.getCodeBtn.tag = 101;      //重新获取验证码的tag值
    [self.getCodeBtn addTarget:self action:@selector(getCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [content0 addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextField.mas_top);
        make.left.equalTo(self.codeTextField.mas_right).offset(5);
        make.right.equalTo(content0.mas_right).offset(-15);
        make.height.mas_equalTo(55);
    }];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"确定" forState:UIControlStateNormal];
    button1.layer.cornerRadius = 5.0;
    button1.layer.masksToBounds = YES;
    [button1.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [button1 setBackgroundColor:[UIColor blueColor]];
    button1.tag = 102;          //验证验证码是否正确的tag值
    [button1 addTarget:self action:@selector(verifyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [content0 addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextField.mas_bottom).offset(15);
        make.left.equalTo(self.codeTextField.mas_left);
        make.right.equalTo(content0).offset(-15);
        make.height.mas_equalTo(55);
    }];
}

-(void)setupPageThree{
    
    UIView * content0 = [[UIView alloc] init];
    [self.scrollView addSubview:content0];
    [content0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(RSW * 2);
        make.top.equalTo(self.scrollView);
        make.bottom.equalTo(self.scrollView);
        make.width.mas_equalTo(RSW);
        make.height.mas_equalTo(200);
    }];
    
    self.pwdTextField = [[UITextField alloc] init];
    self.pwdTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    self.pwdTextField.placeholder = @"请输入密码";
    [self.pwdTextField setFont:[UIFont systemFontOfSize:20]];
    self.pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.pwdTextField.returnKeyType = UIReturnKeyDone;
    self.pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.pwdTextField.textColor = [UIColor whiteColor];
    self.pwdTextField.delegate = self;
    [content0 addSubview:self.pwdTextField];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content0).offset(15);
        make.right.equalTo(content0).offset(-15);
        make.top.equalTo(content0).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    
    self.verifyTextField = [[UITextField alloc] init];
    self.verifyTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    self.verifyTextField.placeholder = @"请确认密码";
    [self.verifyTextField setFont:[UIFont systemFontOfSize:20]];
    self.verifyTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.verifyTextField.returnKeyType = UIReturnKeyDone;
    self.verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.verifyTextField.textColor = [UIColor whiteColor];
    self.verifyTextField.delegate = self;
    [content0 addSubview:self.verifyTextField];
    [self.verifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content0).offset(15);
        make.right.equalTo(content0).offset(-15);
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(15);
        make.height.mas_equalTo(55);
    }];
    
    UIButton * button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button0 setTitle:@"完成" forState:UIControlStateNormal];
    button0.layer.cornerRadius = 5.0;
    button0.layer.masksToBounds = YES;
    [button0.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [button0 setBackgroundColor:[UIColor blueColor]];
    button0.tag = 104;
    [button0 addTarget:self action:@selector(registerOverBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [content0 addSubview:button0];
    [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyTextField.mas_bottom).offset(15);
        make.left.equalTo(self.verifyTextField.mas_left);
        make.right.equalTo(self.verifyTextField.mas_right);
        make.height.mas_equalTo(55);
    }];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}


#pragma mark - 文本框 delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}




#pragma mark - scrollView中的button点击
-(void)getCodeBtnClicked:(UIButton *)button{
    NSString * message = nil;
    button.enabled = NO;
    //这里需要提供正则表达式判断手机号是否合法
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length == 0) {
        message = @"手机号不能为空哦";
        button.enabled = YES;
        [self.delegate registerBtnsClicked:button message:message];
        return;
    }
    [self endEditing:YES];
    [self.delegate registerBtnsClicked:button message:nil];//委托结束后执行是否跳转到下一页
}
-(void)verifyBtnClicked:(UIButton *)button{
    NSString * msg = nil;
    button.enabled = NO;
    if (self.codeTextField.text == nil || self.codeTextField.text.length == 0) {
        button.enabled = YES;
        msg = @"请输入验证码";
        [self.delegate registerBtnsClicked:button message:msg];
        return;
    }
    [self endEditing:YES];
    [self.delegate registerBtnsClicked:button message:nil];//委托结束后执行是否跳转到下一页
}

-(void)registerOverBtnClicked:(UIButton *)button{
    button.enabled = NO;
    NSString * msg = nil;
    if (self.pwdTextField.text.length == 0 ) {
        msg = @"密码为空";
        [self.delegate registerBtnsClicked:button message:msg];
        return;
    }
    if (self.pwdTextField.text.length < 6) {
        msg = @"密码长度需要大于6位";
        [self.delegate  registerBtnsClicked:button message:msg];
        return;
    }
    if (self.verifyTextField.text.length == 0) {
        msg = @"请确认密码";
        [self.delegate registerBtnsClicked:button message:msg];
        return;
    }
    if (![self.verifyTextField.text isEqualToString:self.pwdTextField.text]) {
        msg = @"确认密码不匹配哦";
        [self.delegate  registerBtnsClicked:button message:msg];
        return;
    }
    [self.delegate registerBtnsClicked:button message:nil];
}
#pragma mark - 定时器 走表
-(void)startTimer{
    self.currentTime = 60;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerGo) userInfo:nil repeats:YES];
    self.getCodeBtn.enabled = NO;
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"倒计时%ld",self.currentTime] forState:UIControlStateNormal];
}
-(void)timerGo{
    self.currentTime--;
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"倒计时%ld",self.currentTime] forState:UIControlStateNormal];
    if (self.currentTime < 0) {
        self.currentTime = 0;
        [self stopTimer];
        self.getCodeBtn.enabled = YES;
        [self.getCodeBtn setTitle:@"点击重发" forState:UIControlStateNormal];
    }
}
-(void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"停止滚动");
}

#pragma mark - 上面的button 点击
-(void)buttonClicked:(UIButton *)button{
    [self endEditing:YES];
    if (self.currentBtn != button.tag) {
        self.currentBtn = button.tag;
        self.buttonClickedBlock(button);
    }
}
#pragma mark - setter 
-(void)setCurrentBtn:(NSInteger)currentBtn{
    if (currentBtn != _currentBtn) {
        _currentBtn = currentBtn;
        CABasicAnimation *animator = [CABasicAnimation animationWithKeyPath:@"contents"];
        animator.fromValue = self.bgLayer.contents;
        UIImage * contentImage = self.bgImages[_currentBtn];
        animator.toValue = (id)contentImage.CGImage;
        animator.duration = 1.0;
        self.bgLayer.contents = animator.toValue;
        [self.bgLayer addAnimation:animator forKey:nil];
    }
    
      UIButton * button = self.upButtons[_currentBtn];
        switch (_currentBtn) {
            case 0://获取验证码页面
                [self.scrollView setContentOffset:CGPointMake(self.currentBtn * RSW, 0) animated:YES];
                break;
            case 1://输入验证码页面{
            {
                if (!button.enabled) {
                    [self startTimer];
                    button.enabled = YES;
                }
                [self.scrollView setContentOffset:CGPointMake(RSW, 0) animated:YES];
                break;
            }
            case 2://设置密码页面
                if (!button.enabled) {
                    button.enabled = YES;
                }
                [self.scrollView setContentOffset:CGPointMake(RSW * 2, 0) animated:YES];
                break;
            default:
                break;
        }
}

#pragma mark - 初始化
-(NSMutableArray *)upButtons{
    if (!_upButtons) {
        _upButtons = [NSMutableArray array];
        for (int i = 0; i<3; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"step%d",i]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button setContentMode:UIViewContentModeScaleToFill];
            [_upButtons addObject:button];
            if (i > 0) {
              //  button.hidden = YES;
                button.enabled = NO;
                [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"stepOn%d",i]] forState:UIControlStateDisabled];
            }
        }
    }
    return _upButtons;
}
-(NSMutableArray *)bgImages{
    if (!_bgImages) {
        _bgImages = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [_bgImages addObject:image];
        }
    }
    return _bgImages;
}

-(FXBlurView *)blurView{
    if (!_blurView) {
        _blurView = [[FXBlurView alloc] init];
    }
    return _blurView;
}

@end
