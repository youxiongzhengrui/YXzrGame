//
//  SudoView.h
//  Sudoku
//
//  Created by CSX on 2017/4/11.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SudoSuccessDelegate <NSObject>

- (void)showAlert;

@end

@interface SudoView : UIView

@property (nonatomic, assign) id<SudoSuccessDelegate> delegate;

//重新开始
- (void)reStartSudo;

@end
