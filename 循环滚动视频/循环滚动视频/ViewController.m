//
//  ViewController.m
//  循环滚动视频
//
//  Created by huangdeyu on 16/1/27.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import "ViewController.h"
#define COUNT 5
#define SCROLLWIDTH self.view.frame.size.width
#define SCROLLHEIGHT self.view.frame.size.height


@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)NSMutableArray * imageViews;
@property(nonatomic,strong) NSTimer * timer;
@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageControl.frame = CGRectMake(0, 0, 100, 30);
    self.pageControl.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 40);
    self.pageControl.numberOfPages  = COUNT;
    self.pageControl.currentPage = 0;
    self.currentPage = 0;

    for (int i = 0; i < COUNT+2; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"i%d",i]];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake((i+1)*SCROLLWIDTH, 0, SCROLLWIDTH, SCROLLHEIGHT);
        [self.scrollView addSubview:imageView];
    }
    UIImageView * imageFirst = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i4"]];
    imageFirst.frame = CGRectMake(0, 0, SCROLLWIDTH, SCROLLHEIGHT);
    [self.scrollView addSubview:imageFirst];
    
    UIImageView * imageLast = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i0"]];
    imageLast.frame = CGRectMake(SCROLLWIDTH * (COUNT+1), 0, SCROLLWIDTH, SCROLLHEIGHT);
    [self.scrollView addSubview:imageLast];
    self.scrollView.frame = self.view.frame;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * (COUNT+2), 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentOffset = CGPointMake(SCROLLWIDTH, 0);
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    [self startRunning];
}



-(void)startRunning{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerGO) userInfo:nil repeats:YES];
}
-(void)timerGO{
    self.currentPage++;
    if (self.scrollView.contentOffset.x == SCROLLWIDTH * (COUNT+1)) {
        self.scrollView.contentOffset = CGPointMake(SCROLLWIDTH, 0);
        self.currentPage = 1;
    }
    if (self.scrollView.contentOffset.x == 0) {
        self.scrollView.contentOffset = CGPointMake(SCROLLWIDTH * COUNT, 0);
         self.currentPage = COUNT;
    }
    [self.scrollView setContentOffset:CGPointMake(SCROLLWIDTH * self.currentPage, 0) animated:YES];
    NSLog(@"%ld",(long)self.currentPage);
}
-(void)timerStop{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"%f",self.scrollView.contentOffset.x);
    [self timerStop];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset =  scrollView.contentOffset.x / self.view.frame.size.width+0.5;
    self.currentPage = (NSInteger)offset-1;
    if (self.currentPage >= COUNT) {
        self.currentPage = 0;
    }
    if (self.currentPage < 0) {
        self.currentPage = COUNT;
    }
    self.pageControl.currentPage = self.currentPage;
    if (self.scrollView.contentOffset.x < 0) {
        self.scrollView.contentOffset = CGPointMake(SCROLLWIDTH * COUNT, 0);
    }
    if (self.scrollView.contentOffset.x > SCROLLWIDTH * (COUNT+1)) {
        self.scrollView.contentOffset = CGPointMake(SCROLLWIDTH, 0);
    }
   
    NSLog(@"当前页数是:%ld",(long)self.currentPage);
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startRunning];
}
#pragma mark - 初始化
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}
@end
