//
//  PaySection2TableViewCell.m
//  PrettyPatPlayerPlayer
//
//  Created by MAC on 09/12/2019.
//  Copyright © 2019 PPVideo. All rights reserved.
//

#import "DJer_PaySection2TableVCell.h"

@implementation DJer_PaySection2TableVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor clearColor];
    _lijiPayBtn.layer.masksToBounds = YES;
    _lijiPayBtn.layer.cornerRadius = 35.0/2;
    _lijiPayBtn.backgroundColor = ASOColorTheme;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)PPVideo_yearAction:(id)sender {
    if (self.PPVideo_yearBlock) {
        self.PPVideo_yearBlock();
    }
}
- (IBAction)PPVideo_monthAction:(id)sender {
    if (self.PPVideo_monthBlock) {
        self.PPVideo_monthBlock();
    }
}
- (IBAction)PPVideo_seasonAction:(id)sender {
    if (self.PPVideo_seasonBlock) {
        self.PPVideo_seasonBlock();
    }
}

@end
