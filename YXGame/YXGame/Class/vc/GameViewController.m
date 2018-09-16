//
//  GameViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/17.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "GameViewController.h"
#import "SudoView.h"

@interface GameViewController ()<SudoSuccessDelegate>

@property (nonatomic, strong) SudoView *sudoview;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Screen_Height:%f", Screen_Height);
}

- (void)goBack {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"游戏还在进行中，要退出么", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureaction = [UIAlertAction actionWithTitle:NSLocalizedString(@"继续游戏", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancleaction = [UIAlertAction actionWithTitle:NSLocalizedString(@"退出", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [super goBack];
    }];
    
    [alert addAction:sureaction];
    [alert addAction:cancleaction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"游戏胜利", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureaction = [UIAlertAction actionWithTitle:NSLocalizedString(@"继续游戏", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.sudoview reStartSudo];
    }];
    UIAlertAction *cancleaction = [UIAlertAction actionWithTitle:NSLocalizedString(@"退出", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [super goBack];
    }];
    
    [alert addAction:sureaction];
    [alert addAction:cancleaction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - ui
- (void)initUIView {
    [self setBackButton:YES];
    [self initTitleViewWithTitle:NSLocalizedString(@"新游戏", nil)];
    [self initSudoView];
}

- (void)initSudoView {
    CGFloat y_padding;
    if (Screen_Height == 480) {
        y_padding = 0;
    } else {
        y_padding = 50*Heigt_Scale;
    }
    self.sudoview = [[SudoView alloc] initWithFrame:CGRectMake(0, y_padding, Screen_Width, Screen_Height-y_padding)];
    self.sudoview.delegate = self;
    [self.view addSubview:self.sudoview];
}

@end
