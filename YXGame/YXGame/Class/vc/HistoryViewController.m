//
//  HistoryViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/17.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryCell.h"

@interface HistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

//@property (weak, nonatomic) IBOutlet UITableView *historyTable;

@property (nonatomic, strong) UITableView *historyTable;
@property (nonatomic, strong) NSArray *timeArr;
@property (nonatomic, strong) NSArray *dateArr;

@end

@implementation HistoryViewController

- (NSArray *)timeArr {
    if (_timeArr == nil) {
        _timeArr = [NSArray array];
    }
    return _timeArr;
}

- (NSArray *)dateArr {
    if (_dateArr == nil) {
        _dateArr = [NSArray array];
    }
    return _dateArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getHitsoryData];
}

- (void)getHitsoryData {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
//    [defaults removeObjectForKey:@"sudo"];
    
//    [defaults synchronize];

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"sudo"]];
    if (dic == nil) {
        dic = [NSMutableDictionary dictionary];
    }
    
    NSMutableArray *time = [NSMutableArray arrayWithArray:dic[@"time"]];
    NSMutableArray *date = [NSMutableArray arrayWithArray:dic[@"date"]];
    
    self.timeArr = [NSArray arrayWithArray:time];
    self.dateArr = [NSArray arrayWithArray:date];
//    self.timeArr = [[time reverseObjectEnumerator] allObjects];
//    self.dateArr = [[date reverseObjectEnumerator] allObjects];
    
//    self.dataDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (self.timeArr.count) {
        self.view.backgroundColor = MyColor;
        [self.historyTable dismissNoView];
        [self.historyTable reloadData];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        [self.historyTable showNoView:NSLocalizedString(@"你还没有胜利的记录呐", nil) image:nil certer:CGPointZero];
    }
}

#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.timeArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width-25, 30)];
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
        timeLab.text = NSLocalizedString(@"游戏胜利用时", nil);
        timeLab.font = [UIFont systemFontOfSize:15];
        timeLab.textColor = FontColor;
        
        UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-60, 0, 50, 30)];
        dateLab.text = NSLocalizedString(@"时间", nil);
        dateLab.font = [UIFont systemFontOfSize:15];
        dateLab.textColor = FontColor;
        dateLab.textAlignment = NSTextAlignmentRight;
        
        [view addSubview:timeLab];
        [view addSubview:dateLab];
        
        return view;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryCell *cell = [HistoryCell myCellWithTableview:tableView];
    [cell setDataWithTime:self.timeArr[indexPath.section] date:self.dateArr[indexPath.section]];
    
    return cell;
}

#pragma mark - ui
- (void)initUIView {
    [self setBackButton:YES];
    [self initTitleViewWithTitle:NSLocalizedString(@"历史记录", nil)];
    
    self.historyTable = [[UITableView alloc] initWithFrame:ScreenBounds style:UITableViewStyleGrouped];
    self.historyTable.delegate = self;
    self.historyTable.dataSource = self;
    [self.view addSubview:self.historyTable];
    
    self.historyTable.backgroundColor = [UIColor clearColor];
    self.historyTable.tableFooterView = [UIView new];
//    self.historyTable. = UITableViewStyleGrouped;
}

@end
