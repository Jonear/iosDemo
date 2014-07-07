//
//  ViewController.m
//  TableViewFresh
//
//  Created by kyle on 14-2-21.
//  Copyright (c) 2014年 kyle. All rights reserved.
//

#import "ViewController.h"

#define RRowCount 20
#define RCellHeight 40

@interface ViewController () <UISearchBarDelegate>
{
    NSInteger _rowCount;
    NSInteger _editSytle;
    NSMutableArray *_dataList;
    NSMutableArray *_searchList;
    UIButton *_bottomRefresh;
    UIRefreshControl *refresh;
}
@end

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //默认row大小
    _rowCount = 5;

    _dataList = [NSMutableArray arrayWithCapacity:RRowCount];
    for (NSInteger i = 0; i < RRowCount; i++)
    {
        [_dataList addObject:[NSString stringWithFormat:@"row  %d", i + 1]];
    }
    
    self.title = @"下拉刷新与搜索";
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, RCellHeight + 15, 0);
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    self.searchDisplayController.searchBar.placeholder = @"搜索";
    
    /******内置刷新的常用属性设置******/
    refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    refresh.tintColor = [UIColor grayColor];
    [refresh addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    /******自定义查看更多属性设置******/
    _bottomRefresh = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomRefresh setTitle:@"查看更多" forState:UIControlStateNormal];
    [_bottomRefresh setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_bottomRefresh setContentEdgeInsets:UIEdgeInsetsMake(15, 0, 0, 0)];
    [_bottomRefresh addTarget:self action:@selector(upToRefresh) forControlEvents:UIControlEventTouchUpInside];
    _bottomRefresh.frame = CGRectMake(0, 44+_rowCount*RCellHeight, 320, RCellHeight);
    [self.tableView addSubview:_bottomRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView setContentOffset:CGPointMake(0, -160) animated:YES];
    [self pullToRefresh];
    [refresh beginRefreshing];
}

#pragma mark -
#pragma mark Actions
//下拉刷新
- (void)pullToRefresh
{
    //模拟网络访问
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中..."];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _rowCount += 2;
        [self.tableView reloadData];
        //刷新结束时刷新控件的设置
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新成功"];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        _bottomRefresh.frame = CGRectMake(0, 44+_rowCount*RCellHeight, 320, RCellHeight);
        
        double delayInSeconds = 0.01;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        });
    });
}

//上拉加载
- (void)upToRefresh
{
    _bottomRefresh.enabled = NO;
    //[SVProgressHUD showWithStatus:@"加载中..."];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _rowCount += 5;
        [self.tableView reloadData];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //[SVProgressHUD showSuccessWithStatus:@"加载完成"];
        _bottomRefresh.frame = CGRectMake(0, 44+_rowCount*RCellHeight, 320, RCellHeight);
        _bottomRefresh.enabled = YES;
    });
}

#pragma mark -
#pragma mark TableView DataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return _searchList.count;
    }
    else
    {
        return _rowCount;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text = _searchList[indexPath.row];
    }
    else
    {
        cell.textLabel.text = _dataList[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RCellHeight;
}

#pragma mark -
#pragma mark SearchDisplayController DelegateMethod
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self CONTAINS %@", searchString];
    
    if (_searchList)
    {
        _searchList = nil;
    }
    _searchList = [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:predicate]];
    
    return YES;
}

@end
