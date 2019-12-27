//
//  SMBFileTootListTableViewCell.m
//  UncompressTeam
//
//  Created by MAC on 28/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "DJSMBFileTootListTableViewCell.h"

@implementation DJSMBFileTootListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bottomLine = [[UILabel alloc] init];
    self.bottomLine.backgroundColor = [UIColor lightGrayColor];
    self.bottomLine.alpha = 0.3;
    self.moreButton.hidden = YES;
    [self.moreButton addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)moreClick {
    if (self.success) {
        self.success();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end