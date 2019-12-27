//
//  CollectionViewCell.h
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//


#import <UIKit/UIKit.h>

@class DJP_CellModel;

@interface UNCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, assign) BOOL isListCell;//0:列表视图,1:网格视图

@property (nonatomic, assign) BOOL isEditing;//0:不在编辑状态,1:在编辑状态

@property (nonatomic, strong) DJP_CellModel *model;//cell中元素数据源
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *sizeLabel;
@end
