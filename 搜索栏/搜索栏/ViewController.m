//
//  ViewController.m
//  搜索栏
//
//  Created by huangdeyu on 16/3/2.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) UISearchDisplayController * searchDisplayController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UISearchBar * searchbar = [[UISearchBar alloc] init];
    self.navigationItem.titleView = searchbar;
    searchbar.delegate = self;
    searchbar.showsCancelButton = YES;
    searchbar.showsBookmarkButton = NO;
    searchbar.showsSearchResultsButton = NO;
    searchbar.showsScopeBar = NO;
    
    self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchbar contentsController:self];
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate  = self;
    self.searchDisplayController.searchResultsTableView.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

    [self.view addSubview:self.searchDisplayController.searchResultsTableView];
    self.searchDisplayController.searchResultsTableView.hidden = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
   // [self.view addSubview:self.tableView];
    [self.view insertSubview:self.tableView belowSubview:self.searchDisplayController.searchResultsTableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView == tableView) {
        UITableViewCell * cell = [tableView  dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        cell.textLabel.text = @"搜索前";
        return cell;
    }else{
        UITableViewCell * cell = [tableView  dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        cell.textLabel.text = @"搜索后";
        return cell;
    }
}
#pragma mark - search bar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.view bringSubviewToFront:self.searchDisplayController.searchResultsTableView];
    NSLog(@"搜索框文本变化");
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //取消键是用来退出页面的
}
@end
