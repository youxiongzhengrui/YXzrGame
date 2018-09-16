//
//  BaseTabbarController.m
//  IOSFrame
//
//  Created by lijie on 2017/7/17.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"
//#import "HomeViewController.h"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)setChildVCWithViewController:(UIViewController *)controller title:(NSString *)title image:(UIImage *)image selectedImg:(UIImage *)selectedImg {
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    self.tabBar.tintColor = FontColor;

    nav.title = title;
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

#pragma mark - tabbar
- (void)presentPlayVC {
    
}



@end
