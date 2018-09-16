//
//  HelpViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/17.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tipsLab;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)back:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self goBack];
}

#pragma mark - ui
- (void)initUIView {
    [self setBackButton:YES];
    [self initTitleViewWithTitle:NSLocalizedString(@"帮助", nil)];
//    [self setThemeImgWithPicture:@"num"];
    
    self.tipsLab.font = [UIFont systemFontOfSize:15];
    if (![LJUtil currentLanguageIsChinese]) {
        self.tipsLab.text = @"1、Click on a number in the next row of 1-9, then click on the space you want to fill, and the number you selected is filled in this space\n\n2、The current column to be filled with a row and a column, as well as the current space where the 9 grid, can not appear the same number\n\n3、Click to restart, the number of lattice will be refreshed, timing will start again\n\n4、Click back one step, you can return to the current action of the previous step\n5、Start your challenge right now";
    }
}

@end
