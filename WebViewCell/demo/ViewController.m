//
//  ViewController.m
//  demo
//
//  Created by kyle on 11/18/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSArray *dataArray;
    NSMutableArray *dataHeight;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Demo";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(freshTableView:) name:@"freshTableView" object:nil];
    
    NSString *a1 = @"1111111111111真绝味# 绝@味鸭真绝味# 绝味鸭真绝味# 绝味鸭 --- END";
    NSString *a2 = @"#这个优惠真绝味# 绝味鸭脖能团购啦！线上下单，线下提货！更多折扣和惊喜[得意地笑]买同样的鸭脖，花更少的money！关注@绝味美食汇 转此微博@ 三位吃货 就有机会免费吃鸭脖，还有情定绝味黄金项链拿 抢购已经开始，转发越多名额越多哦！吃货走你 手机：http://t.cn/zQYqhTK PC...----- END";
    NSString *a3 = @"@田爱娜刚发现粉丝快1万了，为了纪念下，特提供200元的乐视点卡作为奖品赠送给第一万的粉丝。PS：前晚用上乐视盒子了，再装个“泰捷视频”，完美之极。等有钱了再配再配再配再配再配再配@再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配再配个乐视超级电视和智能遥控就更完美了。 --- END";
    NSString *a4 = @"山寨 COC 谁不会呀 :D 我们也来一个. 做着玩儿的, 不打算推广了, 试试新写的引擎而已. 苹果那里审核中, 91 先行版 http://t.cn/8kPjRhR,sdfghjsdfghjzxc，vbnsdfg，hjzxcv bn - END";
    NSString *a5 = @"555555555dfghjzxcvbn - END";
    NSString *a6 = @"今天全文推送的文章是《我是如何从0开始，在23天里完成一款Android游戏开发的 – Part7– 第18至第20天》，内容简介见附图。 感谢 @jackywgw 翻译。欢迎扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直扫描加关注，或直接加微信号：importnew 。也可以直接访问 -> http://t.cn/8kvsQTI,sdfghjsdfghjzxcvbn sdfghjzxcvbn - END";
    NSString *a7 = @"山寨 刚发现粉丝快1万了，为了纪念下，特提供200元的乐视点卡作为奖品赠送给第一万的粉丝。PS：前晚用上乐视盒子了，再装个“泰捷视频”，完美之极。等有钱了再配再配再配再配再配再配再配再刚发现粉丝快1万了，为了纪念下，特提供200元的乐视点卡作为奖品赠送给第一万的粉丝。PS：前晚用上乐视盒子了，再装个“泰捷视频”，完美之极。等有钱了再配再配再配再配再配再配再配再刚发现粉丝快1万了，为了纪念下，特提供200元的乐视点卡作为奖品赠送给第一万的粉丝。PS：前晚用上乐视盒子了，再装个“泰捷视频”，完美之极。等有钱了再配再配再配再配再配再配再配再刚发现粉丝快1万了，为了纪念下，特提供200元的乐视点卡作为奖品赠送给第一万的粉丝。PS：前晚用上乐视盒子了，再装个“泰捷视频”，完美之极。等有钱了再配再配再配再配再配再配再配再COC 谁不会呀 :D 我们也来一个. 做着玩儿的, 不打算推广了, 试试新写的引擎而已. 苹果那里审核中, 91 先行版 http://t.cn/8kPjRhR,sdfghjsdfghjzxc，vbnsdfg，hjzxcv bn - END";
    NSString *a8 = @"5刚发现粉丝快1万了，为了纪念下，特提供200元的乐视点卡作为奖品赠送给第一万的粉丝。PS：前晚用上乐视盒子了，再装个“泰捷视频”，完美之极。等有钱了再配再配再配再配再配再配再配再刚发现粉丝快1万了，为了纪念下，特提供200元的乐视点卡作为奖品赠送给第一万的粉丝。PS：前晚用上乐视盒子了，再装个“泰捷视频”，完美之极。等有钱了再配再配再配再配再配再配再配再刚发现粉丝快1万了，为了纪念下，特提供200元的乐视点卡作为奖品赠送给第一万的粉丝。PS：前晚用上乐视盒子了，再装个“泰捷视频”，完美之极。等有钱了再配再配再配再配再配再配再配再刚发现粉丝快1万了，为了纪念下，特提供200元的乐视点卡作为奖品赠送给第一万的粉丝。PS：前晚用上乐视盒子了，再装个“泰捷视频”，完美之极。等有钱了再配再配再配再配再配再配再配再55555555dfghjzxcvbn - END";
    
    dataArray = [NSArray arrayWithObjects:
                 a1,
                 a2,
                 a3,
                 a4,
                 a6,
                 a5,
                 a7,
                 a8,
                 nil];
    
    NSArray *tmp = [NSArray arrayWithObjects:
                  [[NSNumber alloc] initWithFloat:70.0],
                  [[NSNumber alloc] initWithFloat:70.0],
                  [[NSNumber alloc] initWithFloat:70.0],
                  [[NSNumber alloc] initWithFloat:70.0],
                  [[NSNumber alloc] initWithFloat:70.0],
                  [[NSNumber alloc] initWithFloat:70.0],
                  [[NSNumber alloc] initWithFloat:70.0],
                  [[NSNumber alloc] initWithFloat:70.0],
                  nil];
    dataHeight = [[NSMutableArray alloc] init];
    [dataHeight addObjectsFromArray:tmp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)freshTableView:(NSNotification *)notify
{
    NSDictionary *param = notify.userInfo;
    id index = [param objectForKey:@"index"];
    id height = [param objectForKey:@"height"];
    
    [dataHeight replaceObjectAtIndex:[index intValue] withObject:height];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    });
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    assert(cell);
    [cell updateCell:[dataArray objectAtIndex:indexPath.row] index:indexPath.row];
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[dataHeight objectAtIndex:indexPath.row] floatValue];
}

@end
