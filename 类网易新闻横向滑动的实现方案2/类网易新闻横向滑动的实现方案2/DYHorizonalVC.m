//
//  DYHorizonalVC.m
//  类网易新闻横向滑动的实现方案2
//
//  Created by huangdeyu on 16/2/23.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import "DYHorizonalVC.h"
#import "DYTitleView.h"

@interface DYHorizonalVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * controllers;
@property(nonatomic,assign)NSInteger currentControllerIndex;
@property(nonatomic,strong)DYTitleView * titleView;
@end

@implementation DYHorizonalVC
-(instancetype)initWithControllers:(NSArray *)controllers titles:(NSArray *)titles{
    if (self = [super init]) {
        self.currentControllerIndex = 0;
        self.controllers = [controllers mutableCopy];
        self.titleView = [[DYTitleView alloc] initWithTitles:titles frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        [self.view addSubview:self.titleView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.frame;
    
    [self titleClicked];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private method
-(void)titleClicked{
    __weak typeof(self) weakSelf = self;
    self.titleView.buttonClickBlock = ^(UIButton *button){
        if (weakSelf.currentControllerIndex != button.tag) {
            [weakSelf.tableView setContentOffset:CGPointMake(0, button.tag * [UIScreen mainScreen].bounds.size.width)];
            weakSelf.currentControllerIndex = button.tag;
        }
       
    };
}


#pragma  mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.controllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    UIViewController * vc = self.controllers[indexPath.row];
    vc.view.frame = cell.contentView.bounds;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [vc.view removeFromSuperview];
    [cell.contentView addSubview:vc.view];
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.width;
}

#pragma mark - scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.titleView setCurrentOffset:scrollView.contentOffset.y];
}
#pragma  mark - 初始化

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.transform = CGAffineTransformMakeRotation(- M_PI / 2);
        _tableView.pagingEnabled = YES;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
    }
    return _tableView;
}

@end
