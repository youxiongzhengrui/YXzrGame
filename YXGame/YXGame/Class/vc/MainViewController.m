//
//  MainViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/19.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"
#import "HistoryViewController.h"
#import "HelpViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *newgameBtn;
@property (weak, nonatomic) IBOutlet UIButton *historyBtn;
@property (weak, nonatomic) IBOutlet UIButton *helpBtn;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - click

- (IBAction)beginGame:(UIButton *)sender {
    GameViewController *game = [[GameViewController alloc] init];
    [self.navigationController pushViewController:game animated:YES];
    //    [self presentViewController:game animated:YES completion:nil];
}
- (IBAction)lookHistory:(UIButton *)sender {
    HistoryViewController *history = [[HistoryViewController alloc] init];
    [self.navigationController pushViewController:history animated:YES];
    //    [self presentViewController:history animated:YES completion:nil];
}

- (IBAction)lookHelp:(UIButton *)sender {
    HelpViewController *help = [[HelpViewController alloc] init];
    [self.navigationController pushViewController:help animated:YES];
    //    [self presentViewController:help animated:YES completion:nil];
}

#pragma mark - ui
- (void)initUIView {
    self.newgameBtn.layer.borderColor = WhiteColor.CGColor;
    self.historyBtn.layer.borderColor = WhiteColor.CGColor;
    self.helpBtn.layer.borderColor = WhiteColor.CGColor;
}

@end
