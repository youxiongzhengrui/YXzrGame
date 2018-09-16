//
//  YXRootViewController.m
//  YXGame
//
//  Created by xiongzhengrui on 2018/9/13.
//  Copyright © 2018年 xiongzhengrui. All rights reserved.
//

#import "YXRootViewController.h"
#import "Masonry.h"

@interface YXRootViewController ()

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;

@end

@implementation YXRootViewController

- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_button1 setTitle:@"2048" forState:(UIControlStateNormal)];
        [_button1 setTitleColor: [UIColor whiteColor] forState:(UIControlStateNormal)];
        _button1.backgroundColor = [UIColor grayColor];
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_button2 setTitle:@"数独" forState:(UIControlStateNormal)];
        [_button2 setTitleColor: [UIColor whiteColor] forState:(UIControlStateNormal)];
        _button2.backgroundColor = [UIColor grayColor];
    }
    return _button2;
}

- (void)setUpSubViews {
    [self.view addSubview: self.button1];
    [self.view addSubview: self.button2];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(120);
        make.width.height.mas_equalTo(60);
    }];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(220);
        make.width.height.mas_equalTo(60);
    }];
    
}

//MARK: - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
