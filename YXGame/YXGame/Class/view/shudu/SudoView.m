//
//  SudoView.m
//  Sudoku
//
//  Created by CSX on 2017/4/11.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "SudoView.h"
#import "SudoModel.h"
//#import "ICAlarmView.h"

#define BACKEDIT @"C" //后退一步 （这里只做后退一步操作，如果需要可以使用链表，数组记录,稍后有空会添加）
#define NEW @"A" //重新开始
#define SHOWINTERVAL 2 //显示的间隔量级，可表示难易程度，值越大越不能保证唯一性。

typedef enum :NSInteger{
    BTNTags = 10,
}Tags;

@interface SudoView ()
{
    CGFloat cellWidth;
    NSString *titleStr;
    UIView *bgView;
    BOOL isEdit;
    SudoModel *sudo_deal;
}
//初始值保护数组
@property (nonatomic , strong)NSMutableArray *initlizeIndexArr;
//后退一步数组记录
@property (nonatomic , strong)NSMutableArray *oldTitleArr;
//显示数组
@property (nonatomic , strong)NSMutableArray *dataArr;

@property (nonatomic, strong) UILabel *timeLabel;//计时label
@property (nonatomic, strong) NSTimer *countTimer;//计时
@property (nonatomic, assign) NSInteger second;//秒
@property (nonatomic, assign) NSInteger minute;//分

@end

@implementation SudoView

- (NSMutableArray *)initlizeIndexArr{
    if (!_initlizeIndexArr) {
        _initlizeIndexArr = [NSMutableArray array];
    }
    return _initlizeIndexArr;
}
- (NSMutableArray *)oldTitleArr{
    if (!_oldTitleArr) {
        _oldTitleArr = [NSMutableArray array];
    }
    return _oldTitleArr;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        sudo_deal = [[SudoModel alloc]init];
        isEdit = YES;
        cellWidth = (frame.size.width-15*Width_Scale)/9;
        [self createViewWithFrame:frame];
        [self createButtonViewWithFrame:frame];
        self.second = 0;
        self.minute = 0;
        self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return self;
}

#pragma mark - 倒计时
- (void)countDown {
    if (self.second < 59) {
        self.second++;
    } else {
        self.second = 0;
    }
    
    NSString *secondStr = [NSString string];
    NSString *minuteStr = [NSString string];
    if (self.second < 10 && self.second >= 0) {
        secondStr = [NSString stringWithFormat:@"0%ld", self.second];
    } else {
        secondStr = [NSString stringWithFormat:@"%ld", self.second];
    }
    
    if (self.minute < 10) {
        minuteStr = [NSString stringWithFormat:@"0%ld", self.minute];
    } else {
        minuteStr = [NSString stringWithFormat:@"%ld", self.minute];
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@", minuteStr, secondStr];
    
    if (self.second == 59) {
        self.minute++;
    }
}

//关闭定时器
- (void)stopTimer {
    [self.countTimer setFireDate:[NSDate distantFuture]];
}

//重置数据
- (void)resetTime {
    self.second = 0;
    self.minute = 0;
    self.timeLabel.text = @"00:00";
}

#pragma mark - init
- (void)createViewWithFrame:(CGRect)frame{
    //蓝色正方形背景view
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.width)];
    bgView.backgroundColor = MyColor;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = WhiteColor.CGColor;
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    /* 1      2      3
     0 0 0  0 0 0  0 0 0
     0 0 0  0 0 0  0 0 0
     0 0 0  0 0 0  0 0 0
       4      5      6
     0 0 0  0 0 0  0 0 0
     0 0 0  0 0 0  0 0 0
     0 0 0  0 0 0  0 0 0
       7      8      9
     0 0 0  0 0 0  0 0 0
     0 0 0  0 0 0  0 0 0
     0 0 0  0 0 0  0 0 0
     */
    for (int i = 0; i < 81; i++) {
        UIButton *myCreateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i%9>=3 && i%9 <6) {
            //正方形2，5，8
            myCreateButton = [self createWithBegain:8*Width_Scale andIndex:i];
        }else if (i%9 >= 6){
            //正方形3，6，9
            myCreateButton = [self createWithBegain:12*Width_Scale andIndex:i];
        }else{
            //正方形1，4，7
            myCreateButton = [self createWithBegain:4*Width_Scale andIndex:i];
        }
        [myCreateButton setBackgroundColor:[UIColor whiteColor]];
