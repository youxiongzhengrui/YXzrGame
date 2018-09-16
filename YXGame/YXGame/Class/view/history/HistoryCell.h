//
//  HistoryCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/18.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview;

- (void)setDataWithTime:(NSString *)time date:(NSString *)date;

@end
