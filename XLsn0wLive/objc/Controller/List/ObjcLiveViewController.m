
#import "ObjcLiveViewController.h"

#import "PlayerTableViewCell.h"
#import "PlayerViewController.h"
#import "PlayerModel.h"

#define mainURL @"http://service.inke.com/api/live/aggregation?imsi=&uid=147808343&proto=6&imei=&interest=1&location=0"
#define Ratio 708/550

@interface ObjcLiveViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation ObjcLiveViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationItem.title = @"XLsn0w";
    [self bulidTableView];
    [self bulidCenterBtn];
    [self addRefresh];
}

- (void)bulidTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = [UIScreen mainScreen].bounds.size.width * Ratio + 1;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    //声明tableView的位置 添加下面代码
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
    }
}

- (void)bulidCenterBtn{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"logo_3745aaf"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(customBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@50);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
    }];
}

- (void)customBtnClick{
    NSLog(@"%s",__func__);
}

#pragma mark - ---| 添加下拉刷新 |---
- (void)addRefresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData{
    [self.dataList removeAllObjects];
    // 格式
    NSDictionary *dic = @{@"format":@"json"};
    [AFNetwork GET:mainURL parameters:dic success:^(id  _Nonnull json) {
        
        NSArray *listArray = [json objectForKey:@"lives"];
        for (NSDictionary *dic in listArray) {
            MJWeakSelf
            PlayerModel *playerModel = [[PlayerModel alloc] initWithDictionary:dic];
            playerModel.city = dic[@"city"];
            playerModel.portrait = dic[@"creator"][@"portrait"];
            playerModel.name = dic[@"creator"][@"nick"];
            playerModel.online_users = [dic[@"online_users"] intValue];
            NSLog(@"playerModel.online_users = %d",playerModel.online_users);
            playerModel.url = dic[@"stream_addr"];
            [weakSelf.dataList addObject:playerModel];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - ---| UITableViewDataSource |---

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[PlayerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.playerModel = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayerViewController * playerVc = [[PlayerViewController alloc] init];
    PlayerModel * PlayerModel = self.dataList[indexPath.row];
    playerVc.liveUrl = PlayerModel.url;
    playerVc.imageUrl = PlayerModel.portrait;
    [self.navigationController pushViewController:playerVc animated:true];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }return _dataList;
}

@end
