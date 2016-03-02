//
//  ViewController.m
//  DYTag
//
//  Created by huangdeyu on 16/1/21.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import "ViewController.h"
#import "DYTagContainer.h"

@interface ViewController ()<DYTagContainerDelegate>
@property(nonatomic,strong) DYTagContainer * tagContainer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview: self.tagContainer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(DYTagContainer*)tagContainer{
    if (!_tagContainer) {
        _tagContainer = [[DYTagContainer alloc] initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 40)];
        _tagContainer.layer.borderWidth = 1.0;
        _tagContainer.layer.borderColor = [UIColor redColor].CGColor;
        _tagContainer.delegate =self;
    }
    return _tagContainer;
}

-(void)ChooseTags:(NSArray *)tags{
    NSLog(@"%@",tags);
}

@end
