//
//  HistoryTableViewCell.h
//  GQAllPlayer
//
//  Created by MAC on 09/12/2019.
//  Copyright © 2019 DJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^delBlock)(void);
typedef void(^faverateBlock)(void);
@interface UNHistoryTableViewCell : UITableViewCell
///地址label
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
///收藏按钮
@property (weak, nonatomic) IBOutlet UIButton *faverateBtn;

@property(nonatomic,copy)delBlock delBlock;
@property(nonatomic,copy)faverateBlock faverateBlock;

@property (nonatomic, strong)UILabel *bottomLine;
@end

NS_ASSUME_NONNULL_END
