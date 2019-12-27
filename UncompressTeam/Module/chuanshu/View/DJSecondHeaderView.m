//
//  SecondHeaderView.m
//  UncompressTeam
//
//  Created by MAC on 29/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "DJSecondHeaderView.h"

@implementation DJSecondHeaderView

//+ (BOOL)requiresConstraintBasedLayout
//{
//    return YES;
//}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self.contentView addSubview:self.timeLabel];
    self.contentView.backgroundColor = APPGrayColor;
    [self.contentView addSubview:self.lineView];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 20, 0, 10));
    }];
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = ASOColorTheme;
    }
    return _timeLabel;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = APPGrayColor;
    }
    return _lineView;
}
@end
