//
//  DYScrollView.m
//  循环滚动视频
//
//  Created by huangdeyu on 16/1/27.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import "DYScrollView.h"

#define SCROLLFRAMEWIDTH self.frame.size.width
#define SCROLLFRAMEHEIGHT self.frame.size.height


@interface DYScrollView()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong) UIPageControl * pageControl;
@property(nonatomic,assign) NSInteger currentPage;
@property(nonatomic,assign) NSInteger totalCount;
@property(nonatomic,strong) NSTimer * timer;

@end

@implementation DYScrollView

-(instancetype)initWithImages:(NSArray *)images frame:(CGRect)frame{
    if (self = [super init]) {
        self.pageControl.frame = CGRectMake(0, 0, 100, 30);
        self.pageControl.center = CGPointMake(self.center.x, self.frame.size.height - 40);
        self.pageControl.numberOfPages  = images.count;
        self.pageControl.currentPage = 0;
        self.currentPage = 0;
        self.totalCount = images.count;
        for (int i = 0; i < images.count+2; i++) {
            UIImage * image = images[i];
            UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake((i+1)*SCROLLFRAMEWIDTH, 0, SCROLLFRAMEWIDTH, SCROLLFRAMEHEIGHT);
            [self.scrollView addSubview:imageView];
        }
        UIImageView * imageFirst = [[UIImageView alloc] initWithImage:[images lastObject]];
        imageFirst.frame = CGRectMake(0, 0, SCROLLFRAMEWIDTH, SCROLLFRAMEHEIGHT);
        [self.scrollView addSubview:imageFirst];
        
        UIImageView * imageLast = [[UIImageView alloc] initWithImage:[images firstObject]];
        imageLast.frame = CGRectMake(SCROLLFRAMEWIDTH * (images.count+1), 0, SCROLLFRAMEWIDTH, SCROLLFRAMEHEIGHT);
        [self.scrollView addSubview:imageLast];
        
        self.scrollView.frame = frame;
        self.scrollView.contentSize = CGSizeMake(SCROLLFRAMEWIDTH * (images.count+2), 0);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.contentOffset = CGPointMake(SCROLLFRAMEWIDTH, 0);
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
        [self startRunning];
    }
    return self;
}
-(void)startRunning{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerGO) userInfo:nil repeats:YES];
}
-(void)timerGO{
    self.currentPage++;
    if (self.scrollView.contentOffset.x == SCROLLFRAMEWIDTH * (self.totalCount+1)) {
        self.scrollView.contentOffset = CGPointMake(SCROLLFRAMEWIDTH, 0);
        self.currentPage = 1;
    }
    if (self.scrollView.contentOffset.x == 0) {
        self.scrollView.contentOffset = CGPointMake(SCROLLFRAMEWIDTH * self.totalCount, 0);
        self.currentPage = self.totalCount;
    }
    [self.scrollView setContentOffset:CGPointMake(SCROLLFRAMEWIDTH * self.currentPage, 0) animated:YES];
    NSLog(@"%ld",(long)self.currentPage);
}
-(void)timerStop{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self timerStop];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset =  scrollView.contentOffset.x / SCROLLFRAMEWIDTH +0.5;
    self.currentPage = (NSInteger)offset-1;
    if (self.currentPage >= self.totalCount) {
        self.currentPage = 0;
    }
    if (self.currentPage < 0) {
        self.currentPage = self.totalCount;
    }
    self.pageControl.currentPage = self.currentPage;
    if (self.scrollView.contentOffset.x < 0) {
        self.scrollView.contentOffset = CGPointMake(SCROLLFRAMEWIDTH    * self.totalCount, 0);
    }
    if (self.scrollView.contentOffset.x > SCROLLFRAMEWIDTH  * (self.totalCount+1)) {
        self.scrollView.contentOffset = CGPointMake(SCROLLFRAMEWIDTH , 0);
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