//        [myCreateButton setTitleColor:FontColor forState:UIControlStateNormal];

        myCreateButton.titleLabel.layer.cornerRadius = 5;
        myCreateButton.tag = BTNTags+i;
        myCreateButton.titleLabel.clipsToBounds = YES;
        [myCreateButton addTarget:self action:@selector(buttonChoose:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:myCreateButton];
    }
    [self getNewData];
    [self refresh];
}

//设置按钮frame
- (UIButton *)createWithBegain:(int)index andIndex:(int)i{
    UIButton *myCreateButton = [[UIButton alloc]init];
    if (i/9 >= 3 && i/9 <6) {
        //27-53
        myCreateButton.frame = CGRectMake(index+cellWidth*(i%9), 8*Width_Scale+cellWidth*(i/9), cellWidth-2, cellWidth-2);
    }else if (i/9 >= 6) {
        //54-80
        myCreateButton.frame = CGRectMake(index+cellWidth*(i%9), 12*Width_Scale+cellWidth*(i/9), cellWidth-2, cellWidth-2);
    }else{
        //0-26
        myCreateButton.frame = CGRectMake(index+cellWidth*(i%9), 4*Width_Scale+cellWidth*(i/9), cellWidth-2, cellWidth-2);
    }

    return myCreateButton;
}

- (void)buttonChoose:(UIButton *)sender{
    __weak typeof(self) weakself = self;
    if (isEdit) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
        [tempDic setValue:sender.currentTitle forKey:[NSString stringWithFormat:@"%ld",sender.tag-BTNTags]];
        [self.oldTitleArr addObject:tempDic];
        //判断是否需要修改字段，是否是初始元素
        if (![self.initlizeIndexArr containsObject:[NSNumber numberWithInteger:sender.tag-BTNTags]]) {
            [sender setTitle:titleStr forState:UIControlStateNormal];
            [sudo_deal isSatisfyWithDataArr:self.dataArr WithIndex:(int)(sender.tag-BTNTags) AndTitle:titleStr WithBlock:^(BOOL isSatisfy, NSArray *errIndexArr) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!isSatisfy) {
                        for (int i = 0; i<errIndexArr.count; i++) {
                            int ind = [errIndexArr[i] intValue];
                            UIButton *btn = [bgView viewWithTag:ind+BTNTags];
                            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                        }
                        isEdit = NO;
                    }else{
                        [weakself.dataArr replaceObjectAtIndex:(int)(sender.tag-BTNTags) withObject:titleStr];
                        if (![weakself.dataArr containsObject:@""]) {
                            [weakself performSelectorOnMainThread:@selector(Success) withObject:nil waitUntilDone:nil];
                        }
                    }
                });
            }];
        }
    }
}
- (void)Success{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:@"sudo"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"sudo"]];
    if (dic == nil) {
        dic = [NSMutableDictionary dictionary];
    }
    
    NSMutableArray *timeArr = [NSMutableArray arrayWithArray:dic[@"time"]];
    NSMutableArray *dateArr = [NSMutableArray arrayWithArray:dic[@"date"]];
    
//    NSMutableArray *timeArr = [NSMutableArray arrayWithArray:dic.allValues];
//    NSMutableArray *dateArr = [NSMutableArray arrayWithArray:dic.allKeys];
    
    NSString *currentDateStr = [LJUtil getCurrentTimes];
    
//    currentDateStr = [LJUtil timeInterverlToDateStr:currentDateStr];
    NSLog(@"currentDateStr: %@", currentDateStr);
    
    NSString *successTimeStr = self.timeLabel.text;
    
    if (timeArr.count) {
        [timeArr insertObject:successTimeStr atIndex:0];
    } else {
        [timeArr addObject:successTimeStr];
    }
    
    if (dateArr.count) {
        [dateArr insertObject:currentDateStr atIndex:0];
    } else {
        [dateArr addObject:currentDateStr];
    }
    
    [dic setObject:timeArr forKey:@"time"];
    [dic setObject:dateArr forKey:@"date"];
    
//    [dic setObject:timeArr forKey:dateArr];
    [defaults setObject:dic forKey:@"sudo"];
    
    if ([self.delegate respondsToSelector:@selector(showAlert)]) {
        [self.delegate showAlert];
    }
}

