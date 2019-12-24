//
//  HistoryTableViewCell.m
//  GQAllPlayer
//
//  Created by MAC on 09/12/2019.
//  Copyright © 2019 DJ. All rights reserved.
//

#import "UNHistoryTableViewCell.h"
#import <Masonry/Masonry.h>
@implementation UNHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bottomLine = [[UILabel alloc] init];
    self.bottomLine.backgroundColor = [UIColor lightGrayColor];
    self.bottomLine.alpha = 0.3;
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    //设置收藏按钮的图片
    
    [self.faverateBtn setImage:[UIImage imageNamed:@"faverate0"] forState:UIControlStateNormal];
    [self.faverateBtn setImage:[UIImage imageNamed:@"faverate1"] forState:UIControlStateSelected];
    
}
///删除按钮
- (IBAction)delAction:(id)sender {
    if (self.delBlock) {
        self.delBlock();
    }
}
///收藏按钮
- (IBAction)faverateAction:(id)sender {
    
    if (self.faverateBlock) {
           self.faverateBlock();
       }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
