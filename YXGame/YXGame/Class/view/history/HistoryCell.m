//
//  HistoryCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/18.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HistoryCell.h"

@interface HistoryCell()

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@end

@implementation HistoryCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"HistoryCell";
    HistoryCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HistoryCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDataWithTime:(NSString *)time date:(NSString *)date {
    self.timeLab.text = time;
    self.dateLab.text = date;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