//底部按钮
- (void)createButtonViewWithFrame:(CGRect)frame{
    int celWidth = (Screen_Width-40)/9;
    CGFloat y_padding;
    if (Screen_Height == 480) {
        y_padding = 10*Heigt_Scale;
    } else {
        y_padding = 20*Heigt_Scale;
    }
    for (int i = 0; i<9; i++) {
        UIButton *myCreateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        myCreateButton.frame = CGRectMake((celWidth+5)*i, frame.size.width+y_padding, cellWidth, cellWidth);
        [myCreateButton setBackgroundColor:MyColor];
        [myCreateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        myCreateButton.layer.borderWidth = 1;
        myCreateButton.layer.borderColor = WhiteColor.CGColor;
        
        //1-9
        [myCreateButton setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        
        [myCreateButton addTarget:self action:@selector(titleChoose:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:myCreateButton];
    }
    //A 重新开始
    UIButton *reStarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reStarBtn.frame = CGRectMake(10, frame.size.width+celWidth+y_padding*2, celWidth*2.5, celWidth);
    [reStarBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [reStarBtn setTitle:NSLocalizedString(@"重新开始", nil) forState:UIControlStateNormal];
    reStarBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    reStarBtn.tag = 2017;
    reStarBtn.layer.masksToBounds = YES;
    reStarBtn.layer.borderColor = WhiteColor.CGColor;
    reStarBtn.layer.borderWidth = 1;
    reStarBtn.layer.cornerRadius = 5;
    [reStarBtn addTarget:self action:@selector(titleChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reStarBtn];
    
    //C 后退一步
    UIButton *reBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reBackBtn.frame = CGRectMake(Screen_Width-10-celWidth*2.5, frame.size.width+celWidth+y_padding*2, celWidth*2.5, celWidth);
    [reBackBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [reBackBtn setTitle:NSLocalizedString(@"后退一步", nil) forState:UIControlStateNormal];
    reBackBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    reBackBtn.tag = 2018;
    reBackBtn.layer.masksToBounds = YES;
    reBackBtn.layer.borderColor = WhiteColor.CGColor;
    reBackBtn.layer.borderWidth = 1;
    reBackBtn.layer.cornerRadius = 5;
    [reBackBtn addTarget:self action:@selector(titleChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reBackBtn];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(reStarBtn.frame)+5, frame.size.width+celWidth+y_padding*2, Screen_Width-(CGRectGetMaxX(reStarBtn.frame)+5)*2, celWidth)];
    self.timeLabel.text = @"00:00";
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = WhiteColor;
    [self addSubview:self.timeLabel];
}

//1-9 A C 按钮点击事件
- (void)titleChoose:(UIButton *)sender{
    NSLog(@".......");
    NSString *title = sender.titleLabel.text;
    if (sender.tag == 2018) {
        //后退一步
        isEdit = YES;
        if (!self.oldTitleArr.count) {
            return;
        }
        NSMutableDictionary *tempDic = [self.oldTitleArr lastObject];
        int index = [[[tempDic allKeys] firstObject] intValue];
        NSString *lastStr = [tempDic objectForKey:[[tempDic allKeys] firstObject]];
        if (lastStr.length>0) {
            [self.dataArr replaceObjectAtIndex:index withObject:lastStr];
        }else{
            [self.dataArr replaceObjectAtIndex:index withObject:@""];
        }
        [self refresh];
        [self.oldTitleArr removeLastObject];
    }else if (sender.tag == 2017){
        //重新开始
        [self reStartSudo];
    }else{
        titleStr =title;
    }
}

//重新开始
- (void)reStartSudo {
    [self stopTimer];
    [self resetTime];
    self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [self getNewData];
    [self refresh];
    
}

- (void)refresh{
    for (int i = 0; i<self.dataArr.count; i++) {
        UIButton *button = [bgView viewWithTag:BTNTags+i];
//        button.titleLabel.text = self.dataArr[i];
        [button setTitle:self.dataArr[i] forState:UIControlStateNormal];
        [button setTitleColor:MyColor forState:UIControlStateNormal];
    }
}
- (void)getNewData{
    [self.initlizeIndexArr removeAllObjects];
    self.dataArr = [sudo_deal generateRandomSudo];
    NSLog(@">>>>>>>>>>%@",self.dataArr);
    NSInteger count = self.dataArr.count;
    for (int i = 0; i<count; i++) {
        int a = arc4random()%SHOWINTERVAL;
        if (a==1) {
            [self.initlizeIndexArr addObject:[NSNumber numberWithInt:i]];
        }else{
            [self.dataArr replaceObjectAtIndex:i withObject:@""];
        }
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
