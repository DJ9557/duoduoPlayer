//
//  CollectionViewCell.m
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//


#import "UNCollectionViewCell.h"
#import "DJP_CellModel.h"
#import "UNFileCollectionViewController.h"

#define IMAGE_WIDTH 50
#define IMAGE_HEIGHT 50
#define NAMELAB_WIDTH self.bounds.size.width - IMAGE_WIDTH - SPACE * 4
#define NAMELAB_HEIGHT 20
#define TIMELAB_WIDTH 140
#define TIMELAB_HEIGHT 14
#define SIZELAB_WIDTH 65
#define SIZELAB_HEIGHT 14
#define ICON_WIDTH 24
#define ICON_HEIGHT 24
#define SPACE (self.bounds.size.width - IMAGE_WIDTH - TIMELAB_WIDTH - SIZELAB_WIDTH) / 4
#define EDIT_SPACE (self.bounds.size.width - IMAGE_WIDTH - TIMELAB_WIDTH - SIZELAB_WIDTH - ICON_HEIGHT) / 5

@interface UNCollectionViewCell ()


@property (nonatomic, strong) UIImageView *selecedIcon;
@property (nonatomic, strong) UIImageView *unselecedIcon;


@end

@implementation UNCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

//初始化cell元素
- (void)initView {
   
    //文件图片icon名
    _imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageV.layer.masksToBounds = YES;
    _imageV.layer.cornerRadius = 5;
    [self.contentView addSubview:_imageV];

    //文件大小
       _sizeLab = [[UILabel alloc] initWithFrame:CGRectZero];
       _sizeLab.numberOfLines = 0;
       _sizeLab.font = [UIFont systemFontOfSize:13];
    _sizeLab.textColor = KGrayColor;
       [self.contentView addSubview:_sizeLab];
    //文件名
    _nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLab.numberOfLines = 0;
    _nameLab.textColor = KGrayColor;
    [self.contentView addSubview:_nameLab];

    //文件创建时间
    _createTimeLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _createTimeLab.numberOfLines = 0;
    _createTimeLab.font = [UIFont systemFontOfSize:13];
    _createTimeLab.textColor = KGrayColor;
    _createTimeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_createTimeLab];

   

    //文件选择状态的icon图标
    _selecedIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_selecedIcon];

    //文件未选择状态的icon图标
    _unselecedIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_unselecedIcon];
}

//实例化具体数据
- (void)setModel:(DJP_CellModel *)model {
    _model = model;
    _imageV.image = [UIImage imageNamed:model.iconName];
    _selecedIcon.image = [UIImage imageNamed:@"selected-btn"];
    _unselecedIcon.image = [UIImage imageNamed:@"select-btn"];
    _nameLab.text = model.name;
    _createTimeLab.text = model.createTime;
    _sizeLab.text = model.size;
}

//根据展示的type不同，改变元素布局
- (void)setIsCell:(BOOL)isCell {
    _isCell = isCell;
    if (isCell) {
        if (self.isSelected) {
            [self halfAlphaUI];
            _selecedIcon.frame = CGRectMake(self.bounds.size.width - ICON_WIDTH - 2, self.bounds.size.height - ICON_HEIGHT - 2, ICON_WIDTH, ICON_HEIGHT);
        } else {
            [self normalAlphaUI];
        }
        _imageV.frame = CGRectMake((self.bounds.size.width - 50) / 2, (self.bounds.size.height - 50 - 15) / 3, 50, 50);
        _nameLab.frame = CGRectMake(10, self.bounds.size.height / 3 * 2 + 5, self.bounds.size.width - 20, 15);
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [UIFont systemFontOfSize:12];
        _createTimeLab.frame = CGRectZero;
        _sizeLab.frame = CGRectZero;
        _unselecedIcon.frame = CGRectZero;
    } else {
        [self normalAlphaUI];
        _imageV.frame = CGRectMake(10, (self.bounds.size.height - IMAGE_HEIGHT) / 2, IMAGE_WIDTH, IMAGE_HEIGHT);
        _nameLab.frame = CGRectMake(92, 20, self.bounds.size.width - 92, NAMELAB_HEIGHT);
        _nameLab.font = [UIFont systemFontOfSize:18];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _sizeLab.frame = CGRectMake(92, self.bounds.size.height - 25, SIZELAB_WIDTH, SIZELAB_HEIGHT);
        _createTimeLab.frame = CGRectMake(self.bounds.size.width - TIMELAB_WIDTH - 10, self.bounds.size.height - 25, TIMELAB_WIDTH, TIMELAB_HEIGHT);
        _selecedIcon.frame = CGRectZero;
        _unselecedIcon.frame = CGRectZero;
    }
}

