//
//  OnlineCollectionCell.m
//  UncompressTeam
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "OnlineCollectionCell.h"

@implementation OnlineCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
    _bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Initialization code
}

@end