//处理列表模式下的编辑视图
- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    if (isEditing) {
        if (!_isCell) {
            if (self.isSelected) {
                [self normalAlphaUI];
                _selecedIcon.frame = CGRectMake(EDIT_SPACE, (self.bounds.size.height - ICON_WIDTH) / 2, ICON_WIDTH, ICON_HEIGHT);
            } else {
                [self halfAlphaUI];
                _unselecedIcon.frame = CGRectMake(EDIT_SPACE, (self.bounds.size.height - ICON_WIDTH) / 2, ICON_WIDTH, ICON_HEIGHT);
                _unselecedIcon.alpha = 0.2;
            }
            _imageV.frame = CGRectMake(ICON_WIDTH + EDIT_SPACE * 2, (self.bounds.size.height - IMAGE_HEIGHT) / 2, IMAGE_WIDTH, IMAGE_HEIGHT);
            _nameLab.frame = CGRectMake(ICON_WIDTH + IMAGE_WIDTH + EDIT_SPACE * 3, 20, NAMELAB_WIDTH, NAMELAB_HEIGHT);
            _sizeLab.frame = CGRectMake(ICON_WIDTH + IMAGE_WIDTH + EDIT_SPACE * 3, self.bounds.size.height - 25, SIZELAB_WIDTH, SIZELAB_HEIGHT);
            _createTimeLab.frame = CGRectMake(ICON_WIDTH + IMAGE_WIDTH + SIZELAB_WIDTH + EDIT_SPACE * 4, self.bounds.size.height - 25, TIMELAB_WIDTH, TIMELAB_HEIGHT);
        }
    }
}

//选中状态:添加选择状态的icon图标并改变其他元素的透明度
-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (_isEditing) {
        if (selected) {
            if (_isCell) {
                [self halfAlphaUI];
                _selecedIcon.frame = CGRectMake(self.bounds.size.width - ICON_WIDTH - 2, self.bounds.size.height - ICON_HEIGHT - 2, ICON_WIDTH, ICON_HEIGHT);
            } else {
                [self normalAlphaUI];
                _selecedIcon.frame = CGRectMake(EDIT_SPACE, (self.bounds.size.height - ICON_WIDTH) / 2, ICON_WIDTH, ICON_HEIGHT);
            }
            
        } else {
            if (_isCell) {
                [self normalAlphaUI];
            } else {
                [self halfAlphaUI];
                _unselecedIcon.frame = CGRectMake(EDIT_SPACE, (self.bounds.size.height - ICON_WIDTH) / 2, ICON_WIDTH, ICON_HEIGHT);
            }
        }
    }
}

//未选中状态下样式
- (void)normalAlphaUI {
//    _imageV.alpha = 1;
//    _nameLab.textColor = [UIColor blackColor];
//    _createTimeLab.textColor = [UIColor grayColor];
//    _sizeLab.textColor = [UIColor grayColor];
//    _selecedIcon.frame = CGRectZero;
//    _unselecedIcon.frame = CGRectZero;
}

//选中状态下样式
- (void)halfAlphaUI {
//    _imageV.alpha = 0.85;
//    _nameLab.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
//    _createTimeLab.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.85];
//    _sizeLab.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.85];
//    _selecedIcon.frame = CGRectZero;
//    _unselecedIcon.frame = CGRectZero;
}

//高亮效果
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
//    if (highlighted) {
//        self.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
//    } else {
//        [UIView animateWithDuration:0.1 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            self.contentView.backgroundColor = [UIColor whiteColor];
//        } completion:nil];
//    }
}

@end

